import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import QtQuick.Dialogs
import Jooya
import QtQuick.Layouts
import "../../items/common"
import "../../jooyaQuickControls"
import "../../jsf/JSUtility.js" as Jsu;
import QtCore

Page {
    id:imageEditorPage
    property ImageFile imageFile: null
    property bool imageOpened: img.source !== "" && img.status === Image.Ready
    property bool imageEditing: false
    property bool clipImageSaved: false
    property size clipSize: Qt.size(100,100)
    property bool isFixedClipSize: true
    property string orginalUrl: ""
    property int reloadCount: 0
    Component.onCompleted: {
        console.log("imageFile.url => "+imageFile.url);
        reloadCount = urlUtility.getQueryValueAsInt("reload",imageFile.url);
        console.log("reloadCount => "+reloadCount);
        orginalUrl = urlUtility.removeAllQueries(imageFile.url);
        console.log("orginalUrl => "+orginalUrl);
    }
    function setimageurl(url){
        img.source = url;
        imageEditor.clipRect = Jsu.convertToQRect(rectClip);
        imageEditor.scaledImageRect =  Jsu.convertToQRect(rectScaledImage)
        imageEditor.imagePosition =  Qt.point(img.x,img.y)
    }
    UrlUtility{
        id:urlUtility
    }

    ImageUtility{
        id:imageUtility
    }
    ImageEditorUtility{
        id:imageEditor
        hasFixedClipRect: isFixedClipSize
        onClipRectChanged: {
            console.log("is updateing clip rect to new position or size")
            rectClip.x=imageEditor.clipRect.x
            rectClip.y=imageEditor.clipRect.y
            rectClip.width=imageEditor.clipRect.width
            rectClip.height=imageEditor.clipRect.height
        }
        onScaledImageRectChanged: {
            console.log("is updateing image to new position or size")
            img.x=imageEditor.scaledImageRect.x
            img.y=imageEditor.scaledImageRect.y
        }

    }
    Image {
        id:img
        fillMode: Image.PreserveAspectFit
        transform: Scale {
            id: myScale
            xScale: 1.0
            yScale: 1.0
            origin.x: pinchArea.width/2
            origin.y : pinchArea.height/2
        }
        //transformOrigin: Item.BottomRight // default is center
    }
    Rectangle{
        id:rectClip
        width: clipSize.width
        height: clipSize.height
        x:(parent.width-width)/2
        y:(parent.height-height)/2
        color: "transparent"
        border{
            color: "red"
            width: 2
        }
    }
    //this rect will draw a border around of scaled image(img)
    Rectangle{
        id:rectScaledImage
        property real tx: img.width-width
        property real ty: img.height-height

        x: img.x+tx/2
        y: img.y+ty/2
        //        anchors.centerIn: img
        width: img.width*img.scale
        height: img.height*img.scale
        color: "transparent"
        border{
            color: "green"
            width: 3
        }
        z:img.z+1
    }
    Text {
        id: txtImageCilppedImageWidth
        text: img.width + "px"
        anchors.bottom: rectScaledImage.bottom
        anchors.horizontalCenter: rectScaledImage.horizontalCenter
    }
    Text {
        id: txtImageCilppedImageHeight
        text: img.height + "px"
        anchors.right: rectScaledImage.right
        anchors.verticalCenter: rectScaledImage.verticalCenter
    }
    PinchArea {
        id: pinchArea
        anchors.fill: parent
        pinch{
            target: myScale
            minimumScale: 1
            maximumScale: 4
        }
        onPinchStarted: {
            console.log("onPinchStarted")

        }
        onPinchFinished: {
            console.log("onPinchFinished")
        }
        onPinchUpdated: {
            console.log("------------------< onPinchUpdated >-------------------")
            // calculate the new scale factor
            var scaleFactor = pinch.scale / pinch.previousScale
            if(scaleFactor==1){
                return;
            }
            console.log("scaleFactor=> "+scaleFactor);

            // update the image's scale and position
            // var oldScale = img.scale;
            img.scale *= scaleFactor

            // if(!isValidPosition(rectScaledImage,rectClip)){
            //     console.info("clip rect is going to protrude from scaled image so return");
            //     img.scale = oldScale;
            //     return;
            // }
        }
        MouseArea {
            id: dragArea
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onPressed: {
                console.log("mouse pressed ");
                ///save the last postion that mouse is pressed or drag started
                imageEditor.dragStartPosition = Qt.point(mouse.x,mouse.y);
            }

            onPositionChanged: {
                console.log("mouse position changed");
                if (mouse.buttons === Qt.LeftButton) {
                    imageEditor.currentPosition = Qt.point(mouse.x,mouse.y);
                    //                    if(imageEditor.currentOperation==ImageOperationTypes.ClipRectPosition)
                    //                    {
                    //                        var clipOldPosition = Qt.point(rectClip.x,rectClip.y);
                    //                        rectClip.x = clipNewPostion.x;
                    //                        rectClip.y = clipNewPostion.y;
                    //                        if(!isValidPosition(rectScaledImage,rectClip)){
                    //                            console.info("clip rect is going to protrude from scaled image so return");
                    //                            rectClip.x = clipOldPosition.x;
                    //                            rectClip.y = clipOldPosition.y;
                    //                            return;
                    //                        }
                    //                    }
                    //                    else if(imageEditor.currentOperation==ImageOperationTypes.ImagePosition)
                    //                    {
                    //                        var imgNewPostion  = Qt.point(dragStartPosImage.x + delta.x,dragStartPosImage.y + delta.y)

                    //                        var imgOldPosition = Qt.point(img.x,img.y);
                    //                        img.x = imgNewPostion.x;
                    //                        img.y = imgNewPostion.y;
                    //                        if(!isValidPosition(rectScaledImage,rectClip)){
                    //                            img.x = imgOldPosition.x;
                    //                            img.y = imgOldPosition.y;
                    //                            return;
                    //                        }
                    //                    }
                }
            }
            onWheel: {
                console.log("delta => "+wheel.angleDelta);
                // calculate the zoom factor based on the angle delta of the wheel event
                var zoomFactor = wheel.angleDelta.y > 0 ? 1.01 : 0.99;

                var oldScale = img.scale;
                // update the scale factor of the item
                img.scale *= zoomFactor;

                if(!isValidPosition(rectScaledImage,rectClip)){
                    console.info("clip rect is going to protrude from scaled image so return");
                    img.scale = oldScale;
                    return;
                }
                // prevent the default scrolling behavior
                wheel.accepted = true;
            }

        }


    }

    Component{
        id: fileDialogWin
        FileDialog {
            id: fileDialog
            title: "Please choose a file"
            fileMode: FileDialog.OpenFile
            currentFolder: StandardPaths.writableLocation(StandardPaths.HomeLocation)
            nameFilters: ["Picture Files(*.jpg *.png)"]
            onAccepted: {
                console.log("the selected file path => " +fileDialog.selectedFile);
                setimageurl(fileDialog.selectedFile);
            }
            onRejected: {
                close();
            }
        }
    }
    Pane{

        height: 54

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 18
        anchors.leftMargin: 18
        anchors.bottomMargin: 18
        padding: 0
        Material.elevation: 2
        Material.background: MaterialStyle.secondary100
        RowLayout{
            anchors.fill: parent
            layoutDirection: Qt.RightToLeft
            ToolButton{
                Layout.preferredHeight: 54
                Layout.preferredWidth: 54
                visible: !imageOpened
                contentItem: IconImage {
                    fillMode: Image.Pad
                    source: "../../images/common/folder-open.png"
                    color: MaterialStyle.iconColor
                }
                JooyaToolTip {
                    text: "باز کردن تصویر"
                }
                onClicked: {
                    var cd=fileDialogWin.createObject(mainWindow);
                    cd.open();
                }
            }
            ToolButton{
                Layout.preferredHeight: 54
                Layout.preferredWidth: 54
                visible: imageOpened
                contentItem: IconImage {
                    fillMode: Image.Pad
                    source: "../../images/common/cut.png"
                    color: MaterialStyle.iconColor
                }
                JooyaToolTip {
                    text: "برش تصویر"
                }
                onClicked: {
                    console.log("image was opened so cut and save it => ");
                    console.log("image.scale => " +img.scale);
                    console.log("scaled rect => "+Jsu.convertToQRect(rectScaledImage));
                    console.log("  clip rect => "+Jsu.convertToQRect(rectClip));
                    if(!imageUtility.loadFromPath(img.source))
                    {
                        console.log("image is not read from path");
                        return;
                    }
                    if(!imageUtility.clip(Qt.rect(rectClip.x-rectScaledImage.x,rectClip.y-rectScaledImage.y,rectClip.width,rectClip.height),img.scale))
                    {
                        console.log("cropping image was not succeed");
                        return;
                    }
                    console.log("is going to save image in this url=> "+imageFile.url);
                    if(!imageUtility.save(imageFile.url))
                    {
                        console.log("cropped image was not saved");
                        return;
                    }
                    reloadCount++;
                    imageFile.url = orginalUrl + "?reload="+reloadCount;
                    console.log("orginalUrl => "+orginalUrl);
                    console.log("imageFile.url => "+imageFile.url);
                    imageFile.uploadStatus = FileUploadStatus.NotStarted;
                    imageFile.isExists = true;
                    img.source = imageFile.url;
                    /// get image to visble area
                    // todo:make positon of it to center of page ImageEditorUtility.makeItToCenter ofpage
                    imageEditor.scaledImageRect.x = 0;
                    imageEditor.scaledImageRect.y = 0;
                }
            }
            ToolButton{
                Layout.preferredHeight: 54
                Layout.preferredWidth: 54
                visible: imageOpened
                contentItem: IconImage {
                    fillMode: Image.Pad
                    source: "../../images/common/resize.png"
                    color: MaterialStyle.iconColor
                }
                JooyaToolTip {
                    // text: "حذف تصویر"
                    text: "ریست کردن مکان تصویر"
                }
                onClicked: {
                    drawerResizeImage.open();
                }
            }
            Item {
                Layout.fillWidth: true
            }
        }
    }

    Drawer{
        id:drawerResizeImage
        width: parent.width
        height: 300
        edge: Qt.BottomEdge
        ColumnLayout{
            anchors.fill: parent
            spacing: 18
            TextFieldLabeld{
                id: tfWidth
                title: "پهنای تصویر"
                placeholderText2: "پهنای تصویر"
                text: img.width
                Layout.fillWidth: true
                Layout.preferredHeight: 54
                Layout.leftMargin: 18
                Layout.rightMargin: 18
            }
            JooyaButton{
                id:btnResize
                Layout.topMargin: 9
                text:"تغییر اندازه تصویر"
                onClicked: {
                    console.log("image was opened so cut and save it => ");
                    console.log("image.scale => " +img.scale);
                    console.log("scaled rect => "+Jsu.convertToQRect(rectScaledImage));
                    console.log("  clip rect => "+Jsu.convertToQRect(rectClip));
                    if(!imageUtility.loadFromPath(img.source))
                    {
                        console.log("image is not read from path");
                        return;
                    }
                    imageUtility.resize(tfWidth.text,img.height);

                    console.log("is going to save image in this url=> "+imageFile.url);
                    if(!imageUtility.save(imageFile.url))
                    {
                        console.log("cropped image was not saved");
                        return;
                    }
                    reloadCount++;
                    imageFile.url = orginalUrl + "?reload="+reloadCount;
                    console.log("orginalUrl => "+orginalUrl);
                    console.log("imageFile.url => "+imageFile.url);
                    imageFile.uploadStatus = FileUploadStatus.NotStarted;
                    imageFile.isExists = true;
                    img.source = imageFile.url;
                    /// get image to visble area
                    // todo:make positon of it to center of page ImageEditorUtility.makeItToCenter ofpage
                    imageEditor.scaledImageRect.x = 0;
                    imageEditor.scaledImageRect.y = 0;

                }
            }
        }
    }
}

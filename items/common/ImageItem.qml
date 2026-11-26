import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import Jooya
import "../../jooyaQuickControls"

Item{
    id:imgContainer

    property ImageFile imageFile
    property string defaultImageUrl: "../../images/common/image-filter-hdr.png"
    property bool hasImage: imageFile != null
    property alias image: img
    property int imageFillMode: Image.PreserveAspectFit
    Image {
        id: imgDefualt
        source:defaultImageUrl
        width: 27
        height: 27
        visible: !img.visible
        anchors.centerIn: parent
        fillMode: Image.Pad
    }
    Image {
        id:img
        visible: hasImage&&imageFile.isExists
        anchors.centerIn: parent
        source: (hasImage&&imageFile.isExists)? imageFile.url:""
        width: parent.width
        height: parent.height
        fillMode: imageFillMode
    }
    ProgressBar{
        visible: hasImage&&imageFile.isProcessing
        from: 0
        to: 1
        height: 3
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        indeterminate: true
    }
    RoundButton {
        id: btnDownload
        width: 72
        height: 72
        highlighted: true
        visible: hasImage&&!imageFile.isExists&&!imageFile.isProcessing&&imageFile.fileId!=0&&(imageFile.downloadState===FileDownloadStates.Faild||imageFile.downloadState===FileDownloadStates.ErrorInSaving)
        anchors.centerIn: parent
        Material.elevation: 1
        contentItem: Image {
            fillMode: Image.Pad
            source: "../../images/common/download.png"
        }
        JooyaToolTip {
            text:"دانلود عکس"
        }
        onClicked: {
            console.log("image item btn download clicked")
            imageFile.download();
        }
    }
}


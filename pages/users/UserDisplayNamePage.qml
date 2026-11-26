import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import Jooya
import QtQuick.Dialogs
import "../../jooyaQuickControls"

Page{
    id: root
    objectName: "UserDisplayNamePage"
    Component.onCompleted: {
        imgFile.download();
        up.getDisplayName();
    }
    UserProfile{
        id: up
        onProfileChanged: {
            baseUser.getUserInfo();
            displayHomePage();
        }
        onImageLoadingChanged: {
            if(argLoaded){
                btnUploadPic.visible=true;
                btnSelectPic.visible=false;
            }
            else{
                btnUploadPic.visible=false;
                btnSelectPic.visible=true;
            }
        }
        onImageWasUploaded: {
            btnUploadPic.visible=false;
            btnSelectPic.visible=true;
        }
    }
    ImageFile {
        id:imgFile
        downloadLink: "/Images/InsertPhoneNumber.jpg"
    }
    Flickable{
        anchors.fill: parent
        contentHeight: mainClm.implicitHeight + 45
        //================================================
        ColumnLayout{
            id: mainClm
            anchors.fill: parent
            spacing: 20
            Rectangle{
                Layout.fillWidth: true
                Layout.minimumHeight: imgFile.isExists ? img.height:270
                clip: true
                color: MaterialStyle.primary100
                Image {
                    id: imgDefualt
                    source: "../../images/common/image-filter-hdr.png"
                    width: 27
                    height: 27
                    visible: !img.visible
                    anchors.centerIn: parent
                    fillMode: Image.Pad
                }
                Image {
                    id:img
                    visible: imgFile.isExists
                    anchors.centerIn: parent
                    source: imgFile.isExists? imgFile.url:""
                    width: parent.width
                    fillMode: Image.PreserveAspectFit
                }
                ProgressBar{
                    visible: imgFile.isProcessing
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
                    visible: !imgFile.isExists&&!imgFile.isProcessing
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
                        imgFile.download();
                    }
                }
            }
            Rectangle{
                color: MaterialStyle.primary100
                Layout.fillWidth: true
                Layout.preferredHeight: txtMessage.implicitHeight+18
                Layout.leftMargin: 9
                Layout.rightMargin: 9
                Text{
                    id:txtMessage
                    anchors.fill: parent
                    wrapMode: Text.Wrap
                    padding: 18
                    bottomPadding: 0
                    color: MaterialStyle.primaryTextColor
                    font{
                        family: flYekan.name
                        pixelSize: 14
                    }
                    text:"نام خود را در کادر زیر وارد کنید.افراد در اپلیکیشن "+CurrentApplication.name+" شما را با این نام می شناسند.این نام می تواند نام حقیقی شما یا هر چیز دیگری باشد"
                }
            }
            TextFieldLabeld{
                id: tfDisplayName
                title: "نام شما در " + CurrentApplication.name
                placeholderText2: "نام شما در " + CurrentApplication.name
                text: up.displayName
                Layout.fillWidth: true
                Layout.preferredHeight: 54
                Layout.leftMargin: 18
                Layout.rightMargin: 18
                EnterKey.type: Qt.EnterKeyDone
            }
            Item {
                Layout.fillHeight: true
            }
            JooyaButton{
                id: btnSave
                text: "تایید"
                Layout.fillWidth: true
                highlighted: true
                onClicked: {
                    up.saveDisplayName(tfDisplayName.text);
                }
            }
        }
    }
    ProgressIndicator{
        visible: up.isProcessing
    }
}

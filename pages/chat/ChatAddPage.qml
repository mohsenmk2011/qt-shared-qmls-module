import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Dialogs
import "../../jooyaQuickControls"
import "../users"
import "../../jsf/Bootstrap.js" as Bs
import Jooya
import JooyaQuick.Controls.Material

Page{
    id: root
    objectName: "ChatAddPage"
    property Chat currentChat: null
    JooyaFlickable{
        id: flickable
        anchors.fill: parent
        contentHeight: mainClm.implicitHeight
        flickableDirection: Flickable.AutoFlickIfNeeded
        clip: true
        ColumnLayout {
            id: mainClm
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 9
            Pane{
                id:pnContainer
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 243
                Layout.preferredHeight: 243
                Layout.topMargin: 18
                Layout.rightMargin: 27
                Layout.leftMargin: 27
                padding: 9
                Material.elevation: 1
                Material.background: MaterialStyle.primary100
                ImageRectItem{
                    width: parent.width
                    height: parent.height
                    imageFile: currentChat.image
                    onDeleteItem: {
                        console.log("item deleted id=> "+itemId);
                    }
                }
                RoundButton {
                    Material.elevation: 2
                    width: 72
                    height: 72
                    highlighted: true
                    enabled: ! currentChat.image.isProcessing
                    anchors.top: parent.bottom
                    anchors.topMargin: -width/2
                    anchors.right: parent.right
                    anchors.rightMargin: 9
                    contentItem: Image {
                        fillMode: Image.Pad
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: !currentChat.image.isExists ? "../../images/common/upload.png" : "../../images/common/delete.png"
                    }
                    JooyaToolTip {
                        text: !currentChat.image.isExists ? "آپلود کردن عکس":"حذف کردن عکس"
                    }
                    onClicked: {
                        if(currentChat.type==ChatTypes.FrequentQuestions){
                            MessageBoard.setContent("سوالات متداول تصویر ندارد");
                            return;
                        }
                        if(currentChat.image.isExists){
                            deleteDialog.open();
                        }
                        else{
                        }
                    }
                }
            }
            JooyaTextField{
                id: tfDisplayName
                Layout.topMargin: 36
                placeholderText: "نام گفتگو"
                Layout.fillWidth: true
                text: currentChat.chatName
                onTextChanged: {
                    currentChat.chatName=text;
                }
            }
            JooyaButton{
                id: btnSave
                text:currentChat.chatId==""? "ذخیره" :"ویرایش"
                Layout.fillWidth: true
                highlighted: true
                onClicked: {
                    currentChat.save();
                }
                onFocusChanged: {
                    if(focus){
                        flickable.bringYToVisibleArea(y+height);
                    }
                }
            }
            Item {
                Layout.fillHeight: true
            }
        }
        ScrollBar.vertical: ScrollBar{
            width: 9
        }
    }
    ConfirmationDialog {
        id:deleteDialog
        message: "آیا مایل هستید تصویر را حذف کنید؟"
        onYesClicked: {
            currentChat.image.deleteItem();
        }
    }
}

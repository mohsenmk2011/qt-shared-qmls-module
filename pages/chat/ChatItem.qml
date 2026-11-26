import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import QtQuick.Layouts
import "../../jsf/Bootstrap.js" as Bs
import Jooya
import "../../jooyaQuickControls"

Rectangle {
    id:chatItemRect
    property Chat chat: null
    color: chat.isSelected ? MaterialStyle.secondary200: MaterialStyle.secondary100
    height: mainTalkRow.implicitHeight
    property bool isLastItem: index+1==gvChats.count
    Connections{
        target:chat
        function onIsProcessingChanged(isProcessing) {
        }
    }
    MouseArea {
        anchors.fill: parent
        onPressAndHold: {
            if(!chatManager.selectMode){
                chatManager.selectMode=true;                
                chat.isSelected=true;
            }
        }
        onClicked: {
            console.log("chat=>chatId=> "+chat.chatId);
            console.log("chat=>type=> "+chat.type);
            if(chatManager.selectMode){
                chat.isSelected=!chat.isSelected;
            }
            else{
                if(chat.type===ChatTypes.Conversation){
                    sv.push("ChatPage.qml",{chat:chat});
                }
                else if(chat.type===ChatTypes.Channal){
                    sv.push("ChatPage.qml",{chat:chat});
                }
                else if(chat.type===ChatTypes.Group){
                    sv.push("ChatPage.qml",{chat:chat});
                }
                else if(chat.type===ChatTypes.FrequentQuestions){
                    sv.push("ChatPage.qml",{chat:chat});
                }
            }
        }
    }
    RowLayout{
        anchors.fill: parent
        anchors.margins: 9
        layoutDirection: Qt.RightToLeft
        spacing: 9
        CircleImage {
            id:userImage
            width: 72
            height: 72
            Layout.alignment: Qt.AlignRight|Qt.AlignVCenter
            source:chat.image.isExists? chat.image.url:""
            sourceDefault: "../../images/common/account.png"
        }
        Item {
            Layout.fillWidth: true
        }
        ColumnLayout{
            Layout.fillWidth: true
            Layout.fillHeight: true
            RowLayout{
                Layout.fillWidth: true
                Layout.preferredHeight: (chatItemRect.height-18)/(3*2)
                layoutDirection: Qt.RightToLeft
                Text {
                    text: chat.chatName
                    Layout.alignment: Qt.AlignRight
                    font{
                        family:flIranSanse.name
                        pixelSize: 22
                    }
                    color: MaterialStyle.primaryTextColor
                }
                Rectangle{
                    width: txtIsOnline.width+18
                    height: txtIsOnline.height
                    radius: width/2
                    visible:chat.type===ChatTypes.Conversation && chat.contact!==undefined && chat.contact.isOffline
                    color: Material.color(Material.Green)
                    Text {
                        id:txtIsOnline
                        text:  "آنلاین"
                        color:"white"
                        anchors.centerIn: parent
                        font{
                            pixelSize: 13
                            family: flYekan.name
                            bold: true
                        }
                    }
                }
                Rectangle{
                    width: txtIsOffline.width+18
                    height: txtIsOffline.height
                    radius: width/2
                    visible:chat.type===ChatTypes.Conversation && chat.contact!==undefined && chat.contact.isOffline
                    color: Material.color(Material.Red)
                    Text {
                        id:txtIsOffline
                        text:  "آفلاین شد"
                        color:"white"
                        anchors.centerIn: parent
                        font{
                            pixelSize: 13
                            family: flYekan.name
                            bold: true
                        }
                    }
                }
                Item {
                    Layout.fillWidth: true
                }
                Text {
                    text: chat.lastTalkDate
                    Layout.alignment: Qt.AlignRight
                    font{
                        family:flIranSanse.name
                        pixelSize: 13
                    }
                    color: MaterialStyle.primaryTextColor
                }
            }
            RowLayout{
                Layout.fillWidth: true
                Layout.preferredHeight: (chatItemRect.height-18)/3
                layoutDirection: Qt.RightToLeft
                Text{
                    text: chat.lastTalk
                    visible: !rectIsTyping.visible
                    clip: true
                    Layout.alignment: Qt.AlignRight|Qt.AlignVCenter
                    Layout.fillWidth: true
                    Layout.maximumHeight: 18
                    font{
                        family:flIranSanse.name
                        pixelSize: 13
                    }
                    color: MaterialStyle.primaryTextColor
                }
                Rectangle{
                    id:rectIsTyping
                    width: txtIsTyping.width+18
                    height: txtIsTyping.height
                    radius: width/2
                    visible: chat.isTyping
                    color: Material.color(Material.Green)
                    Text {
                        id:txtIsTyping
                        text:  "در حال تایپ"
                        color:"white"
                        anchors.centerIn: parent
                        font{
                            pixelSize: 13
                            family: flYekan.name
                            bold: true
                        }
                    }
                }
                Item {
                    Layout.fillWidth: true
                }
                RoundButton{
                    property bool stateVisible: chat.unReadTalks>0
                    Layout.alignment: Qt.AlignLeft|Qt.AlignVCenter
                    Layout.bottomMargin: 9
                    width: 36
                    height: 36
                    highlighted: true
                    contentItem: Text {
                        text: chat.unReadTalks
                        font{
                            family:flYekan.name
                            pixelSize: 12
                            bold: true
                        }
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: "white"
                    }
                    Material.elevation: 1
                    scale: stateVisible?1.0:0.0
                    Behavior on scale {
                        NumberAnimation{
                            easing.type: Easing.InOutBounce
                            duration: 100
                        }
                    }
                }
            }
        }
    }
    Separator {
        id:seperator
        color: MaterialStyle.secondary200
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width*0.72
        visible: !isLastItem
    }
}

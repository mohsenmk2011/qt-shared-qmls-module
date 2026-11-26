import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../jooyaQuickControls"
import Jooya
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import "../../items/common"
import QtQuick.Shapes
import "../users"
import QtWebSockets

Page{
    id:chatsPage
    objectName: "ChatsPage"
    QmlLive.onFileChanged:{
        console.log("QmlLive.onFileChanged(in ChatsPage.qml) => "+fileName);
        console.log("Qsv.currentItem.objectName => "+sv.currentItem.objectName);

        if(fileName==="ChatPage"){
            if(sv.currentItem.objectName==="ChatsPage"){
                sv.replaceEnter.enabled=false;
                QmlLive.clearCache();
                sv.push("ChatPage.qml");
            }
        }
    }
    property ChatManager chatManager: null

    Shortcut {
        id: backShortcutChatsPage
        sequences: ["Esc", "Back"]
        enabled: chatsPage.visible
        context: Qt.ApplicationShortcut
//        context: Qt.WindowShortcut
        onActivated: {
            console.log("Back Shortcut In ChatsPage")
            if(chatManager.selectMode){
                chatManager.selectMode=false;
                return;
            }
            if(sv.depth>1)
            {
                sv.pop();
            }
            else if(drawer.visible){
                drawer.close();
            }
            else{
                exitDialog.open();
            }
        }
    }
    Connections{
        target: chatManager
        function onNoChatFounded() {
            console.log("No Chat founded => display the message");
            btnNewChat.stateVisible=true
        }
        function onSelectModeChanged() {
            tbMain.visible = !chatManager.selectMode;
            backShortcut.enabled = !chatManager.selectMode
        }
        function onNewChatStarted(newChat) {
            sv.push("ChatPage.qml",{chat:newChat});
        }
    }
    Component.onDestruction: {
        backShortcut.enabled=true;
    }
    Component.onCompleted: {
        backShortcut.enabled=false;
        btnNewChat.stateVisible=true;
        chatManager.sendIAmOnline();
        chatManager.getList();
    }
    header: ToolBar {
        id: tbChats
        visible:chatManager.selectMode
        padding: 0
        Material.elevation: 2
        RowLayout{
            anchors.fill: parent
            spacing: 1
            ToolButton {
                id: tbtnCancel
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    width: 27
                    height: 27
                    source: "../../images/common/window-close.png"
                }
                onClicked: {
                    chatManager.selectMode=false;
                }
            }
            Label{
                Layout.fillWidth: true
                font{
                    pixelSize: 20
                    family: flYekan.name
                }
                verticalAlignment: Label.AlignVCenter
                horizontalAlignment: Label.AlignHCenter
                visible:true
                text: chatManager.selectedCount
                color: "white"
            }
//            ToolButton {
//                id: tbtnMuteChat
//                visible: chatManager.selectMode && chatManager.selectedCount==1
//                contentItem: Image {
//                    fillMode: Image.Pad
//                    horizontalAlignment: Image.AlignHCenter
//                    verticalAlignment: Image.AlignVCenter
//                    width: 27
//                    height: 27
//                    source: (chatManager.selectMode && chatManager.selectedChat.isMuted) ? "../../images/media/volume-high.png": "../../images/media/volume-mute.png"
//                }
//                onClicked: {
//                }
//            }
//            ToolButton {
//                id: tbtnArchave
//                visible: chatManager.selectMode
//                contentItem: Image {
//                    fillMode: Image.Pad
//                    horizontalAlignment: Image.AlignHCenter
//                    verticalAlignment: Image.AlignVCenter
//                    width: 27
//                    height: 27
//                    source: "../../images/common/white-balance-sunny.png"
//                }
//                onClicked: {
//                }
//            }
            ToolButton {
                id: tbtnDelete
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    width: 27
                    height: 27
                    source: "../../images/common/delete.png"
                }
                onClicked: {
                    chatManager.deleteChats();
                }
            }
            Item {
                Layout.fillWidth: true
            }
            ToolButton {
                id: btnMainMenu
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    width: 27
                    height: 27
                    source: "../../images/common/dots-vertical.png"
                }
                onClicked: {
                    if(mnuMain.visible){
                        mnuMain.close();
                    }
                    else{
                        mnuMain.open();
                    }
                }
            }
            Menu{
                id: mnuMain
                font.family: flYekan.name
                x:mainWindow.width-width
                y: btnMainMenu.height
                MenuItem{
                    contentItem: Text {
                        text: qsTr("انتخاب همه")
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                        font.family:flYekan.name
                        font.pixelSize: 18
                        color: MaterialStyle.primaryTextColor
                    }
                    onTriggered: {
                        chatManager.selectAll();
                    }
                }
            }
        }
    }
    JooyaGridView {
        id: gvChats
        anchors.fill: parent
        cellWidth:parent.width
        cellHeight:90
        delegate: ChatItem {
            width: gvChats.cellWidth
            height: gvChats.cellHeight
            chat: model
        }
        model: chatManager.listModel

        onScrolledUp: {
            btnNewChat.stateVisible=false;
        }
        onScrolledDown: {
            btnNewChat.stateVisible=true;
        }
    }
    HelpBar{
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        visible: gvChats.count===0
        height: btnNewChat.height+btnNewChat.anchors.bottomMargin
        color:MaterialStyle.primary100
        helpText: qsTr("برای شروع گفتگو اینجا کلیک نمایید")
    }
    Rectangle {
        Text {
            id:txtStartChat

            font{
                family: flYekan.name
                pixelSize: 18
                bold: true
            }
            color: MaterialStyle.iconColor
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.leftMargin: 117
        }
    }
    RoundButton{
        id: btnNewChat
        property bool stateVisible: false
        width: 72
        height: width
        highlighted: true
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        contentItem: Image {
            fillMode: Image.Pad
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../../images/chat/message-reply-text.png"

        }
        onClicked: {
            console.log("backShortcutChatsPage.enabled => "+backShortcutChatsPage.enabled);
            console.log("backShortcut.enabled => "+backShortcut.enabled);
            var c= comContactsDialog.createObject(parent);
            c.open();
        }
        Material.elevation: 3
        scale: stateVisible?1.0:0.0
        Behavior on scale {
            NumberAnimation{
                easing.type: Easing.InOutBounce
                duration: 150
            }
        }
    }
    Component{
        id:comContactsDialog
        ContactsDialog{
            id:contactsDialog
        }
    }
}

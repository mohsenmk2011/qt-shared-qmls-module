import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../jooyaQuickControls"
import Jooya
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import QtMultimedia
import QtQuick.Controls.Material.impl
import QtQuick.Shapes
import "../../items/common"

Page{
    id:chatPage
    property bool isPageLoaded: false
    objectName: "ChatPage"
    property Chat chat: null
    Connections{
        target: chat

        function onNewTalkReceived(soundFileUrl) {
            console.log(" &&&[ New Post Received ]&&& ")
            if(!chat.isMuted){
                console.log("sound file url=> "+soundFileUrl)
                aPlayer.source=soundFileUrl;
                aPlayer.play();
            }
            if(lvPosts.countOfItemBottomOfVisibleArea()>9){
                btnGoToEndOfList.isVisible=true;
            }
            else{
                lvTalksScrollbar.position=1.0;
                btnGoToEndOfList.isVisible=false;
            }
        }
        function onNewPostIsSended() {
            txtSendingTalk.clear();
            lvTalksScrollbar.position=1.0;
            btnGoToEndOfList.isVisible=false;
            console.log("$$$$$onNewTalkIsSending$$$$$$")
        }
        function onPostSendSucceed(soundFileUrl) {
            if(!chat.isMuted){
                console.log("sound file url=> "+soundFileUrl)
                aPlayer.source=soundFileUrl;
                aPlayer.play();
            }
        }
        function onSelectModeChanged() {
            console.log("onSelectModeChanged In ChatPage =>" + chat.selectMode);
//            backShortcut.enabled= !chat.selectMode
        }
        function onGetTalkFinishd(succeed) {
            console.log("^^^[ getTalkFinishd =>"+succeed+" ]^^^")
        }
    }
    Shortcut {
        id: backShortcutChatPage
        sequences: ["Esc", "Back"]
//        context: Qt.WindowShortcut
        context: Qt.ApplicationShortcut
        enabled: chatPage.visible
        onActivated: {
            console.log("Back Shortcut In ChatPage")
            if(chat!=null){
                if(chat.selectMode){
                    chat.selectMode=false;
                    return;
                }
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
    Component.onDestruction: {
        console.log("ChatPage.qml => Component.onDestruction");
        tbMain.visible=true;
        chat.removeIfIsEmpty();
    }
    Component.onCompleted: {
        isPageLoaded=true;
        tbMain.visible=false;
        lvTalksScrollbar.position=1.0;
        chat.getPosts();
        console.log("&&&&&&&&[ChatPage.qml =>  Component.onCompleted ]&&&&&&&&&&&&");
    }
    header: ToolBar {
        id: tbChat
        padding: 0
        Material.elevation: 2
        visible:chat!=null
        RowLayout{
            id:rowContactInfo
            visible: !chat.selectMode
            anchors.fill: parent
            spacing: 1
            ToolButton {
                id: tbtnBack
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    width: 27
                    height: 27
                    source: "../../images/common/back.png"
                }
                onClicked: {
                    tbMain.visible=true;
                    sv.pop();
                }
            }
            Item {
                Layout.fillWidth: true;
            }
            //TODO: add label for last view date of contatct
            Label{
                id: lblIsTyping
                font{
                    pixelSize: 15
                    family: flIranSanse.name
                }
                visible: chat.isTyping
                text: "در حال تایپ ..."
                color: "white"
                verticalAlignment: Label.AlignVCenter
                horizontalAlignment: Label.AlignHCenter
                Layout.rightMargin: 9
            }
            Label{
                id: lblChatName
                font{
                    pixelSize: 15
                    family: flIranSanse.name
                }
                text: chat.chatName
                color: "white"
                verticalAlignment: Label.AlignVCenter
                horizontalAlignment: Label.AlignHCenter
                Layout.rightMargin: 9
            }
           CircleImage {
               id:userImage
               width: 45
               height: 45
               source: chat.image.isExists ? chat.image.url:""
               sourceDefault: "../../images/common/account.png"
               Layout.alignment: Qt.AlignRight|Qt.AlignVCenter
           }
            ToolButton {
                id: btnChatMenu
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    width: 27
                    height: 27
                    source: "../../images/common/dots-vertical.png"
                }
                onClicked: {
                    if(mnuChat.visible){
                        mnuChat.close();
                    }
                    else{
                        mnuChat.open();
                    }
                }
            }
            Menu{
                id: mnuChat
                objectName: "mainMenu"
                font.family: flYekan.name
                x:mainWindow.width-width
                y: btnChatMenu.height
                MenuItem{
                    contentItem: Text {
                        text: chat.isMuted? qsTr("با صدا کردن هشدار"):qsTr("بی صدا کردن هشدار")
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                        font.family:flYekan.name
                        font.pixelSize: 18
                        color: MaterialStyle.primaryTextColor
                    }
                    height: visible ? implicitHeight : 0
                    onClicked: {
                        chat.isMuted=!chat.isMuted;
                    }
                }
            }
        }
        RowLayout{
            id:rowSelectMode
            visible: chat.selectMode
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
                    chat.selectMode=false;
                }
            }
            Label{
                id: lblChatCount
                Layout.fillWidth: true
                font{
                    pixelSize: 20
                    family: flYekan.name
                }
                verticalAlignment: Label.AlignVCenter
                horizontalAlignment: Label.AlignHCenter
                visible:true
                text: chat.selectedCount
                color: "white"
            }

            ToolButton {
                id: tbtnDelete
                visible: chat.type!=ChatTypes.FrequentQuestions||(chat.type==ChatTypes.FrequentQuestions&&chat.selectedCount==1)
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    width: 27
                    height: 27
                    source: "../../images/common/delete.png"
                }
                onClicked: {
                    chat.deletePosts();
                }
            }
            ToolButton {
                id: tbtnEdit
                visible: chat.selectedCount==1
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    width: 27
                    height: 27
                    source: "../../images/common/pencil.png"
                }
                onClicked: {
                    if(chat.selectedCount==1){
                        txtSendingTalk.text=  chat.selectedPost.content;
                    }
                }
            }
            ToolButton {
                id: btnTalksMenu
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    width: 27
                    height: 27
                    source: "../../images/common/dots-vertical.png"
                }
                onClicked: {
                    if(mnuTalks.visible){
                        mnuTalks.close();
                    }
                    else{
                        mnuTalks.open();
                    }
                }
            }
            Menu{
                id: mnuTalks
                font.family: flYekan.name
                x:mainWindow.width-width
                y: btnChatMenu.height
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
                        chat.selectAll();
                    }
                }
            }
        }
    }
    MediaPlayer{
        id:aPlayer
         audioOutput: AudioOutput {}
    }
    ListView {
        id:lvPosts
//        boundsBehavior: Flickable.OvershootBounds
        function distaceToEnd(){
            return 1.0-visibleArea.yPosition;
        }
        function countOfItemBottomOfVisibleArea(){
            var count=-1;
            //NOTE: count Of Item Bottom Of VisibleArea
            var lastVisibleItemIndex= lvPosts.indexAt(lvPosts.width/2,lvPosts.contentY+lvPosts.height);

            if(lastVisibleItemIndex===-1){
                return -1;
            }
            console.log("index => "+lastVisibleItemIndex);
            count=lvPosts.count-lastVisibleItemIndex;
            console.log("count => "+count);
            return count;
        }
        function isVisible(y){
            return isInBorder(y,lvPosts.contentY,lvPosts.contentY+lvPosts.height);
        }
        function isInBorder(x1,bx1,bx2){
            return x1>=bx1&&x1<=bx2;
        }
        spacing: 3
        clip: true
        anchors.fill: parent
        bottomMargin: 0
        topMargin: 18

        model: chat.posts
        delegate:PostItem {
            id:postItem
            ballonMaxWidth: lvPosts.width*0.81
            post:model
            width: lvPosts.width
        }
        ScrollBar.vertical: ScrollBar{
            id:lvTalksScrollbar
            width: 9            
        }
        property real startedY: 0
        visibleArea.onHeightRatioChanged: {
            console.log("visibleArea.heightRatio => "+visibleArea.heightRatio);
        }
        onMovementStarted: {
            console.log(" ***[ Movement Started -> set startedY ]*** ")
            console.log("visibleArea.yPosition=> "+lvPosts.visibleArea.yPosition)
            console.log("contentY=> "+lvPosts.contentY)
            startedY=lvPosts.contentY;
        }
        onMovementEnded: {
            console.log(" ***[ Movement Ended -> return ]*** ")
            console.log("visibleArea.yPosition=> "+lvPosts.visibleArea.yPosition)
            console.log("contentY=> "+lvPosts.contentY)
            var endedY=lvPosts.contentY;

            //NOTE:Scroll down and up signals in list
            if(lvPosts.visibleArea.heightRatio>=0.45){
                console.log("visibleArea.heightRatio("+visibleArea.heightRatio+") is bigger than 0.45 => return");
                return;
            }
            var minMovement=9;
            var movement=Math.abs(endedY-startedY);
            console.log("movement -> "+movement)
            console.log("minMovement -> "+minMovement)
            if(movement<minMovement){
                console.log("movement<minMovement => is not moved enugh ->return")
                return;
            }

            if(endedY>startedY)
            {
                console.log("scrolling Down")
                if(lvPosts.countOfItemBottomOfVisibleArea()<=9){
                    console.log(" scroll bar is near to end of list hide the button of GoToEnd")
                    btnGoToEndOfList.isVisible=false;
                }
                else{
                    btnGoToEndOfList.isVisible=true;
                }
            }
            else if(endedY<startedY)
            {
                console.log("scrolling Up")
                if(chat.unReadTalks>0&&lvPosts.countOfItemBottomOfVisibleArea()>9){
                    btnGoToEndOfList.isVisible=true;
                }
                else{
                    btnGoToEndOfList.isVisible=false;
                }
            }
        }
    }

    RoundButton {
        id: btnGoToEndOfList
        Material.elevation: 3
        Material.accent: Material.color(Material.Grey,Material.Shade50)
        focusPolicy: Qt.NoFocus
        property bool isVisible: false
        width: 63
        height: 63
        highlighted: true
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: 9
        contentItem: IconImage {
            fillMode: Image.Pad
            color: MaterialStyle.iconColor
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../../images/chat/chevron-down.png"
        }
        onClicked: {
            console.log("btnGoToEndOfList clicked");
            lvTalksScrollbar.position=1.0
            isVisible=false;
        }
        scale: isVisible?1.0:0.0
        Behavior on scale {
            NumberAnimation{
                easing.type: Easing.InOutBounce
                duration: 90
            }
        }
    }
    Rectangle{
        width: 36
        height: 36
        radius: width/2
        visible: btnGoToEndOfList.isVisible&& chat.unReadTalks>0
        color: Material.color(MaterialStyle.secondary)
        anchors.bottom: btnGoToEndOfList.bottom
        anchors.right: btnGoToEndOfList.right
        anchors.bottomMargin: 36
        anchors.rightMargin: 27

        Text {
            text: chat.unReadTalks
            color: "white"
            anchors.centerIn: parent
            font{
                pixelSize: 9
                bold: true
                family: flYekan.name
            }
        }
    }
    footer:Rectangle{
        id:footerRect
        color: MaterialStyle.secondary100
        height: txtSendingTalk.implicitHeight+12
        RowLayout{
            id:rowSendMessage
            anchors.fill: parent
            spacing: 9
            RoundButton{
                id:btnSend
                focusPolicy: Qt.NoFocus
                highlighted: true
                Layout.preferredHeight: 63
                Layout.preferredWidth: 63
                Layout.alignment: Qt.AlignBottom
                Material.elevation: 1
                onClicked: {
                    Qt.inputMethod.reset();
                    if(chat==null)
                    {
                        MessageBoard.content="گفتگو خالی است"
                        return;
                    }
                    if(chat.selectMode&&chat.selectedCount==1)
                    {
                        chat.editSelectedPost(txtSendingTalk.text);
                    }
                    else{
                        chat.send(txtSendingTalk.text);
                    }
                }
                contentItem: Image {
                    source: "../../images/chat/send.png"
                    fillMode: Image.Pad
                    width: 27
                    height: 27
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Flickable{
                id:flickSendingTalk
                Layout.alignment: Qt.AlignBottom
                Layout.margins: 0
                Layout.bottomMargin: 3
                Layout.topMargin: 6
                Layout.rightMargin: 6

                contentHeight: txtSendingTalk.implicitHeight
                contentY : contentHeight-height
                Layout.fillHeight: true
                Layout.fillWidth: true

                interactive: false
                boundsBehavior: Flickable.StopAtBounds

                TextArea {
                    id: txtSendingTalk
                    anchors.fill: parent
                    clip: true
                    wrapMode: TextArea.Wrap
                    color: MaterialStyle.primaryTextColor
                    background: Rectangle{
                        radius: 3
                        color: MaterialStyle.secondary200
                        border.width: 1
                        border.color: MaterialStyle.secondary300
                    }
                    padding: 0
                    rightPadding: 9
                    leftPadding: 9
                    selectByMouse: true
                    font{
                        family: flYekan.name
                    }
                    onTextChanged: {
//                        if(!isPageLoaded){
//                            return;
//                        }
                        console.log("onTextChanged=> "+text)
                        if(txtSendingTalk.length>0){
                            chat.sendIsTyping();
                        }
                    }
                }
            }
        }
    }
}

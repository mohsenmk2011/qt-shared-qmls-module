import QtQuick
import QtQuick.Controls
import "../../jsf/Bootstrap.js" as Bs
import Jooya
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import "../../jooyaQuickControls"
import QtQuick.Layouts

Dialog {
    id:root
    Material.roundedScale: Material.NotRounded
    padding: 0
    parent: Overlay.overlay
    x:root.width===mainWindow.width?0:(mainWindow.width-root.width)/2
    height: mainWindow.height
    width: Bs.bootSize(mainWindow.width,"xs-12 sm-11 md-7 lg-4 xl-4")
    Connections{
        target: chatManager
        function onNewChatStarted() {
            close();
        }
    }
    Component.onCompleted: {
        chatManager.contactManager.getList();
    }
    Component.onDestruction: {
        chatManager.contactManager.saveInFile();
    }
    header: ToolBar{
        id: tbheader
        Material.elevation:1
        anchors.bottomMargin: 0
        Row{
            anchors.fill: parent
            anchors.margins: 0
            ToolButton{
                contentItem: Image {
                    source: "../../images/common/window-close.png"
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                }
                onClicked: {
                    close();
                }
            }
        }
    }
    contentItem: GridView {
        id: gvContacts
        anchors.fill: parent
        anchors.topMargin: tbheader.height
        cellWidth:parent.width
        cellHeight:81
        delegate: ContactItem {
            width: gvContacts.cellWidth
            height: gvContacts.cellHeight
            contact: model
        }
        model: chatManager.contactManager.listModel
    }
    ProgressIndicator{
        id: bipi
        visible: chatManager.contactManager.isProcessing
    }
}

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import Jooya
import QtQuick.Layouts

Popup{
    id: bar
    Material.background: MessageBoard.backColor
    Material.elevation: 5
    parent: Overlay.overlay
    anchors.centerIn: parent
    width: visible?implicitWidth:0
    height: visible?implicitHeight:0
    Label {
        id:messageContent
        color: "white"
        text: MessageBoard.content
        anchors.fill: parent
        horizontalAlignment: Label.AlignHCenter
        wrapMode: Label.Wrap
        font {
            family: flYekan.name
            pixelSize: 12
        }
    }
    visible: MessageBoard.visible&&MessageBoard.messageType=== Message.SimpleMessage
}

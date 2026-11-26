import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Material
import Jooya
import QtQuick.Layouts

Window {
    flags:  Qt.Window | Qt.WindowStaysOnTopHint

    property alias message:me
    Material.elevation: 5
    height: 48
    Message{
        id: me
    }

    property bool visibleState: message.visible&&message.messageType== Message.SimpleMessage
    visible: visibleState
    Pane {
        id: bar
        Material.background: message.backColor
        anchors.fill: parent
        Label {
            color: "white"
            text: message.content
            anchors.fill: parent
            horizontalAlignment: Label.AlignHCenter
            font {
                 family: flYekan.name
                 pixelSize: 12
            }
        }
        Behavior on scale {
            NumberAnimation {
                duration: 100
            }
        }
    }
//    z:visibleState?1000:0

}

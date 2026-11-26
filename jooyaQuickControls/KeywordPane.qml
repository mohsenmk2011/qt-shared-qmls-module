import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import Jooya
import QtQuick.Layouts

Pane {
    id: bar
    padding: 0
    property string content
    property bool selected: false
    signal itemClicked()
    Material.background:selected?"#4CAF50":"#9E9E9E"

    Text{
        color: "white"
        text: content
        font{
            pixelSize: 10
        }
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        MouseArea{
            anchors.fill: parent
            onClicked: {
                itemClicked()
            }
        }
    }
}

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import Jooya

Pane {
    Material.elevation: 5
    parent: Overlay.overlay
    anchors.centerIn: parent
    width: visible?implicitWidth:0
    height: visible?implicitHeight:0


    visible: false

    implicitWidth: 99
    implicitHeight: 63
    BusyIndicator{
        anchors.centerIn: parent
        width: 36
        height: 36
    }
    z:999
}

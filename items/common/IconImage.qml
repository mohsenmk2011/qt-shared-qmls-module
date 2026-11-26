import QtQuick
import JooyaQuick.Controls.Material
import QtQuick.Effects

Item{

    property alias color: colorizationEffect.colorizationColor
    property alias source: img.source
    property alias fillMode: img.fillMode

    Image {
        id:img
        fillMode: Image.Pad
        horizontalAlignment: Image.AlignHCenter
        verticalAlignment: Image.AlignVCenter
        smooth: true
        visible: false

        width: parent.width
        height: parent.height
    }

    MultiEffect {
        id:colorizationEffect
        source: img
        anchors.fill: img
        colorization: 1
    }
}

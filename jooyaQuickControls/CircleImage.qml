import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import JooyaQuick.Controls.Material
import "../items/common"
Item {
    id: circleImage
    property alias source: img.source
    property alias sourceDefault: imgDefault.source
    Rectangle {
        anchors.fill: parent
        radius: parent.width / 2
        color: MaterialStyle.primary50
        visible: img.state !== Image.Ready
        IconImage {
            id: imgDefault
            anchors.centerIn: parent
            fillMode: Image.Pad
            width: 27
            height: 27
            source: sourceDefault
            color: MaterialStyle.iconColor
        }
    }
    Rectangle {
        anchors.fill: parent
        radius: parent.width / 2
        color: "lightgrey"
        layer.enabled: true
        // This item should be used as the 'mask'
        layer.samplerName: "maskSource"
        layer.effect: ShaderEffect {
            property var colorSource: img;
            fragmentShader: "../shaders/maskshader.qsb"
        }
    }
    Image {
        id: img
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        visible: false; // should not be visible on screen.
        layer.enabled: true;
        layer.smooth: true
    }
}

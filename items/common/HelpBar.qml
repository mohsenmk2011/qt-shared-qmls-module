import QtQuick
import QtQuick.Controls
import JooyaQuick.Controls.Material

Rectangle {
    property string helpText: "متن راهنمای نوار راهنما"

    color: MaterialStyle.primary100
    IconImage {
        id: imgLeftArrow
        source: "../../images/chat/arrow-left.png"
        anchors.right: txtHelp.left
        anchors.verticalCenter: parent.verticalCenter
        color: MaterialStyle.iconColor
        SequentialAnimation {
            loops: Animation.Infinite
            running: true
            alwaysRunToEnd: true
            PropertyAnimation {
                target: imgLeftArrow
                property: "scale"
                to:0.81
                duration: 900
                easing.type: Easing.OutBounce
            }
            PropertyAnimation {
                target: imgLeftArrow
                property: "scale"
                to: 0.99
                duration: 900
                easing.type: Easing.OutBounce
            }
            PauseAnimation{
                duration: 1800
            }
        }
    }
    Text {
        id:txtHelp
        text: helpText
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

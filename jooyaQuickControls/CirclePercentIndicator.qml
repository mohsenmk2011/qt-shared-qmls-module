import QtQuick
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import QtQuick.Controls
import QtMultimedia

Item {
    id: root
    width: size
    height: size
    property int fontPixlSize: 12

    property int percent: 0

    property string text: percent

    property int size: 200               // The size of the circle in pixel
    property real arcBegin: 0            // start arc angle in degree
    property real arcEnd: percent*3.6    // end arc angle in degree
    property real arcOffset: -90         // rotation
    property bool isPie: false           // paint a pie instead of an arc
    property bool showBackground: false  // a full circle as a background of the arc
    property real lineWidth: 20          // width of the line
    property color colorCircle: MaterialStyle.tertiary300
    property color colorBackground: "#779933"

    property alias beginAnimation: animationArcBegin.enabled
    property alias endAnimation: animationArcEnd.enabled

    property int animationDuration: 200

    onArcBeginChanged: canvas.requestPaint()
    onArcEndChanged: canvas.requestPaint()

    Behavior on arcBegin {
        id: animationArcBegin
        enabled: true
        NumberAnimation {
            duration: root.animationDuration
            easing.type: Easing.InOutCubic
        }
    }

    Behavior on arcEnd {
        id: animationArcEnd
        enabled: true
        NumberAnimation {
            duration: root.animationDuration
            easing.type: Easing.InOutCubic
        }
    }

    Canvas {
        id: canvas
        anchors.fill: parent
        rotation: parent.arcOffset
        Rectangle{
            rotation: 360-canvas.rotation
            width: size-lineWidth
            height: width
            anchors.centerIn: parent
            radius: width/2
            color: MaterialStyle.secondary200
            Text {
                anchors.centerIn: parent
                text:root.text
                font.pixelSize: fontPixlSize
                color: MaterialStyle.secondaryTextColor

            }
        }
        onPaint: {
            var ctx = getContext("2d")
            var x = width / 2
            var y = height / 2
            var start = Math.PI * (parent.arcBegin / 180)
            var end = Math.PI * (parent.arcEnd / 180)
            ctx.reset()

            if (root.isPie) {
                if (root.showBackground) {
                    ctx.beginPath()
                    ctx.fillStyle = root.colorBackground
                    ctx.moveTo(x, y)
                    ctx.arc(x, y, width / 2, 0, Math.PI * 2, false)
                    ctx.lineTo(x, y)
                    ctx.fill()
                }
                ctx.beginPath()
                ctx.fillStyle = root.colorCircle
                ctx.moveTo(x, y)
                ctx.arc(x, y, width / 2, start, end, false)
                ctx.lineTo(x, y)
                ctx.fill()
            } else {
                if (root.showBackground) {
                    ctx.beginPath();
                    ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, 0, Math.PI * 2, false)
                    ctx.lineWidth = root.lineWidth
                    ctx.strokeStyle = root.colorBackground
                    ctx.stroke()
                }
                ctx.beginPath();
                ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, start, end, false)
                ctx.lineWidth = root.lineWidth
                ctx.strokeStyle = root.colorCircle
                ctx.stroke()
            }
        }
    }
}

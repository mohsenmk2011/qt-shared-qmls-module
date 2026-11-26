import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Window

GridView{
    id: root
    boundsBehavior: Flickable.StopAtBounds
    clip: true
    //    property alias busyIndicator: bi
    //    Rectangle{
    //        id: bi
    //        height: 48
    //        visible: false
    //        anchors.bottom: root.bottom
    //        anchors.right: root.right
    //        anchors.left: root.left
    //        color: "white"
    //        radius: 2

    //        BusyIndicator{
    //            width: 47
    //            height: 47
    //            anchors.horizontalCenter: parent.horizontalCenter
    //        }
    //    }

    //    Rectangle {
    //        id: swatch
    //        signal follow
    //        width: 15 * mm
    //        height: width
    //        radius: width / 2
    //        color: 'lightgray'
    //        anchors.horizontalCenter: parent.horizontalCenter
    //        y: - height
    //    }
    //    MouseArea {
    //        property int mouseYStart
    //        property int biggerMouseY
    //        anchors.fill: parent
    //        onPressed: {
    //            mouseYStart = mouseY
    //            biggerMouseY = 0
    //        }
    //        onMouseYChanged: {
    //            if(parent.contentY == 0) {
    //                var currentMouseY = mouseY
    //                if(currentMouseY > biggerMouseY) {
    //                    biggerMouseY = currentMouseY
    //                    swatch.y += 1
    //                }
    //                if(currentMouseY < biggerMouseY) {
    //                    biggerMouseY = currentMouseY
    //                    swatch.y -= 1
    //                }
    //            }
    //        }
    //        onReleased: swatch.y = - swatch.height
    //    }
    add: Transition
    {
        NumberAnimation
        {
            properties: "y"
            from: 900
            duration: 630
            easing.type: Easing.OutExpo
        }
    }
    remove: Transition
    {
        NumberAnimation
        {
            properties: "scale"
            from: 1
            to: 0.18
            duration: 540
        }
    }
    moveDisplaced: Transition
    {
        NumberAnimation
        {
            properties: "x,y"
            duration: 900
            easing.type: Easing.OutExpo
        }
    }
    removeDisplaced: Transition
    {
        NumberAnimation
        {
            properties: "x,y"
            duration: 900
            easing.type: Easing.OutExpo
        }
    }
    ScrollBar.vertical: ScrollBar{
        width: 9
    }
    signal scrolledDown();
    signal scrolledUp();

    property double lastY: 0
    visibleArea.onYPositionChanged: {
        var plusc=0.033;
        var soeld=Math.abs(visibleArea.yPosition-lastY);
        if(visibleArea.yPosition>lastY&&soeld>plusc)
        {
            lastY=visibleArea.yPosition;
            scrolledUp();
        }
        else if(visibleArea.yPosition<lastY&&soeld>plusc){
            lastY=visibleArea.yPosition;
            scrolledDown();
        }
    }

}

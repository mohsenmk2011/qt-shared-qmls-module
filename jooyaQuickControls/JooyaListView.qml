import QtQuick
import QtQuick.Controls

ListView {
    property alias busyIndicator: bi

   BusyIndicator{
        id:bi
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        height: 50
    }
    add: Transition
    {
        NumberAnimation
        {
            properties: "y"
            from: 960
            duration: 500
            easing.type: Easing.OutExpo
        }
    }
    move: Transition
    {
        NumberAnimation
        {
            properties: "y"
            from: 960
            duration: 350
            easing.type: Easing.OutExpo
        }
    }
    remove:  Transition
    {
        NumberAnimation
        {
            properties: "y"
            from: 960
            duration: 350
            easing.type: Easing.OutExpo
        }
    }
}

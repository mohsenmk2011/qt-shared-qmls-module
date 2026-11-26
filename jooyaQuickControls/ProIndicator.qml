import QtQuick

Item {
    property int count: 3
    Row{
        anchors.fill: parent
        Rectangle{
            width: 50
            height: width
            color: "white"
            Rectangle{
                id:rect1
                width: 50
                anchors.centerIn: parent
                height: width
                radius: width/2
                color: "red"
            }
            SequentialAnimation {
                loops: Animation.Infinite
                running: true
                alwaysRunToEnd: true
                PropertyAnimation {
                    target: rect1
                    property: "scale"
                    to: 0.27
                    duration: 900
                }
                PropertyAnimation {
                    target: rect1
                    property: "scale"
                    to: 0.72
                    duration: 900
                }
            }
        }
        Rectangle{
            width: 50
            height: width
            color: "white"
            Rectangle{
                id:rect2
                width: 50
                anchors.centerIn: parent
                height: width
                radius: width/2
                color: "blue"
            }
            SequentialAnimation {
                loops: Animation.Infinite
                running: true
                alwaysRunToEnd: true
                PropertyAnimation {
                    target: rect2
                    property: "scale"
                    to: 0.5
                    duration: 900
                }
                PropertyAnimation {
                    target: rect2
                    property: "scale"
                    to: 1.0
                    duration: 900
                }
            }
        }
        Rectangle{
            width: 50
            height: width
            color: "white"
            Rectangle{
                id:rect3
                width: 50
                anchors.centerIn: parent
                height: width
                radius: width/2
                color: "green"
            }
            SequentialAnimation {
                loops: Animation.Infinite
                running: true
                alwaysRunToEnd: true
                PropertyAnimation {
                    target: rect3
                    property: "scale"
                    to:1
                    duration: 900
                }
                PropertyAnimation {
                    target: rect3
                    property: "scale"
                    to: 0
                    duration: 900
                }
            }
        }


    }

}

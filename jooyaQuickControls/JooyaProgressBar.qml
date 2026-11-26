import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{
    property int progressCount: 0
    color: "#FFCCBC"
    Rectangle {
        Layout.fillHeight: true
        height: parent.height
        width: progressCount
        color: "#FF5722"
    }
}

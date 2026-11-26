import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout{
    property string key:"ویژگی"
    property string value:"مقدار"
    layoutDirection: Qt.RightToLeft
    Layout.fillWidth: true
    Rectangle{
        id: recKey
        color: "#eaeaec"
        Layout.fillWidth: true
        height: 25
        radius: 3
        Text {
            font{
                family: flYekan.name
                pixelSize: 12
                bold: true
            }
            text:key
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            color: "#5a544b"
        }
    }
    TextField {
        Layout.fillWidth: true
        font{
            family: flYekan.name
            pixelSize: 12
        }
        height: 25
        clip: true
        wrapMode: Text.WordWrap
        text:value
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        color: "#5a544b"
    }

}

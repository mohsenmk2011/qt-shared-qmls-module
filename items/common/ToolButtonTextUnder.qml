import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import JooyaQuick.Controls.Material

ColumnLayout{
    id:toolbuttonWithTextUnder
    Layout.preferredWidth: 54
    property url iconSource: ""
    property alias text: textUnderButton.text
    signal clicked();

    spacing: 0
    ToolButton {
        id:btn
        Layout.preferredHeight: 54
        Layout.preferredWidth: 54
        Layout.topMargin: - 6
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        contentItem: IconImage {
            id:btnIcon
            source: iconSource
            fillMode: Image.Pad
            width: 36
            height: 36
            color: MaterialStyle.iconColor
        }
        onClicked: {
            toolbuttonWithTextUnder.clicked();
        }
    }
    Text {
        id:textUnderButton
        color: MaterialStyle.primaryTextColor
        font.family: flYekan.name
        font.pixelSize: 9
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        Layout.topMargin: - 9
    }
    Item {
        Layout.fillHeight: true
    }
}

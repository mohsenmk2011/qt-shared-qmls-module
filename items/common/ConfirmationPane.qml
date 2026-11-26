import QtQuick
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import QtQuick.Layouts
import Jooya

Pane {
    id:confirmationPane
    font.family: flYekan.name
    Material.elevation: 2
    Material.background: MaterialStyle.primary100
    signal yesClicked()
    signal noClicked()
    property string message: "پیام شما"
    property int fontSize: 15
    property bool yesHighlighted: false
    property bool noHighlighted: true
    property string yesButtonText: "آری"
    property string noButtonText: "خیر"

    width: 306
    height: 180
    ColumnLayout
    {
        anchors.fill: parent
        spacing: 9
        Text {
            id: txtMessage
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop

            text: message
            wrapMode: Text.Wrap
            font{
                pixelSize: fontSize
                family: flYekan.name
            }
            color: MaterialStyle.primaryTextColor
        }
        RowLayout{
            id: rowBtns
            Layout.fillWidth: true

            layoutDirection: Qt.RightToLeft
            Button{
                Material.roundedScale: Material.ExtraSmallScale
                Layout.fillWidth: true
                highlighted: yesHighlighted
                text: yesButtonText
                onClicked: {
                    console.log("yes button clicked :>")
                    confirmationPane.visible = false;
                    yesClicked();
                }
            }
            Button{
                Material.roundedScale: Material.ExtraSmallScale
                Layout.fillWidth: true
                highlighted: noHighlighted
                text: noButtonText

                onClicked: {
                    console.log("no button clicked :>")
                    confirmationPane.visible = false;
                    noClicked();
                }
            }
        }
    }

}

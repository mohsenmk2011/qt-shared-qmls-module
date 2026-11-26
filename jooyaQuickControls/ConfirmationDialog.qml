import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import Jooya

Dialog{
    id: root
    Material.roundedScale: Material.ExtraSmallScale
    signal yesClicked
    signal noClicked
    property int rootWidth:mainWindow.width
    property int rootHeight:mainWindow.height
    property string message: "پیام شما"
    property int fontSize: 18
    property bool yesHighlighted: false
    property bool noHighlighted: true
    property string yesButtonText: "آری"
    property string noButtonText: "خیر"
    parent:  Overlay.overlay

    x: (rootWidth-width)/2
    y: (rootHeight-height) / 2

    height: visible?162:0
    width: visible?306:0

    font{
        family: flYekan.name
        pixelSize: fontSize
        bold: true
    }
    //================================================
    Text {
        id: txtMessage
        Layout.fillHeight: true
        Layout.fillWidth: true
        text: message
        topPadding: 0
        padding: 2
        anchors.bottom: rowBtns.top
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        wrapMode: Text.Wrap
        font{
            pixelSize: fontSize
            family: flYekan.name
        }
        color: MaterialStyle.primaryTextColor
    }
    RowLayout{
        id: rowBtns
        width: 183
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        layoutDirection: Qt.RightToLeft
        anchors.bottomMargin: 0
        JooyaButton{
            Layout.fillWidth: true
            highlighted: yesHighlighted
            text: yesButtonText
            onClicked: {
                yesClicked();
                root.close();
            }
        }
        JooyaButton{
            Layout.fillWidth: true
            highlighted: noHighlighted
            text: noButtonText

            onClicked: {
                noClicked()
                root.close();
            }
        }
    }
}

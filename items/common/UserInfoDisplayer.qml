import QtQuick
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Controls
import "../../jooyaQuickControls"
import Jooya

Pane {
    property int preferredHeight: 0
    Layout.preferredHeight: preferredHeight
    property BaseUser user: null
    property int picSize: 115
    Material.background: Material.accent
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignTop
    padding: 0
    rightPadding: 18
    leftPadding: 18
    RoundButton {
        id: rbtnChangeTheme
        width: 72
        height: 72
        Material.elevation: 0
        highlighted: true
        anchors.top: parent.top
        anchors.right: parent.right
        contentItem: Image {
            fillMode: Image.Pad
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            source: MaterialStyle.isDark ? "../../images/common/white-balance-sunny.png":"../../images/common/weather-night.png"
        }
        onClicked: {
            MaterialStyle.invertTheme();
        }
        onPressAndHold: {
            // drawerPaymentResult.open();
            // drawer.close();
            CurrentUser.isAdmin = !CurrentUser.isAdmin
        }
    }
    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 0
        anchors.topMargin: 6
        anchors.bottomMargin: 6

        spacing: 2
        CircleImage {
            id:cimg
            width: 96
            height: 96
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            source:  user.lastImage.isExists ? user.lastImage.url:""
            sourceDefault: "../../images/common/account.png"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                }
            }
        }
        TagItem{
            id:lblIsAdmin
            text: "کاربر مدیر"
            fontFamily: flYekan.name
            anchors.verticalCenter: cimg.verticalCenter
            anchors.left: cimg.right
            anchors.leftMargin: -6
            visible: CurrentUser.isAnyAdmin
        }
        Text {
            color: MaterialStyle.invertedPrimaryTextColor
            text: user.displayName
            Layout.fillWidth: true
            Layout.leftMargin: 16
            Layout.topMargin: lblIsAdmin.visible ? -1 * lblIsAdmin.height : 0
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 18
            font.family: flYekan.name
            font.bold: true
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    drawer.close();
                    sv.push("../../pages/users/UserDisplayNamePage.qml");
                }
            }
        }
    }
}

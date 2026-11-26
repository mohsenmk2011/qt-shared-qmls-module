import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import QtQuick.Layouts
import "../../jsf/Bootstrap.js" as Bs
import Jooya
import "../../jooyaQuickControls"

Pane{
    id: root
    Material.elevation: 1
    Material.background: MaterialStyle.primary100
    property Role role
    anchors.horizontalCenter: parent.horizontalCenter
    RowLayout {
        anchors.fill: parent
        anchors.topMargin: 5
        anchors.bottomMargin: 5
        anchors.rightMargin: 10
        anchors.leftMargin: 10

        spacing: 5

        Text{
            Layout.fillWidth: true
            text: role.name
        }
        RoundButton{
            highlighted: true
            width: 64
            height: 64
            contentItem: Image {
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source: "../../images/common/delete.png"
            }
            onClicked: {
                dlgdel.open();
            }
        }
        RoundButton{
            highlighted: true
            width: 64
            height: 64
            contentItem: Image {
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source: "../../images/common/pencil.png"
            }
            onClicked: {
                svManaging.push("RoleAddPage.qml",{role:role});
            }
        }

    }    
    ConfirmationDialog {
        id: dlgdel
        message: "آیا مایل هستید نقش را حذف کنید؟"
        onYesClicked: {
            role.deleteRole();
        }
    }
}

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Dialogs
import QtQuick.Layouts
import "../../jooyaQuickControls"
import "../../pages/users"
import "../../jsf/Bootstrap.js" as Bs
import Jooya

Page{
    id: root
    objectName: "UsersPage"
    Component.onCompleted: {
        userManager.getList();
    }
    Shortcut{
        sequence: "F5"
        enabled:root.visible
        onActivated: {
            userManager.getList();
        }
    }
    UserManager{
        id: userManager
        onIsProcessingChanged: {
            progressIndicator.visible=isProcessing;
        }
    }
    JooyaGridView {
        id: rootgv
        anchors.fill: parent
        cellWidth:parent.width
        cellHeight:81
        delegate: UserItem {
            width: rootgv.cellWidth
            height: rootgv.cellHeight
            user:argUser
        }

        model: userManager.listModel

        onScrolledUp: {
            btnAddUser.stateVisible=false;
        }
        onScrolledDown: {
            btnAddUser.stateVisible=true;
        }
    }
    RoundButton{
        id: btnAddUser
        property bool stateVisible: !isRolePageIsVisible
        visible: CurrentUser.isLoggedIn
        width: 64
        height: 64
        highlighted: true
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        contentItem: Image {
            fillMode: Image.Pad
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../../images/common/plus.png"
        }
        onClicked: {
            svManaging.push("/pages/users/SignupPage.qml",{lm:loginManager});
        }
        scale: stateVisible?1.0:0.0
        Behavior on scale {
            NumberAnimation{
                easing.type: Easing.InOutBounce
                duration: 150
            }
        }
    }
}


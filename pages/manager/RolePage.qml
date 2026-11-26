import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Dialogs
import QtQuick.Layouts
import "../../jooyaQuickControls"
import "../../jsf/Bootstrap.js" as Bs
import Jooya

Page {
    id: rolePage
    rightPadding: 0
    leftPadding: 0
    Component.onCompleted: {
        roleManager.getList();
    }
    Shortcut{
        sequence: "F5"
        enabled:root.visible
        onActivated: {
            roleManager.getList();
        }
    }
    RoleManager{
        id: roleManager
        onIsProcessingChanged: {
            bipi.visible=isProcessing;
        }
    }
    font{
        family: flYekan.name
        pixelSize: 18
        bold: true
    }
    //================================================
    JooyaGridView {
        id: rootgv
        anchors.fill: parent
        cellWidth:rootgv.width
        cellHeight:58
        delegate:RoleItem{
            width: rootgv.cellWidth
            height: rootgv.cellHeight
            role: model
        }
        model: roleManager.listModel

        onScrolledUp: {
            btnAddRole.stateVisible=false;
        }
        onScrolledDown: {
            btnAddRole.stateVisible=true;
        }
    }
    RoundButton{
        id: btnAddRole
        Material.elevation:2
        property bool stateVisible: true
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
            roleManager.add();
        }
        scale: stateVisible?1.0:0.0
        Behavior on scale {
            NumberAnimation{
                easing.type: Easing.InOutBounce
                duration: 180
            }
        }
    }
    ProgressIndicator{
        id: bipi
    }
}



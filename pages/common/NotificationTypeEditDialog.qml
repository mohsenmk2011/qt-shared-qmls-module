import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import Jooya
import QtQuick
import QtQml.Models
import "../../jooyaQuickControls"
import "../manager"

Dialog{
    id:notifyTypeDialog
    Material.roundedScale: Material.ExtraSmallScale
    property bool isInEditPage: false

    property int rootWidth:mainWindow.width
    property int rootHeight:mainWindow.height
    parent: Overlay.overlay
    dim: true
    Overlay.modeless: Rectangle {
        color: "#aacfdbe7"
        MouseArea{
            acceptedButtons: Qt.LeftButton|Qt.RightButton
            anchors.fill: parent
        }
    }
    closePolicy: Popup.NoAutoClose
    x: (rootWidth-width)/2
    y: (rootHeight-height) / 2
    width: 250
    height: 280
    font{
        family: flYekan.name
        pixelSize: 12
        bold: true
    }
    header: RowLayout{
        height: 30
        Layout.fillWidth: true
        ToolButton{
            contentItem: Image {
                source: "../../images/common/window-close.png"
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
            }
            onClicked: {
                close();
            }
        }
    }
    Component.onCompleted: {
        if(notify.type===NotificationTypes.AppIntroducing){
            rbAppIntro.checked=true
        }
        else if(notify.type===NotificationTypes.Discount){
            rbDiscount.checked=true
        }
        else if(notify.type===NotificationTypes.AppUpdate){
            rbAppUpdate.checked=true
        }
    }

    ColumnLayout {
        anchors.fill: parent
        layoutDirection: Qt.RightToLeft
        RadioButton {
            id:rbAppIntro
            Layout.fillWidth: true
            text: qsTr("معرفی اپلیکیشن")
            onCheckedChanged: {
                notify.type=NotificationTypes.AppIntroducing;
            }
        }
        RadioButton {
            id:rbDiscount
            Layout.fillWidth: true
            text: qsTr("تخفیف")
            onCheckedChanged: {
                notify.type=NotificationTypes.Discount;
            }
        }
        RadioButton {
            id:rbAppUpdate
            Layout.fillWidth: true
            text: qsTr("بروزرسانی اپلیکیشن")
            onCheckedChanged: {
                notify.type=NotificationTypes.AppUpdate;
            }
        }
        Item {
            Layout.fillHeight: true
        }
    }
    onVisibleChanged: {
        if(parent.visible){
            //            notify.loadKeywords();
        }
    }
    ProgressIndicator{
        id: myProgressIndicator
        visible: notify.isProcessing
    }
}

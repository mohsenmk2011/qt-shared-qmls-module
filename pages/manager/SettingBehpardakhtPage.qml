import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Dialogs
import QtQuick.Layouts
import "../../jooyaQuickControls"
import "../../jsf/Bootstrap.js" as Bs
import Jooya
import QtQuick
import QtQml.Models

Flickable{
    id: root
    BehpardakhtSetting{
        id:bpSetting
        callBackUrl:tfCallBackUrl.text
        additionalData: tfAdditionalData.text
        enabled: swhEnabled.checked
        termainalUrl: tfTerminalUrl.text
        terminalId: tfTerminalId.text
        userName: tfUsername.text
        password: tfPassword.text
        payerId: tfPayerId.text
        onIsProcessingChanged: {
            bipi.visible=isProcessing;
        }
    }
    Component.onCompleted: {
        bpSetting.load();
    }

    Material.elevation:4

    contentHeight: 700
    flickableDirection: Flickable.AutoFlickIfNeeded
    clip: true
    ColumnLayout{
        id: mainClm
        anchors.fill: parent
        anchors.rightMargin: 16
        anchors.leftMargin: 16
        spacing: 15
        TextField {
            id:tfTerminalUrl
            placeholderText: "آدرس درگاه"
            color: "#3D3D3D"
            Layout.fillWidth: true
            text: bpSetting.termainalUrl
        }
        TextField {
            id:tfUsername
            placeholderText: "نام کاربری"
            color: "#3D3D3D"
            Layout.fillWidth: true
            text: bpSetting.userName
        }
        TextField {
            id:tfPassword
            placeholderText: "گذر واژه"
            color: "#3D3D3D"
            Layout.fillWidth: true
            text: bpSetting.password
        }
        TextField {
            id:tfCallBackUrl
            placeholderText: "آدرس صفحه بازگشت"
            color: "#3D3D3D"
            Layout.fillWidth: true
            text: bpSetting.callBackUrl
        }
        TextField {
            id:tfTerminalId
            placeholderText: "شناسه ترمینال"
            color: "#3D3D3D"
            Layout.fillWidth: true
            text: bpSetting.terminalId
        }
        TextField {
            id:tfAdditionalData
            placeholderText: "داده اضافی"
            color: "#3D3D3D"
            Layout.fillWidth: true
            text: bpSetting.additionalData
        }
        TextField {
            id:tfPayerId
            placeholderText: "شناسه پذیرنده"
            color: "#3D3D3D"
            Layout.fillWidth: true
            text: bpSetting.payerId
        }
        RowLayout{
            Layout.fillWidth: true
            Switch{
                id: swhEnabled
                checked: bpSetting.enabled
            }
            Label{
                text: "آیا درگاه فعال است؟"
                Layout.fillWidth: true
            }
        }
        Button{
            id: btnSave
            text: "ذخیره"
            highlighted: true
            Layout.fillWidth: true
            onClicked: {
                bpSetting.save();
            }
        }
        Item{
            Layout.fillHeight: true
        }
    }

    ScrollBar.vertical: ScrollBar{
        width: 8
    }
}

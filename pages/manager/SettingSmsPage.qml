import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Dialogs
import QtQuick.Layouts
import "../../jooyaQuickControls"
import "../../jsf/Bootstrap.js" as Bs
import Jooya
import QtQuick
import QtQml.Models

JooyaFlickable{
    id: root
    Component.onCompleted: {
        smsSettings.load();
    }
    SmsSettings{
        id:smsSettings
        userName: tfUsername.text
        password: tfPassword.text
        waitTimeForNextSend: tfWaitTimeForNextSend.text
        senderNumber: tfSenderNumber.text
        onIsProcessingChanged: {
            progressIndicatorVisible=isProcessing;
        }
    }

    contentHeight: 700
    ColumnLayout{
        id: mainClm
        anchors.fill: parent
        anchors.rightMargin: 16
        anchors.leftMargin: 16
        spacing: 15
        JooyaTextField {
            id:tfUsername
            placeholderText: "نام کاربری"
            Layout.fillWidth: true
            text: smsSettings.userName
        }
        JooyaTextField {
            id:tfPassword
            placeholderText: "گذر واژه"
            text: smsSettings.password
        }
        JooyaTextField {
            id:tfWaitTimeForNextSend
            placeholderText: "زمان انتظار تا پیامک بعدی"
            text: smsSettings.waitTimeForNextSend
        }
        JooyaTextField {
            id:tfSenderNumber
            placeholderText: "شماره ارسال کننده"
            text: smsSettings.senderNumber
        }
        Button{
            id: btnSave
            text: "ذخیره"
            highlighted: true
            Layout.fillWidth: true
            onClicked: {
               smsSettings.save();
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

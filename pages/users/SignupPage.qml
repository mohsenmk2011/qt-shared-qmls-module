import QtQuick
import QtQuick.Controls
import "../../jsf/Bootstrap.js" as Bs
import "../../jooyaQuickControls"
import QtQuick.Layouts
import QtQuick.Controls.Material
import Jooya

JooyaFlickable{
    id: root
    objectName: "signup"
    LoginManager {
        id:loginManager
        onIsProcessingChanged: {
            progressIndicatorVisible=isProcessing;
            btnSignup.enabled=!isProcessing;
        }
        onSignupSucceed: {
            sv.pop(null);
            sv.replace("/pages/users/LoginPage.qml");
        }
    }
    CapthaManager{
        id: capthaManager
        onCapthaChanged: {
            capthaImage.image=argCaptha
        }
        onIsProcessingChanged: {
            progressIndicatorVisible=isProcessing;
        }
    }
    Shortcut{
        sequence: "F5"
        onActivated: {
            capthaManager.loadCaptha();
        }
    }
    //        Shortcut{
    //            sequence: "Return"
    //            onActivated: {
    //                signup();
    //            }
    //        }
    Component.onCompleted: {
        capthaManager.loadCaptha();
    }
    function signup(){
        loginManager.signUp(tfUserName.text,tfPassword.text,tfPasswordRe.text,tfCaptha.text,capthaManager.capthaHash);
    }
    contentHeight: mainClm.implicitHeight+250

    ColumnLayout{
        id:mainClm
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: Bs.bootSize(root.width,"xs-11 sm-10 md-8 lg-6 xl-4")
        anchors.topMargin: 25
        spacing: 20
        TextFieldLabeld{
            id: tfUserName
            title: "نام کاربری"
            placeholderText: "نام کاربری"
            Layout.fillWidth: true
            Layout.preferredHeight: 54
            Layout.leftMargin: 18
            Layout.rightMargin: 18
        }
        TextFieldLabeld{
            id: tfPassword
            title: "گذر واژه"
            placeholderText: "گذر واژه"
            Layout.fillWidth: true
            Layout.preferredHeight: 54
            Layout.leftMargin: 18
            Layout.rightMargin: 18
        }
        TextFieldLabeld{
            id: tfPasswordRe
            title: "تکرار گذر واژه"
            placeholderText: "تکرار گذر واژه"
            Layout.fillWidth: true
            Layout.preferredHeight: 54
            Layout.leftMargin: 18
            Layout.rightMargin: 18
            inputMethodHints: Qt.ImhDigitsOnly
        }
        JooyaTextField{
            id: tfCaptha
            inputMethodHints: Qt.ImhDigitsOnly
            placeholderText: "تصویر امنیتی"
            EnterKey.type: Qt.EnterKeyDone
        }
        CapthaImage{
            id: capthaImage
            width: 200
            height: 50
            Layout.alignment: Qt.AlignHCenter            
        }
        JooyaButton{
            id:btnSignup
            text: "ثبت نام"
            onClicked: {
                signup();
            }
        }
        JooyaLabel{
            color:"red"
            text:qsTr("قبلا ثبت نام کرده ام")
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    sv.push("/pages/users/LoginPage.qml");
                }
            }
        }
        Item{
            Layout.fillHeight: true
        }
    }
}


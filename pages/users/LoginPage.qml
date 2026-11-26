import QtQuick
import QtQuick.Controls
import "../../jooyaQuickControls"
import QtQuick.Layouts
import QtQuick.Controls.Material
import Jooya
import "../../jsf/Bootstrap.js" as Bs

JooyaPage {
    id: root
    objectName: "login"
    topPadding: 25
    property alias rootWidth: root.width
//    Shortcut{
//        sequences: ["Return","Num+Enter"]
//        onActivated: {
//            login();
//        }
//    }
    function login(){
        loginManager.login(tfUserName.text,tfPassword.text);
    }
    LoginManager{
        id:loginManager
        onIsProcessingChanged: {
            progressIndicatorVisible=isProcessing;
            btnLogin.enabled=!isProcessing;
        }
    }
    ColumnLayout{
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 20
        width: Bs.bootSize(rootWidth,"xs-11 sm-10 md-8 lg-6 xl-4")
        JooyaTextField{
            id: tfUserName
            placeholderText: "نام کاربری"            
        }
        JooyaTextField{
            id: tfPassword
            placeholderText: "کلمه عبور"
            EnterKey.type: Qt.EnterKeyDone
            echoMode: TextInput.Password
        }
        JooyaButton{
            id: btnLogin
            highlighted: true
            text: "ورود"
            onClicked: login();
        }
        JooyaLabel{
            color:"red"
            text:qsTr("ثبت نام نکرده ام")
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    sv.push("/pages/users/SignupPage.qml");
                }
            }
        }
        Item{
            Layout.fillHeight: true
        }
    }
}

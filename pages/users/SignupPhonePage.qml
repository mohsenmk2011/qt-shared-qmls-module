import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import Jooya
import "../../jsf/Bootstrap.js" as Bs
import "../../jooyaQuickControls"

Page{
    id: root
    objectName: "SignupPhonePage"
    LoginManager{
        id:lm
        onSignUpPhoneSucceed: {
            sv.push("qrc:/pages/users/UserActivationPage.qml",{signupResult:result});
        }
    }    
    GoogleAuth{
        id: googleAuth
        onIdTokenReady: {
            console.log("google signing step 5 => google id token received => calling LoginManager.loginWithGoogle");
            lm.loginWithGoogle(idToken);
        }
        onSignInFailed: {
            console.log("google sign in failed => "+message);
        }
    }
    AndroidPermissionManager{
        id:androidPermissionManager
    }

    ImageFile {
        id:imgFile
        downloadLink: "/Images/InsertPhoneNumber.jpg"
    }
    Shortcut{
        sequence: "Return"
        enabled: isDesktopOs && root.visible
        onActivated: {
            lm.signUp(tfPhoneNumber.text);
        }
    }
    Component.onCompleted: {
        imgFile.download();
    }
    JooyaFlickable {
        id:flickable
        anchors.fill: parent
        contentHeight: mainClm.implicitHeight
        ColumnLayout {
            id:mainClm
            anchors.fill: parent
            spacing: 18
            Rectangle{
                Layout.fillWidth: true
                Layout.minimumHeight: imgFile.isExists ? img.height:270
                clip: true
                color: MaterialStyle.primary100
                Image {
                    id: imgDefualt
                    source: "../../images/common/image-filter-hdr.png"
                    width: 27
                    height: 27
                    visible: !img.visible
                    anchors.centerIn: parent
                    fillMode: Image.Pad
                }
                Image {
                    id:img
                    visible: imgFile.isExists
                    anchors.centerIn: parent
                    source: imgFile.isExists? imgFile.url:""
                    width: parent.width
                    fillMode: Image.PreserveAspectFit
                }
                ProgressBar{
                    visible: imgFile.isProcessing
                    from: 0
                    to: 1
                    height: 3
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    indeterminate: true
                }
                RoundButton {
                    id: btnDownload
                    width: 72
                    height: 72
                    highlighted: true
                    visible: !imgFile.isExists&&!imgFile.isProcessing
                    anchors.centerIn: parent
                    Material.elevation: 1
                    contentItem: Image {
                        fillMode: Image.Pad
                        source: "../../images/common/download.png"
                    }
                    JooyaToolTip {
                        text:"دانلود عکس"
                    }
                    onClicked: {
                        imgFile.download();
                    }
                }
            }           
            TextFieldLabeld{
                id: tfPhoneNumber
                maximumLength: 11
                title: "شماره تلفن همراه"
                placeholderText2: "شماره تلفن همراه"
                Layout.fillWidth: true
                Layout.leftMargin: 18
                Layout.rightMargin: 18
                Layout.preferredHeight: 54
                Layout.topMargin: 36
                borderVisible: true
                horizontalAlignment:TextField.AlignLeft
                inputMethodHints: Qt.ImhDigitsOnly
                EnterKey.type: Qt.EnterKeyDone
            }
            JooyaButton{
                id:btnSignup
                enabled: !progressIndicator.visible
                Material.accent: enabled ? MaterialStyle.secondary : Material.Grey
                text:"ارسال کد فعال سازی"
                highlighted: true
                onClicked: {
                    console.log("img.heigt=>"+img.height)
                    console.log("imgFile.isExists => "+imgFile.isExists)
                    console.log("imgFile.path => "+imgFile.url)
                    console.log("login or signup,first get sms permissions ;>");
                    androidPermissionManager.requestSms();
                    lm.signUp(tfPhoneNumber.text);
                }
            }
            Item{
                Layout.fillHeight: true
            }
            JooyaButton{
                id: btnGoogle
                highlighted: false
                enabled: !progressIndicator.visible

                icon.source: "../../images/common/google.png"
                icon.color: "transparent"
                icon.width: 36
                text:"ادامه با حساب گوگل"
                Layout.leftMargin: 72
                Layout.rightMargin: 72
                Layout.preferredHeight: 45
                onClicked: {
                    console.log("----[ google signing step 1:user pressed continue with google ]----");
                    googleAuth.signIn(CurrentApplication.googleClientId,CurrentApplication.googleClientSecret);
                }
            }
        }
    }
    ProgressIndicator{
        id:progressIndicator
        visible: lm.isProcessing || googleAuth.isProcessing
    }
}

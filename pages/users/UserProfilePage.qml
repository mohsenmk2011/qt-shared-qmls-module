import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Dialogs
import "../../jooyaQuickControls"
import "../../jsf/Bootstrap.js" as Bs
import Jooya
import JooyaQuick.Controls.Material

JooyaPage{
    id: root
    objectName: "UserProfilePage"
    signal profileHasChanged;
    property BaseUser baseUser: null
    property string userName: ""
    property string userId: ""
    Component.onCompleted: {
        if(baseUser!=null){
            userName=baseUser.userName;
        }
        console.log("username(phone number in rokhshdi)=> "+userName);
        userProfile.getProfile(userId);
    }
    AndroidPermissionManager{
        id:permissionManager
    }
    MouseArea{
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton|Qt.RightButton
        onPressAndHold: {
            if(!CurrentUser.isAnyAdmin)
            {
                return;
            }
            if(mouse.button===Qt.LeftButton){
                mnuUser.x=mouse.x;
                mnuUser.y=mouse.y
                mnuUser.popup();
            }
        }
        onClicked: {
            if(!CurrentUser.isAnyAdmin)
            {
                return;
            }
            if(mouse.button===Qt.RightButton){
                mnuUser.x=mouse.x;
                mnuUser.y=mouse.y
                mnuUser.popup();
            }
        }
    }
    JooyaMenu{
        id:mnuUser
        JooyaMenuItem{
            jtext: "نقش ها"
            onClicked: {
                svManaging.push("/pages/UserRolesPage.qml",{user:user});
            }
        }
    }
    UserProfile{
        id: userProfile
        displayName: tfDisplayName.text
        userName: tfUserName.text
        email: tfEmail.text
        onProfileChanged: {
            baseUser.getUserInfo(true);
        }
        onImageWasUploaded: {
            baseUser.getUserInfo(true);
        }
        onIsProcessingChanged: {
            progressIndicatorVisible=isProcessing;
        }
        onGetProfileSucceed: {
            userProfile.getScore();
        }
        onImageLoadingChanged: {
            if(argLoaded){
            }
            else{
            }
        }
        onImageDeleted: {
            console.info("user image is deleted successfully -> get user info ,set current image again");
            baseUser.getUserInfo(true);
            currentImage=userProfile.listModel.get(svUserImages.currentIndex);
        }
    }
    property UserImage currentImage: null

    QmlLive.onFileChanged:{
        console.log("QmlLive.onFileChanged(in UserProfilePage.qml) => "+fileName);
        if(fileName==="TakePicturePage"){
            if(sv.currentItem.objectName==="TakePicturePage"){
                sv.replaceEnter.enabled=false;
                QmlLive.clearCache();
                sv.replace("../common/TakePicturePage.qml",{up:userProfile});
            }
        }
    }
    JooyaFlickable{
        id: flickable
        anchors.fill: parent
        contentHeight: mainClm.implicitHeight
        flickableDirection: Flickable.AutoFlickIfNeeded
        clip: true
        ColumnLayout {
            id: mainClm
            anchors.fill: parent
            spacing: 9
            Pane{
                id:pnContainer
                visible: false
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 243
                Layout.preferredHeight: 243
                Layout.topMargin: 18
                Layout.rightMargin: 27
                Layout.leftMargin: 27
                padding: 9
                Material.elevation: 1
                Material.background: MaterialStyle.primary100
                SwipeView {
                    id:svUserImages
                    width: pnContainer.width-18
                    height: pnContainer.height-18
                    clip: true
                    visible: count>0
                    onCurrentIndexChanged: {
                        console.log("svUserImages.currentIndex=> "+svUserImages.currentIndex)
                        currentImage=userProfile.listModel.get(svUserImages.currentIndex);
                    }
                    Repeater{
                        model:userProfile.listModel
                        UserImageItem{
                            width: svUserImages.width
                            height: svUserImages.height
                            userImage: argUserImage                            
                        }
                    }
                }
                RoundButton {
                    id: rbtnUserImage
                    Material.elevation: 2
                    width: 72
                    height: 72
                    highlighted: true
                    enabled: !currentImage.isProcessing
                    anchors.top: parent.bottom
                    anchors.topMargin: -width/2
                    anchors.right: parent.right
                    anchors.rightMargin: 9
                    contentItem: Image {
                        fillMode: Image.Pad
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: (currentImage.fileId !== 0)?"../../images/common/delete.png": "../../images/common/camera.png"
                    }
                    JooyaToolTip {
                        text:currentImage.fileId === 0 ? "گرفتن عکس":"حذف کردن عکس"
                    }
                    onClicked: {
                        if(currentImage.fileId === 0){
                            console.log("current image is not exists => you can take picture with camera");
                            if(permissionManager.requestCamera()){
                                sv.push("../common/TakePicturePage.qml",{up:userProfile});
                            }
                            else
                            {
                                console.log("Camera permission is not granted");
                            }
                        }
                        else{
                            deleteDialog.open();
                        }
                    }
                }
            }
            PageIndicator{
                id: piUserImages
                visible: count>1
                Layout.alignment: Qt.AlignHCenter
                height: 36
                count: svUserImages.count
                currentIndex: svUserImages.currentIndex
            }
            TextFieldLabeld{
                id: tfDisplayName
                Layout.topMargin: 36
                title: "نام شما در " + CurrentApplication.name
                placeholderText2:  "نام شما در " + CurrentApplication.name
                text: userProfile.displayName
                Layout.fillWidth: true
                Layout.preferredHeight: 54
                Layout.leftMargin: 18
                Layout.rightMargin: 18
            }
            CheckBox{
                id:chkboxIsSupporter
                visible: CurrentUser.isAnyAdmin
                checked: userProfile.isSupporter
                Layout.fillWidth: true
                Layout.preferredHeight: 54
                Layout.leftMargin: 18
                Layout.rightMargin: 18
                LayoutMirroring.enabled: true
                text: "آیا این کاربر در اپلیکیشن "+ CurrentApplication.name +" پشتیبان است"
                font{
                    family: flYekan.name
                }
                onToggled: {
                    userProfile.setAsSupporter(checked);
                }
            }
            TextFieldLabeld{
                id: tfUserName
                title: "نام کاربری"
                placeholderText2: "نام کاربری"
                Layout.fillWidth: true
                Layout.preferredHeight: 54
                Layout.leftMargin: 18
                Layout.rightMargin: 18
                text: userProfile.userName
            }
            TextFieldLabeld{
                id: tfEmail
                title: "ایمیل"
                placeholderText2: "ایمیل"
                Layout.fillWidth: true
                Layout.preferredHeight: 54
                Layout.leftMargin: 18
                Layout.rightMargin: 18
                text: userProfile.email
            }
            TextFieldLabeld{
                id: tfPhoneNumber
                title: "شماره موبایل"
                placeholderText2: "شماره موبایل"
                Layout.fillWidth: true
                Layout.preferredHeight: 54
                Layout.leftMargin: 18
                Layout.rightMargin: 18
                text: userProfile.phoneNumber
                inputMethodHints: Qt.ImhDigitsOnly
            }
            TextFieldLabeld{
                id: tfUserScore
                title: "امتیاز کاربر"
                placeholderText2: "امتیاز کاربر"
                Layout.fillWidth: true
                Layout.preferredHeight: 54
                Layout.leftMargin: 18
                Layout.rightMargin: 18
                text: userProfile.score
                enabled: false
                onFocusChanged: {
                    if(focus){
                        flickable.bringYToVisibleArea(y+height);
                    }
                }
            }
            JooyaButton{
                id: btnSave
                text: "ذخیره"
                Layout.fillWidth: true
                highlighted: true
                onClicked: {
                    userProfile.saveProfile(userId);
                }
                onFocusChanged: {
                    if(focus){
                        flickable.bringYToVisibleArea(y+height);
                    }
                }
            }
            Item {
                Layout.fillHeight: true
            }
        }
        ScrollBar.vertical: ScrollBar{
            width: 9
        }
    }

    ConfirmationDialog {
        id:deleteDialog
        message: "آیا مایل هستید تصویر را حذف کنید؟"
        onYesClicked: {
            currentImage.deleteItem();
        }
    }
}

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import Jooya
import "../manager"
import "../../jooyaQuickControls"
import "../../items/common"

Item {
    id:notifyItem
    property Notify notify: null
    Connections{
        target: notify
        function onDeleteSucceed() {
            console.log("is going to close deleted dialog");
            delDialog.close();
        }
    }
    ColumnLayout {
        anchors.fill: parent
        spacing: 18
        Rectangle{
            id:imgContainer
            Layout.preferredWidth: notifyItem.width
            Layout.preferredHeight: notifyItem.height/2
            color: MaterialStyle.primary100
            Layout.alignment: Qt.AlignTop
            ImageItem{
                id:imgItem
                imageFile: notify
                anchors.fill: parent
                imageFillMode:Image.PreserveAspectCrop
            }
            RoundButton{
                id:btnMenuNotify
                visible: CurrentUser.isLoggedIn&&CurrentUser.isAdmin
                width: 54
                height: width
                highlighted: true
                anchors.bottom: parent.bottom
                anchors.bottomMargin: -(height/2)
                anchors.left: parent.left
                anchors.leftMargin: 9
                contentItem: Image {
                    fillMode: Image.Pad
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "../../images/common/dots-vertical.png"
                }
                onClicked: {
                    mnuNotify.open();
                }
            }
        }

        Text {
            id:introTitle
            font {
                pixelSize:30
                family: flYekan.name
                bold: true
            }
            color: MaterialStyle.primaryTextColor
            text: notify.title
            Layout.alignment: Qt.AlignHCenter|Qt.AlignTop
        }
        Text {
            id:introComment
            font {
                pixelSize: 15
                family: flYekan.name
            }
            Layout.rightMargin: 16
            Layout.leftMargin: 16
            Layout.preferredHeight: 200
            Layout.fillWidth: true
            color: MaterialStyle.primaryTextColor
            wrapMode: Text.WordWrap
            Layout.alignment: Qt.AlignHCenter|Qt.AlignTop
            text: notify.description
        }
        Item {
            Layout.fillHeight: true
        }
    }

    Menu{
        id: mnuNotify
        width: 100
        x:btnMenuNotify.x+9
        y:btnMenuNotify.y+btnMenuNotify.height
        MenuItem{
            contentItem: Text{
                text: qsTr("حذف")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font{
                    family: flYekan.name
                    pixelSize: 12
                }
            }
            onTriggered: {
                delDialog.open();
            }
        }
        MenuItem{
            contentItem: Text{
                text: qsTr("ویرایش")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font{
                    family: flYekan.name
                    pixelSize: 12
                }
            }
            onTriggered: {
                if(notify.type==NotificationTypes.AppIntroducing){
                    sv.push("../manager/NotifyAppIntroEditDialog.qml",{notify:notify});
                }
                else if(notify.type==NotificationTypes.Discount){
                    var discountCom= discountDialogCom.createObject(mainWindow);
                    discountCom.open();
                }
            }
        }
        MenuItem{
            contentItem: Text{
                text: qsTr("نوع هشدار")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font{
                    family: flYekan.name
                    pixelSize: 12
                }
            }
            onTriggered: {
                var obj= comTypeDialog.createObject(mainWindow);
                obj.open();
            }
        }
    }

    Component{
        id:comTypeDialog
        NotificationTypeEditDialog{
            id:typeDialog
        }
    }
    Component{
        id:discountDialogCom
        NotifyDiscountEditDialog{
        }
    }
    ConfirmationDialog {
        id: delDialog
        message: "آیا مایل به حذف هشدار هستید؟"
        onYesClicked: {
            notify.deleteItem();
        }
    }
}

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import QtQuick.Layouts
import "../../jsf/Bootstrap.js" as Bs
import Jooya
import "../../jooyaQuickControls"

Item{
    id: root
    property User user

    Connections{
        target:user
        function onIsProcessingChanged(isProcessing) {
            bipi.visible=isProcessing;
        }
    }
    IranSanseFontLoader{
        id:flIran
    }
    Pane{
        id: cl
        Material.elevation: 1
        Material.background: MaterialStyle.primary100
        anchors.fill: parent
        anchors.margins: 9
        padding: 0
        ColumnLayout{
            anchors.fill: parent
            anchors.topMargin: 5
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.bottomMargin: 5

            spacing: 5

            PropertyItemRow{
                id: rowId
                key: "نام کاربری"
                value: user.userName
            }
            PropertyItemRow{
                id: rowDate
                key: "تاریخ عضویت"
                value: user.registerDate
                valueFontName: flIran.name
            }
        }
        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton|Qt.RightButton
            onPressAndHold: {
                if(mouse.button===Qt.LeftButton){
                    mnuUser.x=mouse.x;
                    mnuUser.y=mouse.y;
                    mnuUser.popup();
                }
            }
            onClicked: {
                if(mouse.button===Qt.LeftButton){
                    svManaging.push("UserProfilePage.qml",{userId:user.userId,userName:user.userName});
                }
                else{
                    mnuUser.x=mouse.x;
                    mnuUser.y=mouse.y;
                    mnuUser.popup();
                }
            }
        }
        JooyaMenu{
            id:mnuUser
            JooyaMenuItem{
                jtext: "نقش ها"
                onClicked: {
                    svManaging.push("../manager/UserRolesPage.qml",{user:user});
                }
            }
            JooyaMenuItem{
                jtext: "خرید ها"
                onClicked: {
                    svManaging.push("../orders/BaskeBankPage.qml",{user:user});
                }
            }
        }
    }
}

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import Jooya
import "../../jooyaQuickControls"

JooyaGridView{
    id:keywordPage
    KeywordManager{
        id:keyManager        

    }
    property int parentId: 0
    property Keyword selectedKeyword: null

    Component.onCompleted: {
        keyManager.getList(parentId);
    }
    cellWidth:keywordPage.width
    cellHeight:70
    delegate: KeywordItem {
        keyword: currentKeyword
        width: keywordPage.cellWidth
        height: keywordPage.cellHeight
    }
    model:keyManager.listModel
    onScrolledUp: {
        btnAdd.stateVisible=false
    }
    onScrolledDown: {
        btnAdd.stateVisible=true;
    }
    ConfirmationDialog{
        id: deleteDialog
        message: qsTr("آیا مایل به حذف کردن کلمه کلیدی هستید؟")
        onYesClicked: {
            selectedKeyword.deleteItem();
            deleteDialog.close();
        }
    }

    RoundButton{
        id: btnAdd
        Material.elevation:4
        property bool stateVisible: true
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
            keyManager.addNewItem(parentId);
        }
        scale: stateVisible?1.0:0.0
        Behavior on scale {
            NumberAnimation{
                easing.type: Easing.InOutBounce
                duration: 150
            }
        }
    }
}

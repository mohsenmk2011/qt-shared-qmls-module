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
    signal itemClicked(Keyword keyword);

    property Keyword keyword: null
    Pane {
        id:pane
        Material.elevation:1
        Material.background: MaterialStyle.primary100
        rightPadding: 18
        leftPadding: 18
        padding: 0
        anchors.centerIn: parent
        height: 63
        width:parent.width-18
        MouseArea{
            anchors.fill: parent
            onClicked: {
                itemClicked(root.targetUrl);
            }
        }
        RowLayout{
            anchors.fill: parent
            layoutDirection: Qt.RightToLeft
            Text {
                id: txtValue
                text: keyword.value
                color: MaterialStyle.primaryTextColor
                Layout.fillHeight: true
                width: parent.width/2
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font{
                    family: flYekan.name
                    pixelSize: 18
                }
            }
            Item {
                Layout.fillWidth: true
            }
            ToolButton{
                id:btnDelete
                JooyaToolTip{
                    text: "حذف کلمه کلیدی"
                }
                contentItem: Image {
                    fillMode: Image.Pad
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    source: "../../images/common/delete.png"
                }
                onClicked: {
                    selectedKeyword=keyword;
                    deleteDialog.open();
                }
            }
            ToolButton{
                id:btnEdit
                JooyaToolTip{
                    text: "ویرایش کلمه کلیدی"
                }
                contentItem: Image {
                    fillMode: Image.Pad
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    source: "../../images/common/pencil.png"
                }
                onClicked: {
                    svManaging.push("/pages/manager/KeywordAddPage.qml",{keyword:keyword});
                }
            }
            ToolButton{
                id:btnAdd
                visible: keyword.parentId==0
                JooyaToolTip{
                    text: "افزودن کلمه کلیدی"
                }
                contentItem: Image {
                    fillMode: Image.Pad
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    source: "../../images/common/plus.png"
                }
                onClicked: {
                    if(keyword.parentId==0){
                        svManaging.push("/pages/manager/KeywordPage.qml",{parentId:keyword.keywordId});
                    }
                }
            }
        }
    }
}


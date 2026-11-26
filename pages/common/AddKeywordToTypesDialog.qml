import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Dialogs
import QtQuick.Layouts
import Jooya
import QtQuick
import QtQml.Models
import "../../jooyaQuickControls"
import "../items"
import "../manager/app"
import "../manager"


JooyaDialog{
    id:keywordsDialog
    property int rootWidth:mainWindow.width
    property int rootHeight:mainWindow.height
    parent: ApplicationWindow.overlay
    progressIndicatorVisible: selectedNotify.isProcessing

    x: (rootWidth-width)/2
    y: (rootHeight-height) / 2

    width: 300
    height: 300+rowBtns.implicitHeight
    padding: 0
    background: Rectangle{
        color: "yellow"
    }

    JooyaGridView {
        id: gvParentKeywords
        anchors.fill: parent
        cellWidth:keywordsDialog.width
        cellHeight:210

        delegate: Rectangle {
            width: gvParentKeywords.cellWidth
            height: gvParentKeywords.cellHeight
            color: "black"
            Pane {
                id:pane
                Material.elevation:3
                padding: 0
                anchors.centerIn: parent
                height: 200
                width:parent.width-20
                ColumnLayout{
                    anchors.fill: parent
                    Rectangle{
                        Layout.fillWidth: true
                        height: 45
                        color: "#b4004e"
                        Text {
                            text:currentKeywordType.value
                            color: "white"
                            anchors.fill: parent
                            font{
                                pixelSize: 19
                                bold: true
                            }
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    JooyaGridView {
                        id:gvKeywords
                        Layout.fillWidth: true
                        leftMargin: 3
                        rightMargin:3
                        height: 45
                        cellWidth:80
                        cellHeight:35
                        delegate: KeywordPane {
                            width: gvKeywords.cellWidth-9
                            height: gvKeywords.cellHeight
                            content:currentKeyword.value
                            selected: currentKeyword.selected
                            onItemClicked: {
                                if(currentKeyword.selected){
                                    selectedNotify.removeKeyword(currentKeyword.keywordId);
                                }
                                else{
                                    selectedNotify.addKeyword(currentKeyword.keywordId);
                                }
                            }
                        }
                        model: currentKeywordType.keywords
                    }
                    Item {
                        Layout.fillHeight: true
                    }
                }
            }
        }
        model: selectedNotify.keywords
    }
    onVisibleChanged: {
        if(gvParentKeywords.visible){
            selectedNotify.message=keywordsDialog.myMessage;

            selectedNotify.loadKeywords();
        }
    }
    RowLayout{
        id: rowBtns

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        layoutDirection: Qt.RightToLeft
        anchors.bottomMargin: 0
        JooyaButton{
            Layout.fillWidth: true
            text: "بستن"
            onClicked: {
                keywordsDialog.close();
            }
        }
    }
}

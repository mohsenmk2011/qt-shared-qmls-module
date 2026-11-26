import QtQuick
import QtQuick.Controls
import "../../jsf/Bootstrap.js" as Bs
import Jooya
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import "../../jooyaQuickControls"
import QtQuick.Layouts
import "../../items/common"

Page {
    id:fileExplorerDialog

    property string selectedUrl: null
    property string startupFolder: ""
    Component.onCompleted: {
        explorer.getList();
    }
    FileExplorer
    {
        id:explorer
        folderPath: startupFolder
    }
    header: ToolBar{
        id: tbheader
        Material.elevation:1
        anchors.margins: 0
        RowLayout{
            anchors.fill: parent
            anchors.margins: 0
            ToolButton{
                contentItem: Image {
                    source: "../../images/common/window-close.png"
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                }
                onClicked: {
                    close();
                }
            }
            Item {
                Layout.fillWidth: true
            }
            ToolButton{
                contentItem: Image {
                    source: "../../images/common/magnify.png"
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                }
                onClicked: {
                    console.log("search tool button clicked");
                }
            }
        }
    }
    // ==========================[ end of toolbar ]==========================
    JooyaGridView{
        id: gvImages

        anchors.fill: parent
        cellWidth: width/3
        cellHeight:cellWidth
        property ImageFile selectedImage: null
        delegate: Rectangle{
            width: gvImages.cellWidth
            height: gvImages.cellHeight
            color: MaterialStyle.primary100
            ImageItem{
                anchors.fill: parent
                imageFile:model
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        console.log("imageFile.id => "+model.fileId);
                        console.log("imageFile.url => "+model.url);
                        console.log("imageFile.downloadLink => "+model.downloadLink);

                        selectedUrl = model.url
                        console.log("display admin toolbar");

                        if(model.url===""&& false){
                            sv.push("../common/ImageEditor.qml",{imageFile:parent.imageFile,clipSize:Qt.size(300,300)});
                        }
                        else{

                        }
                    }
                }
            }

        }

        model: explorer.listModel

        onScrolledUp: {
            btnAddImage.stateVisible=false;
        }
        onScrolledDown: {
            btnAddImage.stateVisible=true;
        }
    }
}

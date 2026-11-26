import QtQuick
import QtQuick.Controls
import Jooya
import QtQuick.Layouts
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material

Item{
    id:itemimg
    property ImageFile imageFile: null
    signal deleteItem(int itemId);
    Image {
        id: imgDefault
        source: "../images/common/image-filter-hdr.png"
        width: 27
        height: 27
        visible: !img.visible
        anchors.centerIn: parent
    }
    Image {
        id:img
        anchors.fill: parent
        source: imageFile.isExists ? imageFile.url:""
        visible: imageFile.name!=="" && imageFile.isExists
    }
    RoundButton {
        id: btnDownload
        width: 72
        height: 72
        highlighted: true
        visible: !imageFile.isExists&&!imageFile.isProcessing && imageFile.name!==""
        anchors.centerIn: parent
        Material.elevation: 1
        contentItem: Image {
            fillMode: Image.Pad
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../images/common/download.png"
        }
        JooyaToolTip {
            text:"دانلود عکس"
        }
        onClicked: {
            btnDownload.visible=false
            imageFile.download();
        }
    }
    ProgressBar{
        visible: imageFile!=null && imageFile.isProcessing
        from: 0
        to: 1
        height: 3
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        indeterminate: true
    }
}

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Jooya

Dialog {
    property alias progressIndicatorVisible: bipi.visible
    property bool isBig: false
    property bool isFixHeight: false
    property int fixHeight: 250
    leftPadding: 0
    rightPadding: 0
    topPadding: 0
    parent: Overlay.overlay
    dim: true
    Overlay.modeless: Rectangle {
        color: "#aacfdbe7"
        MouseArea{
            acceptedButtons: Qt.LeftButton|Qt.RightButton
            anchors.fill: parent
            onClicked: {
                close();
            }
        }
    }
    closePolicy: Popup.NoAutoClose

//    WindowSizeManager{
//        id: windowSizeManager

//        xsWidth: isBig?12:10
//        smWidth:  isBig?8:8
//        mdWidth:  isBig?6:4
//        lgWidth: isBig?4:3
//        xlWidth:  isBig?3:3

//        xsHeight: isBig?12:12
//        smHeight:  isBig?12:8
//        mdHeight:  isBig?10:6
//        lgHeight: isBig?10:4
//        xlHeight:  isBig?8:3

//        rootWidth: mainWindow.width
//        rootHeight: mainWindow.height
//    }

//    x: windowSizeManager.x
//    y:  windowSizeManager.y

//    width: windowSizeManager.width
//    height:isFixHeight?fixHeight: windowSizeManager.height
    ProgressIndicator{
        id: bipi
    }   
}

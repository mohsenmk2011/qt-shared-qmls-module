import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material

Flickable {
    id: view
    signal refresh();
    clip: true
    boundsBehavior: Flickable.StopAtBounds

    function isVisible(y){
        return isInBorder(y, contentY,contentY+height);
    }
    function bringYToVisibleArea(y){
        if(!isVisible(y)){
            contentY=(y-height)+36;
        }
    }
    function isInBorder(x1,bx1,bx2){
        return x1>=bx1&&x1<=bx2;
    }
    RoundButton{
        id: swatch
//        parent: Overlay.overlay
        parent: Overlay.overlay

        anchors.horizontalCenter: parent.horizontalCenter
        Material.elevation: 2
        width: 63
        height: 63
        x:0
        y: -63
        opacity: 0
        Material.background: y>height?Material.primary:Material.Grey
        highlighted: true
        contentItem: Image {
            fillMode: Image.Pad
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../images/common/refresh.png"
        }
    }

    MouseArea {        
        property int mouseYSart
        property int biggerMouseY
        anchors.fill: parent
        onPressed: {
            mouseYSart = mouseY
            biggerMouseY = 0
        }
        onMouseYChanged: {
            if(view.contentY === 0) {
                swatch.rotation+=3;
                var currentMouseY = mouseY
                if(currentMouseY > biggerMouseY) {
                    biggerMouseY = currentMouseY
                    swatch.opacity+=0.06
                    if(swatch.y<=(swatch.height*1.8)){
                        swatch.y += 6
                    }
                }
                else if(currentMouseY < biggerMouseY) {
                    biggerMouseY = currentMouseY
                    swatch.y -= 6
                    swatch.opacity-=0.06
                }
            }
        }
        onReleased:
        {
            swatch.opacity=0;
            if(swatch.y>swatch.height){
                console.log("&&&[ Refresh content ]&&&");
                refresh();
            }
            swatch.y = - swatch.height
        }
    }
    ScrollBar.vertical: ScrollBar
    {
        width:9
    }

}

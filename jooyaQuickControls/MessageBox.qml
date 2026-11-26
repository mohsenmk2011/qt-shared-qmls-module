import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import Jooya

Dialog{
    id: root
    property int rootWidth: mainWindow.width
    property int rootHeight: mainWindow.height
    property alias message: me
    parent: ApplicationWindow.overlay
    x: (rootWidth - width)/2
    y: (rootHeight-height) / 2
    height: 140
    width: 300
    bottomPadding: 10
    FontLoaderYekan{
        id: fl
    }
    property int contentFontSize: 15
    Message{
        id: me
        onVisibleChanged: {
            if(me.visible){
                root.open();
            }
            else{
                root.close();
            }
        }
        onContentChanged: {
            console.log("*****************************");
            console.log(me.content);
            console.log(message.content);
            console.log("*****************************");
        }
    }

    font{
        family: flYekan.name
        pixelSize: 18
        bold: true
    }
    //================================================
    Flickable{
        id: flickable
        anchors.fill: parent
        flickableDirection: Flickable.StopAtBounds
        clip: true
        Text {
            id: mainClm
            anchors.fill: parent

            verticalAlignment: Text.AlignTop
            horizontalAlignment: Text.AlignRight
            wrapMode: Text.WordWrap
            padding: 5
            font{
                pixelSize: contentFontSize
                family: flYekan.name
            }
            color:MaterialStyle.primaryTextColor
            text: me.content
        }
        ScrollBar.vertical: ScrollBar{
            width: 5
        }
    }

    onClosed: {
        message.visible=false;
    }
}

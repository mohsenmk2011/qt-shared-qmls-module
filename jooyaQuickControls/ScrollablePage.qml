import QtQuick
import QtQuick.Controls

Page
{
    id: root
    property int rootWidth: width
    default property alias content: pane.contentItem

    Flickable {
        anchors.fill: parent
        contentHeight: pane.implicitHeight
        flickableDirection: Flickable.AutoFlickIfNeeded

        Pane {
            id: pane
            width: parent.width
        }

        ScrollBar.vertical: ScrollBar{

        }
    }   
}

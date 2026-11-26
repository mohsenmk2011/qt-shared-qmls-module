import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Shapes
import "../../jooyaQuickControls"
import "../../items/common"
import JooyaQuick.Controls.Material

Page {
            id: page
            property string imageUrl: ""
            Component.onCompleted: {

            }
            ImageViewerItem{
                        imageUrl: page.imageUrl
                        anchors.fill: parent
            }
}

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material

MenuItem {
    property alias jtext: txt.text
    contentItem: Text{
        id:txt
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        font{
            family: flYekan.name
            pixelSize: 12
        }
        color: MaterialStyle.primaryTextColor
    }
}

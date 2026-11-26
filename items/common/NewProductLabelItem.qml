import QtQuick
import QtQuick.Controls
import JooyaQuick.Controls.Material

Rectangle{
    property alias content: txtContent.text
    clip: true
    width: txtContent.width+txtContent.height
    height: width
    color: "transparent"
    Rectangle {
        id: newLabel
        y:74
        x:-35
        width: txtContent.width+90
        height: txtContent.height
        color: MaterialStyle.secondaryTextColor
        transformOrigin: Item.TopLeft
        rotation: -45
        Text {
            id:txtContent
            anchors.centerIn: parent
            font{
                family: flYekan.name
                bold: true
            }
            color: MaterialStyle.invertedPrimaryTextColor
        }
    }

}

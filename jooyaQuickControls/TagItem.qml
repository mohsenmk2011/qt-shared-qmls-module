import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material

Pane{
    signal selectedChanged()
    property alias text: lbl.text
    property bool isSelected: false
    property string fontFamily: flYekan.name
    property alias textFont: lbl.font
    property color backColor: isSelected ? MaterialStyle.invertedPrimaryTextColor : MaterialStyle.primaryTextColor
    property color foreColor: isSelected ? MaterialStyle.primaryTextColor : MaterialStyle.invertedPrimaryTextColor

    Material.elevation: 1
    Material.background: backColor
    width: lbl.width+18
    height: lbl.height
    padding: 0
    Label {
        id:lbl
        text: "yourTag"
        font {
            family: fontFamily
            pixelSize: 15
            bold: true
        }
        color: foreColor
        anchors.centerIn: parent
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            isSelected = !isSelected
            selectedChanged();
        }
    }
}

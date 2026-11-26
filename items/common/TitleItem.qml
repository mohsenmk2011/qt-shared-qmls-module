import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material

Rectangle{
    id:titleContainer

    //=======================< properties of container >=======================
    property bool borderVisible: false
    //=======================< properties of title >=======================
    property string title
    property alias titleHorizontalAlignment: lblTitle.horizontalAlignment
    property color backColor

    color: backColor
    width: lblTitle.implicitWidth+9
    height: 18
    anchors.bottom: parent.top
    anchors.bottomMargin: -height/1.5
    radius: 3    
    Label{
        id:lblTitle
        anchors.horizontalCenter: parent.horizontalCenter
        verticalAlignment: Label.AlignVCenter
        text: title
        color: MaterialStyle.invertedPrimaryTextColor
        font{
            family: flYekan.name
            pixelSize: 12
        }
    }
}

import QtQuick
import QtQuick.Controls
import "../jsf/Bootstrap.js" as Bs
import QtQuick.Layouts

TextField
{
    property int rootWidth: 300
    EnterKey.type: Qt.EnterKeyNext
    font
    {
        family:flYekan.name
        pixelSize:Bs.bootFontSize(rootWidth,"xs-20 sm-24 md-28 lg-32 xl-35");
        bold:false
    }
    horizontalAlignment: Text.AlignHCenter
    anchors.topMargin: 27
    Layout.fillWidth: true
    Layout.leftMargin: 9
    Layout.rightMargin: 9
    Keys.onReturnPressed: {
        nextItemInFocusChain().forceActiveFocus();
    }
}

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

Button {
    Material.roundedScale: Material.ExtraSmallScale
    highlighted: true
    hoverEnabled: true
    Layout.fillWidth: true
    font.family: mainFontName
    Layout.leftMargin: 9
    Layout.rightMargin: 9
    font.pixelSize: 16
}

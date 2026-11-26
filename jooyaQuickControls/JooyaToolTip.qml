import QtQuick
import QtQuick.Controls

ToolTip{    
    visible:parent.hovered|parent.down
    delay: Qt.styleHints.mousePressAndHoldInterval
    text: "متن راهنما"
    font.family: fontToolTip
    timeout: 4000
}

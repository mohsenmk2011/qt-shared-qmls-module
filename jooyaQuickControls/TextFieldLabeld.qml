import QtQuick
import QtQuick.Controls
import JooyaQuick.Controls.Material
import "../items/common"

TextField{
    id:tfContent
    //=================< properties of TextField >===================
    property string helpTitle: ""
    property string title: ""
    property string placeholderText2: ""

    //=================< properties of background >===================
    property string backColor: MaterialStyle.primary100
    property bool borderVisible: false
    //====================================
    color: MaterialStyle.primaryTextColor
    EnterKey.type: Qt.EnterKeyNext
    verticalAlignment : TextField.AlignVCenter
    topPadding: 0
    bottomPadding: 0
    rightPadding: 18
    leftPadding: 18
    font{
        family: flYekan.name
        pixelSize: 18
    }

    background: Rectangle{
        id:tfBack
        color: backColor
        border.color:  MaterialStyle.primary200
        border.width: borderVisible? 2:0
        radius: 3
        Text{
            visible: placeholderText2 != "" && !tfTitle.visible
            text: placeholderText2
            font: tfContent.font
            anchors.fill: parent
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: tfContent.horizontalAlignment
            anchors.rightMargin: 18
            anchors.leftMargin: 18
            color: tfContent.color
            opacity: 0.45
        }
    }
    TitleItem{
        id:tfTitle
        backColor: MaterialStyle.primary200
        x:tfContent.horizontalAlignment===TextField.AlignRight ? tfContent.width - width - 18 : 18
        visible: {
            if(helpTitle!=""){
                return tfContent.activeFocus||tfContent.text !="";
            }
            return tfContent.text !="";
        }
        title: {
            if(helpTitle!=""){
                if(tfContent.text===""){
                    return helpTitle
                }
            }
            return parent.title;
        }
    }
}

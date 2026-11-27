import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Jooya
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import "../../jooyaQuickControls"
import "../../items/common"

Rectangle{
    id:talkItem
    property Post post: null
    property real ballonMaxWidth: 0.0
    property bool lblContentShouldSherink: tempText.width>(ballonMaxWidth-(45+rowTalkProperties.width))
    color: post.isSelected ? MaterialStyle.secondary200: "transparent"   
    property bool seen:
    {
        //NOTE: Is item is visivle in list ?
        //APPSTEP: change post status to seen
        if(post==null){
            return false;
        }
        var t=lvTalks.isVisible(talkItem.y);
        if(t){
            post.sendSeenStatus();
        }
        return t;
    }
    height: mainTalkRow.implicitHeight
    Label{
        id:tempText
        visible: false
        font {
            family: flYekan.name
        }
        text: post.content
        wrapMode: Text.NoWrap

    }
    MouseArea{
        anchors.fill: parent
        onPressAndHold: {
            if(post.isJustDate){
                return;
            }
            if(!conversation.selectMode){
                conversation.selectMode=true;
                post.isSelected=true;
            }
        }
        onClicked: {
            if(conversation.selectMode){
                post.isSelected=!post.isSelected;
            }
            console.log("gridLayout.columns => "+gridLayout.columns)

            console.log("tempText.width => "+tempText.width)

            console.log("ballonMaxWidth => "+ballonMaxWidth)


            console.log("rowTalkProperties.width => "+rowTalkProperties.width)
            console.log("18(margin) => "+(18));

            console.log("lblContent.width => "+lblContent.width)

            //tempText.width>(ballonMaxWidth-(18+paneTalkContent.cornerWidth+rowTalkProperties.implicitWidth))?(ballonMaxWidth-(18+paneTalkContent.cornerWidth)):tempText.width
        }
    }
    RowLayout{
        id:mainTalkRow
        anchors.fill: parent
        Balloon {
            id:paneTalkContent
            visible: !post.isJustDate
            rightAligned: post.fromMe
            Layout.alignment:post.fromMe? Qt.AlignRight:Qt.AlignLeft
            Layout.maximumWidth: ballonMaxWidth
            Layout.preferredWidth: lblContent.implicitWidth+rowTalkProperties.width+45
            Layout.preferredHeight: lblContentShouldSherink?(lblContent.implicitHeight+18+rowTalkProperties.height):(lblContent.implicitHeight+18)
            Layout.rightMargin: 9
            Layout.leftMargin: 9
            Layout.bottomMargin: post.isLastItem? 18:0
            radius: 6

            color: MaterialStyle.secondary100
            Material.elevation: 3
            clip: true
            GridLayout{
                id:gridLayout
                LayoutMirroring.enabled: true
                LayoutMirroring.childrenInherit: true
                anchors.fill: parent
                anchors.leftMargin: 18
                anchors.rightMargin: 18
                anchors.topMargin: 9
                anchors.bottomMargin: 9
                flow: lblContentShouldSherink ? GridLayout.TopToBottom : GridLayout.LeftToRight
                columns: 1
                Label {
                    id:lblContent

                    Layout.fillHeight: true
                    Layout.maximumWidth: ballonMaxWidth-45
                    Layout.preferredWidth: lblContentShouldSherink ?(ballonMaxWidth-45):tempText.width
                    Layout.alignment: Qt.AlignTop|Qt.AlignLeft
                    Layout.rightMargin: 9
                    font {
                        family: flYekan.name
                    }
                    text: post.content
                    wrapMode: Text.WordWrap
                    textFormat: Text.MarkdownText
                    color: MaterialStyle.primaryTextColor
                }
                Row{
                    id:rowTalkProperties
                    Layout.alignment: Qt.AlignBottom|Qt.AlignRight
                    spacing: 6
                    Text {
                        text: post.hour
                        font{
                            pixelSize: 10
                            family: flIranSanse.name
                        }
                        color: MaterialStyle.primaryTextColor
                    }
                    IconImage {
                        id:imgStatus
                        width: 18
                        height: 18
                        visible: post.fromMe && !talkBusyIndicator.visible
                        source:{
                            if(post.status===TalkStates.NotSend){
                                return "../../images/chat/clock-time-three-outline.png";
                            }
                            else if(post.status===TalkStates.Send){
                                return "../../images/chat/check.png";
                            }
                            else if(post.status===TalkStates.Received){
                                return "../../images/chat/check-all.png";
                            }
                            else if(post.status===TalkStates.Seen){
                                return "../../images/chat/check-all.png";
                            }
                            else if(post.status===TalkStates.Deleted){
                                return "../../images/common/delete.png";
                            }
                        }
                        color:post.status!==TalkStates.Seen?MaterialStyle.iconColor:Material.color(Material.Blue)
                    }
                    BusyIndicator {
                        id:talkBusyIndicator
                        width: 18
                        height: 18
                        visible: post.isProcessing && post.operationType==OperationTypes.IsDeleting
                    }
                }
            }
        }

        Rectangle{
            visible: !paneTalkContent.visible
            Layout.alignment:Qt.AlignHCenter
            Material.elevation: 3
            Layout.preferredWidth: lbl.width+18
            Layout.preferredHeight: lbl.height+6
            radius: 3
            color: MaterialStyle.secondaryTextColor
            Label {
                id:lbl
                text: post.dateText
                font {
                    family: flIranSanse.name
                    pixelSize: 15
                    bold:true
                }
                color: "white"
                anchors.centerIn: parent
            }
        }
    }
}


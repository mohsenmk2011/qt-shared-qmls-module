import QtQuick
import QtQuick.Controls
import "../../jsf/Bootstrap.js" as Bs
import "../../jooyaQuickControls"
import QtQuick.Layouts
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import Jooya
import Qt.labs.qmlmodels

Page{
    id: root
    objectName: "SharePage"
    AppPagesManager{
        id:pm
    }
    property string currentUserReferralLink: ""
    Component.onCompleted: {
        pm.mainWindow.to
        backShortcut.enabled=false
        user.getReferralCode();
    }
    Component.onDestruction: {
        backShortcut.enabled=true
    }
    Shortcut {
        id:backShortcutSharePage
        sequences: ["Esc", "Back"]
        onActivated: {
            console.log("Back Shortcut In Share Page")
            if(sv.depth>1)
            {
                sv.pop();
            }
            else if(drawer.visible){
                drawer.close();
            }
            else{
                exitDialog.open();
            }
        }
    }
    property bool linkIsReady: false
    User{
        id:user
        onReferralInfoIsReady: {
            linkIsReady=true
            console.log("referral link => " +referralLink);
            console.log("clicks => " +clicks);
            console.log("signedUps => " +signedUps);
            currentUserReferralLink=referralLink;
            txtClicks.text=clicks;
            txtSignedUps.text=signedUps;
        }
        onIsProcessingChanged: {
            progressIndicator.visible=isProcessing;
        }
    }
    ShareManager{
        id:shareManager
    }
    JooyaFlickable{
        anchors.fill: parent
        contentHeight: clm.implicitHeight
        ColumnLayout{
            id:clm
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: Bs.bootSize(root.width,"xs-11 sm-10 md-8 lg-6 xl-4")
            spacing: 9
            Pane{
                id:paneDiscountMessage
                Material.elevation: 1
                Material.background: MaterialStyle.primary100
                Layout.fillWidth: true
                Layout.margins: 9
                Layout.preferredHeight: 351
                ColumnLayout{
                    anchors.fill: parent
                    spacing: 9
                    Text {
                        id:txtLink
                        text:  "اپلیکیشن " + CurrentApplication.name + " را به دوستانتان معرفی کنید و تحفیف دریافت نمایید"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 36
                        wrapMode: Text.WordWrap
                        font.family: flYekan.name
                        font.pixelSize: 12
                        color: MaterialStyle.primaryTextColor
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Row{
                        spacing: 1
                        Layout.alignment: Qt.AlignHCenter|Qt.AlignTop
                        Layout.preferredWidth: 207

                        Rectangle{
                            implicitWidth: 100
                            implicitHeight: 36
                            border.width: 1
                            border.color:MaterialStyle.secondary300
                            color:MaterialStyle.secondary200
                            Text {
                                text: "تعداد دوستان"
                                anchors.centerIn: parent
                                font.family: flYekan.name
                                color: MaterialStyle.primaryTextColor
                            }
                        }
                        Rectangle{
                            implicitWidth: 100
                            implicitHeight: 36
                            border.width: 1
                            border.color:MaterialStyle.secondary300
                            color:MaterialStyle.secondary200
                            Text {
                                text: "مقدار تخفیف"
                                anchors.centerIn: parent
                                font.family: flYekan.name
                                color: MaterialStyle.primaryTextColor
                            }
                        }
                        Item {
                            Layout.fillWidth: true
                        }
                    }

                    TableView{
                        id:tblDiscountPercent
                        clip: true
                        columnSpacing: 1
                        rowSpacing: 1
                        Layout.alignment: Qt.AlignHCenter|Qt.AlignTop
                        contentHeight: 225
                        Layout.preferredHeight: 225

                        Layout.preferredWidth: 207
                        contentWidth: 207
                        delegate: Rectangle{
                            implicitWidth: 100
                            implicitHeight: 36
                            border.width: 1
                            border.color:MaterialStyle.secondary300
                            color:MaterialStyle.secondary200
                            Text {
                                text: display
                                anchors.centerIn: parent
                                color: MaterialStyle.primaryTextColor
                            }
                        }

                        model:TableModel{
                            TableModelColumn{
                                display: "refferalcount"
                            }
                            TableModelColumn{
                                display: "discountpercent"
                            }
                            rows:[
                                {
                                    "refferalcount":"1",
                                    "discountpercent":"18%"
                                },
                                {
                                    "refferalcount":"2",
                                    "discountpercent":"36%"
                                },
                                {
                                    "refferalcount":"3",
                                    "discountpercent":"54%"
                                },
                                {
                                    "refferalcount":"4",
                                    "discountpercent":"72%"
                                },
                                {
                                    "refferalcount":"5",
                                    "discountpercent":"90%"
                                },
                                {
                                    "refferalcount":"6",
                                    "discountpercent":"99%"
                                },
                            ]
                        }


                    }
                    Item{
                        Layout.fillHeight: true
                    }
                }
            }
            Pane{
                Material.elevation: 1
                Material.background: MaterialStyle.primary100
                Layout.fillWidth: true
                Layout.margins: 9
                Layout.preferredHeight: 171
                ColumnLayout{
                    anchors.fill: parent
                    spacing: 1
                    Row{
                        spacing: 1
                        Layout.alignment: Qt.AlignHCenter|Qt.AlignTop
                        Layout.preferredWidth: 207
                        Layout.topMargin: 9
                        Rectangle{
                            implicitWidth: 100
                            implicitHeight: 36
                            border.width: 1
                            border.color:MaterialStyle.secondary300
                            color:MaterialStyle.secondary200
                            Text {
                                id:txtClicks
                                text: "0"
                                anchors.centerIn: parent
                                font.family: flYekan.name
                                color: MaterialStyle.primaryTextColor
                            }
                        }
                        Rectangle{
                            implicitWidth: 100
                            implicitHeight: 36
                            border.width: 1
                            border.color:MaterialStyle.secondary300
                            color:MaterialStyle.secondary200
                            Text {
                                text: "تعداد کلیک ها"
                                anchors.centerIn: parent
                                font.family: flYekan.name
                                color: MaterialStyle.primaryTextColor
                            }
                        }
                        Item {
                            Layout.fillWidth: true
                        }
                    }
                    Row{
                        spacing: 1
                        Layout.alignment: Qt.AlignHCenter|Qt.AlignTop
                        Layout.preferredWidth: 207
                        Rectangle{
                            implicitWidth: 100
                            implicitHeight: 36
                            border.width: 1
                            border.color:MaterialStyle.secondary300
                            color:MaterialStyle.secondary200
                            Text {
                                id:txtSignedUps
                                text: "0"
                                anchors.centerIn: parent
                                font.family: flYekan.name
                                color: MaterialStyle.primaryTextColor
                            }
                        }
                        Rectangle{
                            implicitWidth: 100
                            implicitHeight: 36
                            border.width: 1
                            border.color:MaterialStyle.secondary300
                            color:MaterialStyle.secondary200
                            Text {
                                text: "تعداد ثبت نام"
                                anchors.centerIn: parent
                                font.family: flYekan.name
                                color: MaterialStyle.primaryTextColor
                            }
                        }
                        Item {
                            Layout.fillWidth: true
                        }
                    }
                    JooyaButton{
                        id:btnPresent
                        Layout.topMargin: 9
                        enabled: !user.isProcessing
                        text:linkIsReady?"اشتراک با دوستان":"دریافت لینک زیر مجموعه گیری"
                        onClicked: {
                            if(linkIsReady)
                            {
                                if(Qt.platform.os=="windows"||Qt.platform.os=="linux"){
                                    rectCopyClipboard.isVisible=true;
                                }
                                else{
                                    shareManager.share("سلام با اپلیکیشن رخشید میتونی چروک های صورتت رو به صورت طبیعی از بین ببری.لینک دانلود"+" "+currentUserReferralLink);
                                }

                            }
                            else{
                                user.getReferralCode();
                            }
                        }
                    }
                    Item {
                        Layout.fillHeight: true
                    }

                }
            }
            Item {
                Layout.fillHeight: true
            }
        }
    }
    Pane{
        id:rectCopyClipboard
        width: parent.width
        height: isVisible? parent.height/2 : 0
        Material.elevation: 3
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        property bool isVisible: false
        RoundButton{
            id:btnClosePaneCC
            Material.elevation: 1
            width: 45
            height: 45
            contentItem: Image {
                fillMode: Image.Pad
                Layout.preferredHeight: 16
                Layout.preferredWidth: 16
                source: "../../images/common/window-close.png"
            }
            onClicked: {
                rectCopyClipboard.isVisible=false;
            }
        }
        ColumnLayout{
            anchors.fill: parent
            anchors.topMargin: btnClosePaneCC.height
            spacing: 9
            Text {
                id: txtShareTextMessage
                Layout.fillWidth: true
                Layout.rightMargin: 18
                Layout.leftMargin: 18
                Layout.topMargin: 18
                wrapMode: Text.WordWrap
                text: "دوست رخشیدی گرامی می توانید با اشتراک لینک خود با دوستانتان از رخشید تخفیف بگیرید"
                color: MaterialStyle.primaryTextColor
                font{
                    family: flYekan.name
                    pixelSize: 15
                }
            }
            Rectangle{
                color: Material.color(Material.Green)
                Layout.alignment: Qt.AlignHCenter
                Layout.rightMargin: 18
                Layout.leftMargin: 18
                Layout.topMargin: 18
                Layout.preferredHeight: txtLink2.implicitHeight+9
                Layout.preferredWidth: txtLink2.implicitWidth+9
                radius: 3

                Text {
                    id:txtLink2
                    anchors.fill: parent
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: currentUserReferralLink
                    color: "white"
                    font{
                        pixelSize: 12
                    }
                }
            }
            JooyaButton{
                id:btnCopyShareLink
                Layout.topMargin: 18
                Layout.rightMargin: 36
                Layout.leftMargin: 36
                text:"کپی کردن لینک اشتراک"
                onClicked: {
                    shareManager.share("سلام با اپلیکیشن رخشید میتونی چروک های صورتت رو به صورت طبیعی از بین ببری.لینک دانلود"+" "+currentUserReferralLink);
                    rectCopyClipboard.isVisible=false;
                    MessageBoard.content="لینک کپی شد"
                }
            }
            Item {
                Layout.fillHeight: true
            }
        }
        Behavior on height{
            PropertyAnimation{
                target: rectCopyClipboard
                property: "height"
                duration: 180
            }
        }
    }
}

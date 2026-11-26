import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import QtQuick.Layouts
import "../../jooyaQuickControls"
import Jooya

Page {
    objectName: "AboutUsPage"
    ApplicationVersionInfo{
        id:versionInfo
    }
    JooyaFlickable{
        anchors.fill: parent
        contentHeight: clm.implicitHeight
        ColumnLayout{
            id:clm
            anchors.fill: parent
            spacing: 9
            Pane{
                Material.elevation: 1
                Material.background: MaterialStyle.primary100
                Layout.fillWidth: true
                Layout.margins: 9
                Layout.preferredHeight: clmContent.implicitHeight
                ColumnLayout{
                    id:clmContent
                    anchors.fill: parent
                    spacing: 9
                    Image{
                        id: imgIcon
                        source: "../../images/icon.png"
                        Layout.preferredHeight: 171
                        Layout.preferredWidth: 171
                        Layout.alignment: Qt.AlignHCenter
                        fillMode: Image.PreserveAspectFit
                    }
                    Text {
                        text: qsTr("رخشید نسخه "+versionInfo.versionName)
                        Layout.fillWidth: true
                        wrapMode: Text.Wrap
                        font.family: flIranSanse.name
                        Layout.alignment: Qt.AlignHCenter
                        font.pixelSize: 18
                        color: MaterialStyle.primaryTextColor
                        horizontalAlignment: Text.AlignHCenter

                    }
                    Text {
                        id:txtLink
                        text: qsTr("اپلیکیشن رخشید دارای تمرینات کاربردی و اثبات شده برای از بین بردن چین و چروک صورت و گردن می باشد.کارکرد این تمرینات از طریق قوی تری کردن ماهیچه های صورت و از بین بردن چربی های زیر پوست مانند چربی های غبغب است.با انجام این تمرینات تمامی چروک پیشانی و بین ابروها؛چروک دور چشم و دور لب ها؛گودی وسط چانه ها؛لیفت گونه ها و ابروها و پیشانی و زاویه دار کردن صورت و گونه انجام می شود.اثرات این تمرینات بر روی صورت بر خلاف روش هایی مانند بوتاکس به مدت طولانی باقی خواهد ماند.")
                        Layout.fillWidth: true
                        wrapMode: Text.Wrap
                        font.family: flYekan.name
                        Layout.alignment: Qt.AlignHCenter
                        font.pixelSize: 18
                        color: MaterialStyle.primaryTextColor
                    }
                    Row{
                        spacing: 1
                        Layout.alignment: Qt.AlignHCenter|Qt.AlignTop
                        Layout.preferredWidth: 207
                        Item {
                            Layout.fillWidth: true
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
                Layout.preferredHeight: 90
                ColumnLayout{
                    anchors.fill: parent
                    spacing: 1
                    Text {
                        text: qsTr("طراحی و تولید در  شرکت جویا افزار")
                        Layout.fillWidth: true
                        wrapMode: Text.Wrap
                        font.family: flYekan.name
                        Layout.alignment: Qt.AlignHCenter
                        font.pixelSize: 18
                        color: MaterialStyle.primaryTextColor
                        horizontalAlignment: Text.AlignHCenter

                    }
                    Text {
                        text: qsTr("شماره ثبت 2745")
                        Layout.fillWidth: true
                        wrapMode: Text.Wrap
                        font.family: flYekan.name
                        Layout.alignment: Qt.AlignHCenter
                        font.pixelSize: 18
                        color: MaterialStyle.primaryTextColor
                        horizontalAlignment: Text.AlignHCenter

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


}

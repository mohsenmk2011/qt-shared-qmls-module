import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import "../../jsf/Bootstrap.js" as Bs
import Jooya
import "../../jooyaQuickControls"

Rectangle{
    id: root

    property Transaction transaction;
    IranSanseFontLoader{
        id: fl
    }
    Pane{
        id: cl
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width-30
        height: parent.height-15
        Material.elevation: 3
        anchors.top: parent.top
        anchors.topMargin: 5

        ColumnLayout{
            anchors.fill: parent
            anchors.topMargin: 5
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.bottomMargin: 5

            spacing: 5

            PropertyItemRow{
                key: "شناسه تراکنش"
                value: transaction.id
            }
            PropertyItemRow{
                key: "تاریخ"
                value: transaction.date
                valueFontName: flIranSanse.name

            }
            PropertyItemRow{
                key: "شناسه ارجاع"
                value: transaction.shenasehErja
            }
            PropertyItemRow{
                key: "درگاه"
                value: transaction.dargah
            }
            PropertyItemRow{
                key: "شماره کارت"
                value: transaction.creditCardNumber
            }
            PropertyItemRow{
                key: "نتیجه پرداخت"
                value: transaction.resultMessage

                keyTextColor: transaction.shenasehErja=="0"?"#b71c1c": "#1b5e20"
                valueTextColor: transaction.shenasehErja=="0"?"#b71c1c": "#1b5e20"
                valueFontSize: 10
            }
        }
    }
}

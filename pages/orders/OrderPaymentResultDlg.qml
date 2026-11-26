import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import Jooya
import "../../jooyaQuickControls"

Dialog{
    id: root    
    parent: ApplicationWindow.overlay
    closePolicy: Dialog.NoAutoClose
    modal: true
    width: 300
    height: 130
    x:(parent.width-width)/2
    y:(parent.height-height)/2
    property PaymentResult paymentResult: null
    font{
        family: flYekan.name
        pixelSize: 18
        bold: true
    }
    header: ToolBar{
        id: tbheader
        height: 40
        anchors.margins: 0
        padding: 0
        Material.elevation:1
        Row{
            anchors.fill: parent
            ToolButton{
                contentItem: Image {
                    source:"../../images/common/window-close.png"
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                }
                onClicked: {
                        close();
                }
            }
        }
    }
    ColumnLayout{
        id:clm
        spacing: 4
        anchors.fill: parent
        anchors.margins: 0
        PropertyItemRow{
            key: "شناسه ارجاع"
            value: paymentResult.trackingCode
        }
        PropertyItemRow{
            key: "نتیجه پرداخت"
            value: paymentResult.message
            keyTextColor: "#1b5e20"
            valueTextColor: "#1b5e20"
        }
        Item{
            Layout.fillHeight: true
        }
    }
}


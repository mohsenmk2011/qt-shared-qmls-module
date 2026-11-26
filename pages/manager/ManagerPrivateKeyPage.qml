import QtQuick
import QtQuick.Controls
import Jooya
import QtQuick.Layouts
import "../../jooyaQuickControls"

JooyaPage {
    PrivateKeyTool{
        id:managerTool
        onIsProcessingChanged: {
            progressIndicatorVisible=isProcessing;
        }
    }

    Component.onCompleted: {
        managerTool.isPirvateKeyExists();
    }
    ColumnLayout{
        anchors.fill: parent
        spacing: 5
        TextArea{
            id:taPrivateKey
            Layout.fillWidth: true
            Layout.maximumHeight: 250
            placeholderText: "کلید خصوصی"
            height: 200
        }
        TextArea{
            id:taPublicKey
            Layout.fillWidth: true
            Layout.maximumHeight: 250
            placeholderText: "کلید عمومی"
            height: 200
        }
        JooyaButton{
            text: "حذف کردن کلید"
            onClicked: {
                managerTool.deletePrivateKey();
            }
        }
        JooyaButton{
            text: "ساخت و ذخیره کردن کلید"
            onClicked: {
                managerTool.createPrivateKey();
            }
        }
        JooyaButton{
            text: "آیا کلید وجود دارد"
            onClicked: {
                managerTool.isPirvateKeyExists();
            }
        }
        Item {
            Layout.fillHeight: true
        }
    }    
}

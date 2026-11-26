import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import Jooya
import "../../jooyaQuickControls"

Page{
    id: root
    property Role role: null

    contentHeight:200
    font{
        family: flYekan.name
        pixelSize: 18
        bold: true
    }
    Connections{
        target: role
        function onIsProcessingChanged(isProcessing) {
            btnSave.enabled=!isProcessing;
        }
        function onCreationStateChanged(succeed) {
            if(succeed){
                root.close();
            }
        }
        function onEditStateChanged(succeed) {
            if(succeed){
                root.close();
            }
        }
    }

    Flickable{
        id: flickable
        contentHeight: mainClm.implicitHeight
        flickableDirection: Flickable.AutoFlickIfNeeded
        clip: true
        anchors.fill: parent
        ColumnLayout{
            id: mainClm
            anchors.fill: parent
            anchors.bottomMargin: 60
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            JooyaTextField{
                id: tfName
                placeholderText: "نام نقش"
                Layout.fillWidth: true
                text: role.name
                onTextChanged: {
                    role.name=tfName.text;
                }
            }
            JooyaButton{
                id: btnSave
                highlighted: true
                text:role.id ==""? "ذخیره":"ویرایش"
                Layout.fillWidth: true
                onClicked: {
                        role.save();
                }
            }
        }
        ScrollBar.vertical: ScrollBar{
            width: 5
        }
    }
}

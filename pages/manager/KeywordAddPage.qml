import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import Jooya
import "../../jooyaQuickControls"

JooyaFlickable {
    id: root
    contentHeight: mainClm.implicitHeight
    flickableDirection: Flickable.AutoFlickIfNeeded

    property Keyword keyword: null

    Component.onCompleted: {
    }
    Connections{
        target:keyword
        function onIsProcessingChanged(isProcessing) {
            btnSave.enabled=!isProcessing;
        }
        function onSaveSucceed() {
            console.log("keyword saved")
        }
    }
    ColumnLayout{
        id: mainClm
        anchors.fill: parent
        JooyaTextField{
            id: tfKeywordValue
            placeholderText: "نام کلمه کلیدی"

            Layout.fillWidth: true
            text: keyword.value
            onTextChanged: {
                keyword.value=tfKeywordValue.text;
            }
        }
        JooyaButton{
            id: btnSave
            highlighted: true
            enabled: !keyword.isProcessing
            text:keyword.keywordId === 0? "ذخیره":"ویرایش"
            Layout.fillWidth: true
            onClicked: {
                keyword.save();
            }
        }
        Item {
            Layout.fillHeight: true
        }
    }
}

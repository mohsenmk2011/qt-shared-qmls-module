import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Controls
import "../../jooyaQuickControls"

JooyaPage {
    id:root

        Column {
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter

            RadioButton {
                text: "سرور"
            }
            RadioButton {
                text: "وای فای"
            }
            RadioButton {
                text: "لوکال هاست"
            }
        }



}

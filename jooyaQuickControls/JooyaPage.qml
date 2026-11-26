import QtQuick
import QtQuick.Controls
import Jooya

Page {

    property alias progressIndicatorVisible: progressIndicator.visible

    ProgressIndicator{
        id:progressIndicator
        anchors.centerIn: parent
    }
}

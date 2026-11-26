import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import QtQuick.Layouts
import "../../jooyaQuickControls"
import "../../items/common"
import Jooya

Flickable {
    id:settingsPage
    LayoutMirroring.enabled: true
    LayoutMirroring.childrenInherit: true
    contentHeight: clm.implicitHeight
    function formatText(count, modelData) {
        return modelData.toString().length < 2 ? "0" + modelData : modelData;
    }
    CurrentApplicationSettings{
        id:settings
    }
    AndroidPermissionManager{
        id:androidPermissionManager
    }

    AlarmManager{
        id:alarmManager
    }
    Component.onCompleted: {
        if(!ApplicationAlarmSettings.hasAlarm)
        {
            return;
        }
        if(ApplicationAlarmSettings.alarmClass === AlarmClasses.AlarmManager)
        {
            alarmManager.isUpAndRunning = alarmManager.isAlarmUp();
            console.log("alarmManager.isAlarmUp()=> "+alarmManager.isUpAndRunning);
        }
        else
        {
            alarmManager.isUpAndRunning = alarmManager.isAlarmWorkUp();
            console.log("alarmManager.isAlarmWorkUp()=> "+alarmManager.isUpAndRunning);
        }
        console.log("settings.alarmInfo"+settings.alarmInfo);
        alarmManager.alarmInfo.fromString(settings.alarmInfo)
        console.log("alarmManager.alarmInfo.alarmHour"+alarmManager.alarmInfo.alarmHour);
        console.log("alarmManager.alarmInfo.alarmMinute"+alarmManager.alarmInfo.alarmMinutes);
        hoursTumbler.currentIndex=alarmManager.alarmInfo.alarmHour;
        minutesTumbler.currentIndex=alarmManager.alarmInfo.alarmMinutes;
        combxAlarmType.currentIndex=alarmManager.alarmInfo.alarmType===AlarmTypes.DisplayPage?0:1
        if(ApplicationAlarmSettings.hasRepeat)
        {
            intervalUnitTumbler.currentIndex = alarmManager.alarmInfo.intervalUnit-1;
            intervalTumbler.currentIndex = alarmManager.alarmInfo.alarmInterval;
        }
        else{
            alarmManager.alarmInfo.hasRepeat = false;
        }
    }
    ColumnLayout{
        id:clm
        anchors.fill: parent
        //===========================< current application settings >====================================
        Loader{
            source: "../../app/CurrentAppSettingsPane.qml"
            Layout.fillWidth: true
            Layout.margins: 9
            Layout.leftMargin: 0
            Layout.rightMargin: 0
            height: 405
            visible: false
        }
        //===========================< END OF current application settings >====================================
        Pane{
            id:paneAlarm
            visible: ApplicationAlarmSettings.hasAlarm
            Material.elevation: 1
            Material.background: MaterialStyle.primary100
            Layout.fillWidth: true
            Layout.margins: 9
            Layout.leftMargin: 0
            Layout.rightMargin: 0
            height: 407
            ColumnLayout{
                id:clmAlarm
                anchors.fill: parent
                spacing: 9
                Text {
                    text: qsTr("هشدار")
                    color: MaterialStyle.primaryTextColor
                    font{
                        family:flYekan.name
                        pixelSize: 27
                    }
                }
                Component {
                    id: delegateComponent
                    Label {
                        text: formatText(Tumbler.tumbler.count, modelData)
                        opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: MaterialStyle.primaryTextColor
                    }
                }
                RowLayout{
                    Layout.fillWidth: true
                    Layout.rightMargin: 18
                    Layout.leftMargin: 18
                    spacing: 9
                    IconImage {
                        width: 27
                        height: 27
                        Layout.alignment: Qt.AlignVCenter
                        source: "../../images/common/bell.png"
                        color: MaterialStyle.iconColor
                    }
                    Text {
                        text: qsTr("نوع هشدار")
                        color: MaterialStyle.primaryTextColor
                        font{
                            family:flYekan.name
                        }
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                    ComboBox {
                        id:combxAlarmType
                        model: ["در صفحه","در نوار اعلان"]
                        font{
                            family: flYekan.name
                        }
                        delegate: ItemDelegate {
                            width: combxAlarmType.width
                            contentItem: Text {
                                text: modelData
                                color: MaterialStyle.primaryTextColor
                                font: combxAlarmType.font
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }
                            highlighted: combxAlarmType.highlightedIndex === index
                        }
                        contentItem: Text {
                            leftPadding: 0
                            rightPadding: combxAlarmType.indicator.width + combxAlarmType.spacing

                            text: combxAlarmType.displayText
                            font: combxAlarmType.font
                            color: MaterialStyle.primaryTextColor
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                        }

                        background: Rectangle {
                            implicitWidth: 120
                            implicitHeight: 40
                            color: MaterialStyle.primary200
                            border.color: combxAlarmType.pressed ? MaterialStyle.primary300 : MaterialStyle.primary200
                            border.width: combxAlarmType.visualFocus ? 2 : 1
                            radius: 3
                        }

                        popup: Popup {
                            y: combxAlarmType.height - 1
                            width: combxAlarmType.width
                            implicitHeight: contentItem.implicitHeight
                            padding: 1

                            contentItem: ListView {
                                clip: true
                                implicitHeight: contentHeight
                                model: combxAlarmType.popup.visible ? combxAlarmType.delegateModel : null
                                currentIndex: combxAlarmType.highlightedIndex

                                ScrollIndicator.vertical: ScrollIndicator { }
                            }

                            background: Rectangle {
                                color: MaterialStyle.primary200
                                border.color: MaterialStyle.primary300
                                radius: 2
                            }
                        }
                        onActivated: {
                            if(index==0){
                                alarmManager.alarmInfo.alarmType=AlarmTypes.DisplayPage;
                            }
                            else{
                                alarmManager.alarmInfo.alarmType=AlarmTypes.SimpleNotification;
                            }
                            settings.alarmInfo=alarmManager.alarmInfo.convertToString();
                        }
                    }
                }
                Separator {
                    Layout.fillWidth: true
                    Layout.rightMargin: 4.5
                    Layout.leftMargin: 4.5
                    color: MaterialStyle.secondary200
                }
                RowLayout{
                    Layout.fillWidth: true
                    Layout.rightMargin: 18
                    Layout.leftMargin: 18
                    IconImage {
                        width: 27
                        height: 27
                        Layout.alignment: Qt.AlignVCenter
                        source: "../../images/common/clock-time-nine.png"
                        color: MaterialStyle.iconColor
                    }
                    Text {
                        text: qsTr("زمان هشدار")
                        color: MaterialStyle.primaryTextColor
                        font{
                            family:flYekan.name
                        }
                    }
                    Rectangle{
                        color: MaterialStyle.primary300
                        Layout.preferredHeight: 6
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignVCenter
                        radius: 3
                    }
                    Rectangle {
                        id: frame
                        clip: true
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredHeight: 170
                        Layout.preferredWidth: 117
                        color: MaterialStyle.primary200
                        radius: 9
                        Row {
                            anchors.fill: parent
                            LayoutMirroring.enabled: false
                            id:rowTumbler
                            Tumbler {
                                id: hoursTumbler
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                model: 24
                                delegate: delegateComponent
                                visibleItemCount: 3
                                font{
                                    family: flYekan.name
                                    pixelSize: 36
                                }
                                onMovingChanged: {
                                    if(!moving)
                                    {
                                        alarmManager.alarmInfo.alarmHour=hoursTumbler.currentIndex;
                                    }
                                }
                            }
                            Tumbler {
                                id: minutesTumbler
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                model: 60
                                delegate: delegateComponent
                                visibleItemCount: 3
                                font{
                                    family: flYekan.name
                                    pixelSize: 36
                                }
                                onMovingChanged: {
                                    if(!moving)
                                    {
                                        alarmManager.alarmInfo.alarmMinutes=minutesTumbler.currentIndex;
                                    }
                                }
                            }
                        }
                    }
                    Rectangle{
                        color: MaterialStyle.primary300
                        Layout.preferredHeight: 6
                        Layout.preferredWidth: 72
                        Layout.alignment: Qt.AlignVCenter
                        radius: 3
                    }
                }
                Separator {
                    Layout.fillWidth: true
                    Layout.rightMargin: 4.5
                    Layout.leftMargin: 4.5
                    color: MaterialStyle.secondary200
                }
                //==========================[ interval section ]========================================
                RowLayout{
                    visible: ApplicationAlarmSettings.hasRepeat
                    Layout.fillWidth: true
                    Layout.rightMargin: 18
                    Layout.leftMargin: 18
                    spacing: 9
                    IconImage {
                        width: 27
                        height: 27
                        Layout.alignment: Qt.AlignVCenter
                        source: "../../images/common/repeat.png"
                        color: MaterialStyle.iconColor
                    }
                    Text {
                        text: qsTr("تکرار هشدار")
                        color: MaterialStyle.primaryTextColor
                        font{
                            family:flYekan.name
                        }
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                    Text {
                        text: qsTr("خاموش")
                        color: MaterialStyle.primaryTextColor
                        font{
                            family:flYekan.name
                        }
                    }
                    Switch{
                        id:swAlarmRepeat
                        checked: alarmManager.alarmInfo.hasRepeat
                        onToggled: {
                            console.log("onToggle swAlarmRepeat.checked => " + swAlarmRepeat.checked)
                            alarmManager.alarmInfo.hasRepeat = checked;
                        }
                    }
                    Text {
                        text: qsTr("روشن")
                        color: MaterialStyle.primaryTextColor
                        font{
                            family:flYekan.name
                        }
                    }
                }
                RowLayout{
                    visible: ApplicationAlarmSettings.hasRepeat && swAlarmRepeat.checked
                    Layout.fillWidth: true
                    Layout.rightMargin: 18
                    Layout.leftMargin: 18
                    Rectangle{
                        color: MaterialStyle.primary300
                        Layout.preferredHeight: 6
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignVCenter
                        radius: 3
                    }
                    Rectangle {
                        clip: true
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredHeight: 170
                        Layout.preferredWidth: 154
                        color: MaterialStyle.primary200
                        radius: 9
                        RowLayout {
                            anchors.fill: parent
                            LayoutMirroring.enabled: true

                            Tumbler {
                                id: intervalTumbler
                                Layout.fillHeight: true
                                model: 61
                                delegate: Label {
                                    text: modelData
                                    opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    color: MaterialStyle.primaryTextColor
                                }
                                visibleItemCount: 3
                                font{
                                    family: flYekan.name
                                    pixelSize: 36
                                }
                                onMovingChanged: {
                                    if(!moving)
                                    {
                                        alarmManager.alarmInfo.alarmInterval = intervalTumbler.currentIndex;
                                    }
                                }
                            }
                            Tumbler {
                                id: intervalUnitTumbler
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                model: ListModel {
                                    ListElement { index: 1; title: "دقیقه"; }
                                    ListElement { index: 2; title: "ساعت"; }
                                    ListElement { index: 3; title: "روز"; }
                                }
                                delegate: Label {
                                    text: model.title
                                    opacity: model.index - 1 == intervalUnitTumbler.currentIndex ? 1.0 : 0.36
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    color: MaterialStyle.primaryTextColor
                                    height: parent.height/6
                                }
                                visibleItemCount: 3
                                font{
                                    family: flYekan.name
                                    pixelSize: 33
                                }
                                onMovingChanged: {
                                    if(!moving)
                                    {
                                        var currentItem = intervalUnitTumbler.model.get(currentIndex);
                                        alarmManager.alarmInfo.intervalUnit = currentItem.index;
                                        console.log("interval unit => "+currentItem.index)
                                        console.log("alarmManager.alarmInfo.intervalUnit => "+alarmManager.alarmInfo.intervalUnit)
                                    }
                                }
                            }
                        }
                    }
                    Rectangle{
                        color: MaterialStyle.primary300
                        Layout.preferredHeight: 6
                        Layout.preferredWidth: 99
                        Layout.alignment: Qt.AlignVCenter
                        radius: 3
                    }
                }
                //==========================[ end of interval section ]========================================
                RowLayout{
                    Layout.fillWidth: true
                    Layout.rightMargin: 0
                    Layout.leftMargin: 0
                    spacing: 0
                    JooyaButton{
                        text: alarmManager.isUpAndRunning?"پایان دادن به هشدار": "یاد آوری"
                        Layout.preferredWidth: paneAlarm.width/2
                        Layout.leftMargin: 3
                        Layout.rightMargin: 3
                        onClicked: {
                            enabled = false;
                            if(ApplicationAlarmSettings.alarmClass === AlarmClasses.WorkoutManager)
                            {
                                if(alarmManager.isAlarmWorkUp())
                                {
                                    alarmManager.cancelAlarmWork();
                                    enabled = true;
                                    return;
                                }
                            }
                            if(alarmManager.isAlarmUp())
                            {
                                alarmManager.cancelAlarm();
                                enabled = true;
                                return;
                            }
                            settings.alarmInfo = alarmManager.alarmInfo.convertToString();
                            if(ApplicationAlarmSettings.alarmClass === AlarmClasses.WorkoutManager)
                            {
                                if(combxAlarmType.currentIndex==0)
                                {
                                    alarmManager.startAlarmWithWorkManager("Page",ApplicationAlarmSettings.notificationContent);
                                }
                                else
                                {
                                    alarmManager.startAlarmWithWorkManager("Notification",ApplicationAlarmSettings.notificationContent);
                                }
                                enabled = true;
                                return;
                            }
                            if(combxAlarmType.currentIndex==0)
                            {
                                alarmManager.startAlarmWithAlamManager("Page",ApplicationAlarmSettings.notificationContent);
                            }
                            else
                            {
                                alarmManager.startAlarmWithAlamManager("Notification",ApplicationAlarmSettings.notificationContent);
                            }
                            enabled = true;
                        }
                    }
                    JooyaButton{
                        text: "پیش نمایش هشدار"
                        Layout.preferredWidth: paneAlarm.width/2
                        Layout.leftMargin: 3
                        Layout.rightMargin: 3
                        onClicked: {
                            if(combxAlarmType.currentIndex==0)
                            {
                                alarmManager.displayAlarmPage("Page",ApplicationAlarmSettings.notificationContent);
                            }
                            else
                            {
                                alarmManager.displayAlarmPage("Notification",ApplicationAlarmSettings.notificationContent);
                            }
                        }
                    }
                }
                Item {
                    Layout.fillHeight: true
                }
            }
        }
        //===================================< End of Alarm >==========================================
        Pane{
            Material.elevation: 1
            Material.background: MaterialStyle.primary100
            Layout.fillWidth: true
            Layout.margins: 9
            Layout.leftMargin: 0
            Layout.rightMargin: 0
            height: 407
            ColumnLayout{
                id:clmTheme
                anchors.fill: parent
                spacing: 9
                Text {
                    text: qsTr("ظاهر برنامه")
                    color: MaterialStyle.primaryTextColor
                    font{
                        family:flYekan.name
                        pixelSize: 27
                    }
                }
                RowLayout{
                    Layout.fillWidth: true
                    Layout.rightMargin: 18
                    Layout.leftMargin: 18
                    spacing: 9
                    IconImage {
                        width: 27
                        height: 27
                        Layout.alignment: Qt.AlignVCenter
                        source: "../../images/common/brightness-6.png"
                        color: MaterialStyle.iconColor
                    }
                    Text {
                        text: qsTr("تم")
                        color: MaterialStyle.primaryTextColor
                        font{
                            family:flYekan.name
                        }
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                    Text {
                        id:txtLight
                        text: qsTr("روشن")
                        color: MaterialStyle.primaryTextColor
                        font{
                            family:flYekan.name
                        }
                    }
                    Switch{
                        id:swTheme
                        checked: MaterialStyle.isDark
                        onCheckedChanged: {
                            console.log("swTheme.checked => "+swTheme.checked)
                        }
                        onToggled: {
                            console.log("onToggled swTheme.checked => "+swTheme.checked)
                            if(checked){
                                MaterialStyle.theme=Material.Dark;
                            }
                            else{
                                MaterialStyle.theme=Material.Light;
                            }
                        }
                    }
                    Text {
                        id:txtDark
                        text: qsTr("تاریک")
                        color: MaterialStyle.primaryTextColor
                        font{
                            family:flYekan.name
                        }
                    }
                }
                Separator {
                    Layout.fillWidth: true
                    Layout.rightMargin: 4.5
                    Layout.leftMargin: 4.5
                    color: MaterialStyle.secondary200
                }
                RowLayout{
                    Layout.fillWidth: true
                    Layout.rightMargin: 18
                    Layout.leftMargin: 18
                    spacing: 9
                    IconImage {
                        Layout.alignment: Qt.AlignVCenter
                        source: "../../images/common/rectangle.png"
                        color: MaterialStyle.iconColor
                    }
                    Text {
                        text: qsTr("پس زمینه کارت ها")
                        color: MaterialStyle.primaryTextColor
                        font{
                            family:flYekan.name
                        }
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                    Text {
                        text: qsTr("رنگ نخستین")
                        color: MaterialStyle.primaryTextColor
                        font{
                            family:flYekan.name
                        }
                    }
                    Switch{
                        id:swUserWhiteBackColor
                        checked: MaterialStyle.useWhiteBackColor
                        onCheckedChanged: {
                            console.log("swUserWhiteBackColor.checked => " + swTheme.checked)
                        }
                        onToggled: {
                            console.log("onToggled swUserWhiteBackColor.checked => " + swTheme.checked)
                            MaterialStyle.useWhiteBackColor = checked;
                        }
                    }
                    Text {
                        text: qsTr("سفید")
                        color: MaterialStyle.primaryTextColor
                        font{
                            family:flYekan.name
                        }
                    }
                }
                Separator {
                    Layout.fillWidth: true
                    Layout.rightMargin: 4.5
                    Layout.leftMargin: 4.5
                    color: MaterialStyle.secondary200
                }
                RowLayout{
                    Layout.fillWidth: true
                    Layout.rightMargin: 18
                    Layout.leftMargin: 18
                    spacing: 9
                    IconImage {
                        width: 27
                        height: 27
                        Layout.alignment: Qt.AlignVCenter
                        source: "../../images/common/palette.png"
                        color: MaterialStyle.iconColor
                    }
                    Text {
                        text: qsTr("رنگ نخستین")
                        Layout.alignment: Qt.AlignLeft
                        color: MaterialStyle.primaryTextColor
                        font{
                            family:flYekan.name
                        }
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                }
                JooyaGridView{
                    id:gvPrimaryColor
                    Layout.fillWidth: true
                    Layout.rightMargin: 18
                    Layout.leftMargin: 18
                    Layout.preferredHeight: 234
                    cellWidth: 54
                    cellHeight: 54
                    delegate: Item {
                        width: gvPrimaryColor.cellWidth
                        height: gvPrimaryColor.cellHeight
                        Rectangle{
                            width: parent.width-4.5
                            height: parent.width-4.5
                            anchors.centerIn: parent
                            radius: width/2
                            property int colorCode: model.color
                            color: Material.color(model.color)
                            border.width: MaterialStyle.primary === colorCode ? 2:0
                            border.color: MaterialStyle.isDark?"white":"black"
                            visible: model.color!==MaterialColors.White
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    console.log("clicked color=> "+parent.color);
                                    MaterialStyle.primary=model.color
                                }
                            }
                        }
                    }
                    model:MaterialStyle.colors
                }
                Separator {
                    Layout.fillWidth: true
                    Layout.rightMargin: 4.5
                    Layout.leftMargin: 4.5
                    color: MaterialStyle.secondary200
                }
                RowLayout{
                    Layout.fillWidth: true
                    Layout.rightMargin: 18
                    Layout.leftMargin: 18
                    spacing: 9
                    IconImage {
                        width: 27
                        height: 27
                        Layout.alignment: Qt.AlignVCenter
                        source: "../../images/common/palette.png"
                        color: MaterialStyle.iconColor
                    }
                    Text {
                        text: qsTr("رنگ دوم")
                        Layout.alignment: Qt.AlignLeft
                        color: MaterialStyle.primaryTextColor
                        font{
                            family:flYekan.name
                        }
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                }

                JooyaGridView{
                    id:gvSecondaryColor
                    Layout.fillWidth: true
                    Layout.rightMargin: 18
                    Layout.leftMargin: 18
                    Layout.preferredHeight: 234
                    cellWidth: 54
                    cellHeight: 54
                    delegate:
                        Item {
                        width: gvPrimaryColor.cellWidth
                        height: gvPrimaryColor.cellHeight
                        Rectangle{
                            width: parent.width-4.5
                            height: parent.width-4.5
                            anchors.centerIn: parent
                            radius: width/2
                            property int colorCode: model.color
                            color: model.colorName
                            border.width: MaterialStyle.secondary === colorCode ? 2:0
                            border.color: MaterialStyle.isDark?"white":"black"
                            visible: model.color!==MaterialColors.White
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    console.log("clicked color=> "+parent.color);
                                    MaterialStyle.secondary=model.color
                                }
                            }
                        }
                    }
                    model:MaterialStyle.colors
                }
                Separator {
                    Layout.fillWidth: true
                    Layout.rightMargin: 4.5
                    Layout.leftMargin: 4.5
                    color: MaterialStyle.secondary200
                }
                RowLayout{
                    Layout.fillWidth: true
                    Layout.rightMargin: 18
                    Layout.leftMargin: 18
                    spacing: 9
                    IconImage {
                        width: 27
                        height: 27
                        Layout.alignment: Qt.AlignVCenter
                        source: "../../images/common/palette.png"
                        color: MaterialStyle.iconColor
                    }
                    Text {
                        text: qsTr("رنگ سوم")
                        color: MaterialStyle.primaryTextColor
                        font{
                            family:flYekan.name
                        }
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                }
                JooyaGridView{
                    id:gvTertiaryColor
                    Layout.fillWidth: true
                    Layout.rightMargin: 18
                    Layout.leftMargin: 18
                    Layout.preferredHeight: 234
                    cellWidth: 54
                    cellHeight: 54
                    delegate: Item {
                        width: gvTertiaryColor.cellWidth
                        height: gvTertiaryColor.cellHeight
                        Rectangle{
                            width: parent.width-4.5
                            height: parent.width-4.5
                            anchors.centerIn: parent
                            radius: width/2
                            property int colorCode: model.color
                            color: model.colorName
                            border.width: MaterialStyle.tertiary === colorCode ? 2:0
                            border.color: MaterialStyle.isDark ? "red" : "blue"
                            visible: model.color!==MaterialColors.White
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    console.log("clicked color=> " + parent.color);
                                    MaterialStyle.tertiary = model.color
                                }
                            }
                        }
                    }
                    model:MaterialStyle.colors
                }
                Separator {
                    visible: !MaterialStyle.isDark
                    Layout.fillWidth: true
                    Layout.rightMargin: 4.5
                    Layout.leftMargin: 4.5
                    color: MaterialStyle.secondary200
                }
                RowLayout{
                    Layout.fillWidth: true
                    Layout.rightMargin: 18
                    Layout.leftMargin: 18
                    spacing: 9
                    IconImage {
                        width: 27
                        height: 27
                        Layout.alignment: Qt.AlignVCenter
                        source: "../../images/common/refresh.png"
                        color: MaterialStyle.iconColor
                    }
                    TabButton {
                        text: qsTr("بازگردانی به حالت پیش فرض")
                        //                        color: MaterialStyle.primaryTextColor
                        font{
                            family:flYekan.name
                        }
                        Layout.fillWidth: true
                        onClicked: {
                            MaterialStyle.resetToDefault();
                        }
                    }
                }

                Item {
                    Layout.fillHeight: true
                }
            }
        }

        //=============================================================================

        Item {
            Layout.fillHeight: true
        }
    }

}

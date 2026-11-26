import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Dialogs
import QtQuick.Layouts
import "../../jsf/Bootstrap.js" as Bs
import "../../jooyaQuickControls"
import "../common"
import Jooya
import QtQuick
import QtQml.Models
import QtCore

JooyaDialog {
    id: root
    leftPadding: 0
    rightPadding: 0
    topPadding: 0
    isBig: true
    Material.elevation:4
    property bool isSettingStartDate: true
    font {
        family: flYekan.name
        pixelSize: 18
        bold: true
    }

    Component.onCompleted: {
        progressIndicatorVisible=notify.isProcessing;
    }
    DateTimeUtility{
        id:dtu
    }
    header: RowLayout{
        height: 48
        Layout.fillWidth: true
        ToolButton{
            contentItem: Image {
                source: "/images/app/window-close.png"
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
            }
            onClicked: {
                close();
            }
        }
    }
    //================================================
    Flickable{
        anchors.fill: parent
        contentHeight: 1100
        flickableDirection: Flickable.AutoFlickIfNeeded
        clip: true

        ColumnLayout{
            id: mainClm
            anchors.fill: parent
            spacing: 25
            Rectangle{
                id:imageRect
                Layout.fillWidth: true
                height: 300
                Layout.alignment: Qt.AlignTop
                clip: true
                color: "#FFCCBC"
                Image {
                    id:introImg
                    anchors.centerIn: parent
                    width: notify.path===""?64:450
                    height: notify.path===""?64:300
                    source: notify.path===""?"/images/ImageDefault.png":notify.qtPath
                }

                RoundButton{
                    id: btnUploadImage
                    width: 72
                    height: 72
                    highlighted: true
                    contentItem: Image {
                        fillMode: Image.Pad
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "/images/upload.png"
                    }

                    onClicked: {
                        var cd=fileDialogWin.createObject(mainWindow);
                        cd.open();
                    }
                    Component{
                        id: fileDialogWin
                        FileDialog {
                            id: fileDialog
                            title: "Please choose a file"
                            currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
                            nameFilters: ["Picture Files(*.jpg *.png)"]
                            onAccepted: {
                                notify.loadImageFromFile(selectedFile)
                            }
                            onRejected: {
                                close();
                            }
                            Component.onCompleted: visible = true
                        }
                    }
                }
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.leftMargin: 15
                Layout.rightMargin: 15

                ColumnLayout{
                    anchors.fill: parent
                    spacing: 15

                    TextField {
                        id:tfTitle
                        placeholderText: "عنوان تخفیف"
                        color: "#3D3D3D"
                        Layout.fillWidth: true
                        text: notify.title
                        onTextChanged: {
                            notify.title=text;
                        }
                    }
                    ScrollView{
                        Layout.fillWidth: true
                        Layout.maximumHeight: 120
                        padding: 16
                        topPadding: 0

                        clip: true
                        TextArea {
                            id: taDescription
                            color: "#3D3D3D"
                            placeholderText: "توضیحات تخفیف"
                            wrapMode: TextArea.Wrap
                            clip: true
                            text:notify.description
                            onTextChanged: {
                                notify.description=text;
                            }
                        }
                    }
                    TextField {
                        id:tfImageName
                        placeholderText: "نام تصویر"
                        color: "#3D3D3D"
                        Layout.fillWidth: true
                        text: notify.name
                        onTextChanged: {
                            notify.name=text;
                        }
                    }
                    TextField {
                        id:tfAmount
                        placeholderText: "درصد تخفیف"
                        color: "#3D3D3D"
                        Layout.fillWidth: true
                        text: notify.amount === 0 ?"":notify.amount
                        onTextChanged: {
                            notify.amount=text;
                        }
                    }
                    TextField {
                        id:tfStartDate
                        placeholderText: "تاریخ شروع تخفیف"
                        color: "#3D3D3D"
                        Layout.fillWidth: true
                        text: dtu.fromDateTime(notify.date)
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                isSettingStartDate=true;
                                datePicker.date= dtu.toDateTime(tfStartDate.text);
                                datePicker.startDate= dtu.toDateTime(tfStartDate.text)
                                datePicker.endDate= dtu.toDateTime(tfEndDate.text);
                                datePicker.open();

                            }
                        }
                    }
                    TextField {
                        id:tfEndDate
                        placeholderText: "تاریخ پایان تخفیف"
                        color: "#3D3D3D"
                        Layout.fillWidth: true
                        text: dtu.fromDateTime(notify.endDate)
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                isSettingStartDate=false;
                                datePicker.date= dtu.toDateTime(tfEndDate.text);
                                datePicker.startDate= dtu.toDateTime(tfEndDate.text);
                                datePicker.endDate=dtu.toDateTime(tfEndDate.text);
                                datePicker.open();
                            }
                        }
                    }
                    // DatePickerDialog{
                    //     id:datePicker
                    //     onCurrentDateChanged: {
                    //         if(isSettingStartDate){
                    //             notify.date=currentDate;
                    //         }
                    //         else{
                    //             notify.endDate=currentDate;
                    //         }
                    //     }
                    // }
                    RowLayout{
                        Layout.fillWidth: true
                        Switch{
                            id: swhBeVisibleForUsers
                            checked: notify.visible
                            onCheckedChanged: {
                                notify.visible=checked;
                            }
                        }
                        Label{
                            text: "برای کاربر نمایش داده شود؟"
                            Layout.fillWidth: true
                        }
                    }
                    RowLayout{
                        Layout.alignment: Qt.AlignBottom
                        spacing: 25
                        Layout.bottomMargin: 10
                        Button{
                            id: btnType
                            text: "انتخاب ویژگی هشدر"
                            Layout.fillWidth: true
                            onClicked: {
                                typeDialog.open();
                            }
                        }
                        Button{
                            id: btnSave
                            text: "ذخیره"
                            highlighted: true
                            Layout.fillWidth: true
                            onClicked: {
                                notify.save();
                            }
                        }
                    }
                }
            }
        }
        ScrollBar.vertical: ScrollBar{
            width: 8
        }
    }
    NotificationTypeEditDialog{
        id:typeDialog
        isInEditPage: true
    }
}

import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Dialogs
import QtQuick.Layouts
import "../../jsf/Bootstrap.js" as Bs
import "../../jooyaQuickControls"
import "../../items/common"
import "../common"
import Jooya
import QtQuick
import QtQml.Models
import QtCore
import JooyaQuick.Controls.Material

Page {
    id: notifyEditorPage
    property Notify notify: null
    Component.onCompleted: {
    }
    objectName: "NotifyEditor"
    padding: 0
    font {
        family: flYekan.name
    }
    //================================================
    Flickable{
        anchors.fill: parent
        contentHeight: mainClm.implicitHeight
        flickableDirection: Flickable.AutoFlickIfNeeded
        clip: true
        ColumnLayout{
            id: mainClm
            anchors.fill: parent
            spacing: 18
            Layout.margins: 0

            Rectangle{
                id:imgContainer
                Layout.fillWidth: true
                // Layout.preferredWidth: notifyEditorPage.width
                Layout.preferredHeight: notifyEditorPage.height/2
                color: MaterialStyle.primary100
                Layout.alignment: Qt.AlignTop
                ImageItem{
                    id:imgItem
                    imageFile: notify
                    anchors.fill: parent
                    imageFillMode:Image.PreserveAspectCrop
                }
            }
            Pane{
                enabled: !notify.isProcessing
                Layout.fillWidth: true
                Layout.leftMargin: 18
                Layout.rightMargin: 18
                Layout.preferredHeight: 54
                padding: 0
                Material.elevation: 2
                Material.background: MaterialStyle.primary200
                RowLayout{
                    anchors.fill: parent
                    layoutDirection: Qt.RightToLeft
                    ToolButton{
                        Layout.preferredHeight: 54
                        Layout.preferredWidth: 54
                        enabled: !notify.isProcessing
                        contentItem: IconImage {
                            fillMode: Image.Pad
                            source: "../../images/common/folder-open.png"
                            color: MaterialStyle.iconColor
                        }
                        JooyaToolTip {
                            text: notify.isExists ? "گزینش نگاره ای دیگر" : "گزینش نگاره"
                        }
                        onClicked: {
                            //notify.loadImageFromFile(fileUrl);
                            console.log("image not selected yet go select");
                            sv.push("../../pages/common/ImageEditor.qml",{imageFile:notify,clipSize:Qt.size(500,250)});
                        }
                    }
                    ToolButton{
                        Layout.preferredHeight: 54
                        Layout.preferredWidth: 54
                        enabled: !notify.isProcessing
                        visible: notify.isExists && (notify.uploadStatus === FileUploadStatus.NotStarted || notify.uploadStatus === FileUploadStatus.Faild)
                        contentItem: IconImage {
                            fillMode: Image.Pad
                            source: "../../images/common/upload.png"
                            color: MaterialStyle.iconColor
                        }
                        JooyaToolTip {
                            text: "بارگذاری نگاره"
                        }
                        onClicked: {
                            console.log("=> btn upload clicked -> upload notify image");
                            notify.uploadImage();
                        }
                    }
                    ToolButton{
                        Layout.preferredHeight: 54
                        Layout.preferredWidth: 54
                        enabled: !notify.isProcessing
                        visible: notify.isExists
                        contentItem: IconImage {
                            fillMode: Image.Pad
                            source: "../../images/common/delete.png"
                            color: MaterialStyle.iconColor
                        }
                        JooyaToolTip {
                            text: "زدودن نگاره"
                        }
                        onClicked: {
                            console.log("image.url=> "+notify.url);
                            deleteDialog.open();
                        }
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                }
            }
            TextFieldLabeld{
                id:tfTitle
                title: "عنوان هشدار"
                placeholderText2: "عنوان هشدار"
                text: notify.title
                Layout.fillWidth: true
                Layout.preferredHeight: 54
                Layout.leftMargin: 18
                Layout.rightMargin: 18
                Layout.topMargin: 18
                onTextChanged: {
                    notify.title=text;
                }
            }
            RectWithTitle{
                title: "توضیحات هشدار"
                Layout.fillWidth: true
                Layout.preferredHeight: 180
                Layout.leftMargin: 18
                Layout.rightMargin: 18
                Layout.topMargin: 18
                Material.background: MaterialStyle.primary100
                Rectangle{
                    id:rectNotifyDescriptionContainer
                    anchors.fill: parent
                    anchors.margins: 9
                    anchors.topMargin: 18
                    clip: true
                    radius: 1
                    color: MaterialStyle.primary200
                    Flickable {
                        id: flickQuestion
                        anchors.fill: parent
                        flickableDirection: Flickable.VerticalFlick
                        contentHeight: clmTextAreaContainer.implicitHeight
                        ColumnLayout{
                            id:clmTextAreaContainer
                            anchors.fill: parent
                            TextArea {
                                id: taDescription
                                background: Rectangle{
                                    color: MaterialStyle.primary200
                                }
                                color: MaterialStyle.primaryTextColor
                                font.pixelSize: 18
                                Layout.topMargin: 18
                                Layout.bottomMargin: 18
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                Layout.minimumHeight: 90
                                wrapMode: TextArea.Wrap
                                text:notify.description
                                onTextChanged: {
                                    notify.description=text;
                                }
                            }
                        }
                    }
                }
            }
            TextFieldLabeld {
                id:tfImageName
                title: "نام نگاره"
                placeholderText2: "نام نگاره"
                helpTitle: "نام نگاره اجباری نیست"
                text: notify.imageName
                Layout.fillWidth: true
                Layout.preferredHeight: 54
                Layout.leftMargin: 18
                Layout.rightMargin: 18
                onTextChanged: {
                    notify.imageName = text;
                }
            }
            RowLayout{
                Layout.fillWidth: true
                Layout.leftMargin: 18
                Layout.rightMargin: 18
                Switch{
                    id: swhVisible
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
                Layout.leftMargin: 18
                Layout.rightMargin: 18
                JooyaButton{
                    id: btnType
                    font.pixelSize: 12
                    text: "انتخاب ویژگی هشدر"
                    Layout.fillWidth: true
                    onClicked: {
                        typeDialog.open();
                    }
                }
                JooyaButton{
                    id: btnSave
                    text: "ذخیره"
                    font.pixelSize: 12
                    highlighted: true
                    Layout.fillWidth: true
                    onClicked: {
                        notify.save();
                    }
                }
            }
        }
        ScrollBar.vertical: ScrollBar{
            width: 9
        }
        ConfirmationDialog {
            id:deleteDialog
            message: "آیا مایل هستید نگاره را حذف کنید؟"
            onYesClicked: {
                console.log("=> delete notify image");
                notify.deleteImage();
            }
        }
    }
    NotificationTypeEditDialog{
        id:typeDialog
        isInEditPage: true
    }
}

import QtQuick
import QtQuick.Controls
import "../../jsf/Bootstrap.js" as Bs
import Jooya
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import "../../jooyaQuickControls"
import QtQuick.Layouts

Dialog {
    id: root
    padding: 0
    Material.roundedScale: Material.NotRounded
    property bool isRolePageIsVisible: false
    x:root.width===mainWindow.width?0:(mainWindow.width-root.width)/2
    height: mainWindow.height
    width: Bs.bootSize(mainWindow.width,"xs-12 sm-11 md-7 lg-4 xl-4")

    header: ToolBar{
        id: tbheader
        Material.elevation:1
        anchors.margins: 0
        Row{
            anchors.fill: parent
            anchors.margins: 0
            ToolButton{
                contentItem: Image {
                    source:svManaging.depth>1 ? "../../images/common/back.png": "../../images/common/window-close.png"
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                }
                onClicked: {
                    tbheader.height--;
                    console.log("tbheader.height"+tbheader.height);
                    if(svManaging.depth>1)
                    {
                        if(isRolePageIsVisible)
                        {
                            isRolePageIsVisible=false;
                        }
                        svManaging.pop();
                    }
                    else{
                        close();
                    }
                }
            }
            ToolButton{
                contentItem: Image {
                    source:"../../images//manager/account-cog.png"
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                }
                onClicked: {
                    svManaging.push("RolePage.qml");
                    isRolePageIsVisible=true;
                }
                visible: !isRolePageIsVisible
            }
            ToolButton{
                contentItem: Image {
                    source: MaterialStyle.isDark ? "../../images/common/white-balance-sunny.png":"../../images/common/weather-night.png"
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                }
                onClicked: {
                    MaterialStyle.invertTheme();
                }
            }
            ToolButton{
                visible: svManaging.currentItem!=null && svManaging.currentItem.objectName=="UsersPage"
                contentItem: Image {
                    source: "../../images/common/magnify.png"
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                }
                onClicked: {

                }
            }
        }
    }
    //================================================
    contentItem: StackView{
        id: svManaging
        clip: true
        padding: 0
        anchors.fill: parent
        anchors.topMargin: tbheader.implicitHeight
        initialItem:JooyaGridView {
            id: rootgv
            cellWidth:Bs.bootSize(root.width,"xs-6 sm-4 md-4 lg-3 xl-3")
            cellHeight:170
            delegate: ManagingItem {
                width: rootgv.cellWidth
                height: rootgv.cellHeight
                title:model.title
                imgUrl:model.imageUrl
                targetUrl:model.url
                onItemClicked: {
                    svManaging.push(argUrl);
                }
            }
            model:lmManagingItems
        }
        ListModel{
            id:lmManagingItems
            ListElement{
                title: "کاربران"
                imageUrl:"../../images/manager/search-profile.png"
                url:"UsersPage.qml"
            }
            ListElement{
                title: "نقش ها"
                imageUrl:"../../images/manager/role.png"
                url:"RolePage.qml"
            }
            ListElement{
                title: "رمزنگاری"
                imageUrl:"../../images/manager/cryptography.png"
                url:"ManagerPrivateKeyPage.qml"
            }
            ListElement{
                title: "تنظیمات به پرداخت"
                imageUrl:"../../images/manager/behpardakht.png"
                url:"SettingBehpardakhtPage.qml"
            }
            ListElement{
                title: "تنظیمات پیامک"
                imageUrl:"../../images/manager/smartphone.png"
                url:"SettingSmsPage.qml"
            }
            ListElement{
                title: "نوع درخواست"
                imageUrl:"../../images/manager/http.png"
                url:"HttpRequestTypePage.qml"
            }
            ListElement{
                title: "کلمات کلیدی"
                imageUrl:"../../images/manager/keyword.png"
                url:"KeywordPage.qml"
            }
        }
    }
}

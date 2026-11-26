import QtQuick
import QtQuick.Controls
import "../../jsf/Bootstrap.js" as Bs
import "../../jooyaQuickControls"
import "../../items/common"
import QtQuick.Layouts
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import QtQuick.Window
import Jooya
import QtWebView

JooyaFlickable{
    id:root
    objectName: "BaskeBankPage"
    property User user: null
    property string userId: user==null?"":user.userId

    property int randomRotation: 0
    property int randomPosition: 0
    property int randomT:1

    Component.onCompleted: {
        randomPosition=(Math.random()*100)/2;
        randomRotation=(Math.random()*100)/1.8;
        randomT= (randomPosition%2==0)?1:-1;
        //        appT.findChild(root);
        order.load(userId);
        img.download();
    }
    //    AppTutorialManager{
    //        id:appT
    //    }
    ImageFile{
        id:img
        downloadLink:"/Images/RemoveWrinkle.jpg"
    }
    Order {
        id:order
        manualPaymentReceipt: textAreasManualPaymentReceipt.text
        onIsProcessingChanged:(isProcessing)=> {
                                  progressIndicator.visible=isProcessing;
                              }

    }
    PaymentManager {
        id:paymentManager
        order: order
        onPayRequestSucceed: {
            if(succeed){
                Qt.openUrlExternally(argUrl);
            }
        }
        onBankPageLoaded: {
            console.log("PaymentManager.onBankPageLoaded")
            swipView.setCurrentIndex(1);
        }
        onResultPageStartToLoad: {
            swipView.setCurrentIndex(0);
            console.log("PaymentManager.onResultPageStartToLoad")
        }
        onResultPageLoaded: {
            console.log("PaymentManager.onResultPageLoaded =>basket")
            paymentManager.getResult();
        }
        onPaymentFinished: {
            console.log("PaymentManager.onPaymentFinished | argSucceed=>"+argSucceed);
            order.paid=argSucceed;
            // route the result dialog back to the bank (Mellat) payment result
            dlgPaymentResult.paymentResult = paymentManager.paymentResult;
            if(argSucceed){
                dlgPaymentResult.open();
            }
            else{
                btnPay.enabled=true;
            }
        }
        onIsProcessingChanged:(isProcessing)=> {
                                  progressIndicator.visible=isProcessing;
                              }
    }
    CafebazaarPaymentManager {
        id: cafebazaarManager
        orderId: order.id
        onSkuReceived: (sku)=>{
            // backend responded with the product SKU -> open Bazaar purchase UI

            console.log("99999999999999999999[ pay with cafebazzar step 04 ]99999999999999999999");
            cafebazaarManager.startPurchase(sku);
        }
        onPurchaseSucceeded: (purchaseToken, sku)=>{
            // purchase token received from Bazaar; server verification is
            // triggered automatically by the manager (verifyPurchase)
            console.log("99999999999999999999[ payment succeed in cafebazzar step 16 ]99999999999999999999");
            console.log("purchase token received from Bazaar; server verification is triggered automatically by the manager (verifyPurchase)"+purchaseToken);
            console.log("CafebazaarPaymentManager.onPurchaseSucceeded token=>"+purchaseToken);
            console.log("CafebazaarPaymentManager.onPurchaseSucceeded sku=>"+sku);
            cafebazaarManager.verifyPurchase(purchaseToken,sku);
        }
        onPurchaseFailed: (message)=> {
            console.log("CafebazaarPaymentManager.onPurchaseFailed =>"+message);
            btnCafebazaar.enabled=true;
        }
        onPurchaseVerified: (paid)=> {
            console.log("99999999999999999999[ pay with cafebazzar step 16 ]99999999999999999999");
            console.log(" CafebazaarPaymentManager.onPurchaseVerified paid=>"+paid+" message=>"+message);
            order.paid=paid;
            btnCafebazaar.enabled=true;
        }
        onIsProcessingChanged:(isProcessing)=> {
            progressIndicator.visible=isProcessing;
        }
    }
    contentHeight: basketClm.implicitHeight
    ColumnLayout{
        id:basketClm
        anchors.fill: parent
        spacing: 3
        PaneWithTitle{
            id: recValue
            title: "پرداخت آنلاین"
            Layout.fillWidth: true
            Layout.preferredHeight: clm.implicitHeight+18
            Layout.margins: 9
            Material.background: MaterialStyle.primary100
            Material.elevation: 1
            RoundButton{
                id: btnAdminPayment
                visible: CurrentUser.isAnyAdmin
                width: 54
                height: 54
                highlighted: true
                Material.elevation: 2
                anchors.top: parent.top
                anchors.left: parent.left
                contentItem: Image {
                    fillMode: Image.Pad
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    source:"../../images/common/dots-vertical.png"
                }
                MouseArea{
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton
                    onClicked: {
                        if(!CurrentUser.isAnyAdmin){
                            return;
                        }
                        if(mnuOrder.visible){
                            mnuOrder.close();
                        }
                        else{
                            mnuOrder.open();
                        }
                    }
                }

                JooyaMenu{
                    id:mnuOrder
                    x:btnAdminPayment.x+18
                    y:btnAdminPayment.y+btnAdminPayment.height+27
                    JooyaMenuItem{
                        jtext:{
                            if(order.manualPaid){
                                return "خروج از حالت پرداخت دستی"
                            }
                            else {
                                return "پرداخت دستی"
                            }
                        }
                        onClicked: {
                            if(order.manualPaid){
                                dlgManualPay.message= "آیا مایل هستید سفارش از حالت پرداخت دستی خارج شود؟";
                            }
                            else{
                                dlgManualPay.message= "آیا مایل هستید سفارش بصورت دستی پرداخت شود؟"
                            }
                            dlgManualPay.open();
                        }
                    }
                    JooyaMenuItem{
                        jtext: "پرداخت"
                        enabled: order.paid
                        onClicked: {
                            paymentManager.pay();
                            btnPay.enabled=false;
                        }
                    }
                }
            }
            ColumnLayout{
                id:clm
                anchors.fill: parent
                spacing: 9
                Pane{
                    Material.elevation: 3
                    Material.background:  MaterialStyle.secondary200
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 18
                    Layout.preferredHeight: 206
                    Layout.preferredWidth: 175
                    SwipeView{
                        id:svImgs
                        anchors.fill: parent
                        clip: true
                        Repeater{
                            model: 2

                            Image {
                                fillMode: Image.PreserveAspectFit
                                source: img.isExists? img.url:""
                            }
                        }
                    }
                }
                Text {
                    font{
                        pixelSize: 15
                        family: flYekan.name
                    }
                    clip: true
                    wrapMode: Text.Wrap
                    text: "فرایند پیری را آهسته کنید.تمرین های طلایی رخشید برای بهبود ظاهر چهره و پوست شما"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillWidth: true
                    Layout.leftMargin: 9
                    Layout.rightMargin: 9
                    color: MaterialStyle.primaryTextColor
                }
                Row{
                    spacing: 1
                    Layout.alignment: Qt.AlignHCenter|Qt.AlignTop
                    Layout.preferredWidth: 252
                    Layout.topMargin: 9
                    Rectangle{
                        implicitWidth: 162
                        implicitHeight: 36
                        border.width: 1
                        border.color:MaterialStyle.secondary300
                        color:MaterialStyle.secondary200
                        Text {
                            text: order.price/10+" تومان"
                            anchors.centerIn: parent
                            font.family: flYekan.name
                            color: MaterialStyle.primaryTextColor
                        }
                    }
                    Rectangle{
                        implicitWidth: 81
                        implicitHeight: 36
                        border.width: 1
                        border.color:MaterialStyle.secondary300
                        color:MaterialStyle.secondary200
                        Text {
                            text: "قیمت"
                            anchors.centerIn: parent
                            font.family: flYekan.name
                            color: MaterialStyle.primaryTextColor
                        }
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                }
                Row{
                    spacing: 1
                    Layout.alignment: Qt.AlignHCenter|Qt.AlignTop
                    Layout.preferredWidth: 252
                    Layout.topMargin: 3
                    Rectangle{
                        implicitWidth: 162
                        implicitHeight: 36
                        border.width: 1
                        border.color:MaterialStyle.secondary300
                        color:MaterialStyle.secondary200
                        Text {
                            text: order.discountPercent==0?"دریافت تخفیف": order.discountPercent+" درصد"
                            anchors.centerIn: parent
                            font.family: flYekan.name
                            color: MaterialStyle.primaryTextColor
                            SequentialAnimation on color{
                                running: !order.paid
                                loops: Animation.Infinite
                                ColorAnimation  { to: "yellow"; duration: 900 }
                                ColorAnimation  { to: "red"; duration: 900 }
                            }

                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    sv.push("../common/SharePage.qml");
                                }
                            }
                        }
                    }
                    Rectangle{
                        implicitWidth: 81
                        implicitHeight: 36
                        border.width: 1
                        border.color:MaterialStyle.secondary300
                        color:MaterialStyle.secondary200
                        Text {
                            text: "مقدار تخفیف"
                            anchors.centerIn: parent
                            font.family: flYekan.name
                            color: MaterialStyle.primaryTextColor
                        }
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                }
                Row{
                    spacing: 1
                    Layout.alignment: Qt.AlignHCenter|Qt.AlignTop
                    Layout.preferredWidth: 252
                    Layout.topMargin: 3
                    Rectangle{
                        implicitWidth: 162
                        implicitHeight: 36
                        border.width: 1
                        border.color:MaterialStyle.secondary300
                        color:MaterialStyle.secondary200
                        Text {
                            text: order.priceWithDiscount/10+" تومان"
                            anchors.centerIn: parent
                            font.family: flYekan.name
                            color: MaterialStyle.primaryTextColor
                        }
                    }
                    Rectangle{
                        implicitWidth: 81
                        implicitHeight: 36
                        border.width: 1
                        border.color:MaterialStyle.secondary300
                        color:MaterialStyle.secondary200
                        Text {
                            text: "قیمت نهایی"
                            anchors.centerIn: parent
                            font.family: flYekan.name
                            color: MaterialStyle.primaryTextColor
                        }
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                }

                JooyaButton{
                    id:btnPay
                    Layout.topMargin: 9
                    text: order.paid? "مشاهده تراکنش":"پرداخت"
                    font{
                        pixelSize: 19
                    }
                    onClicked: {
                        if(order.paid){
                            sv.push("OrderTransactionsPage.qml",{pm:paymentManager});
                        }
                        else{
                            paymentManager.pay();
                            btnPay.enabled=false;
                        }
                    }
                }
                JooyaButton{
                    id:btnCafebazaar
                    visible: Qt.platform.os==="android" && !order.paid && !order.manualPaid
                    Layout.topMargin: 9
                    text: "پرداخت از کافه بازار"
                    font{
                        pixelSize: 19
                    }
                    onClicked: {
                        // route the result dialog to the cafebazaar payment result
                        console.log("99999999999999999999[ pay with cafebazzar step 01 ]99999999999999999999")
                        dlgPaymentResult.paymentResult = cafebazaarManager.paymentResult;
                        cafebazaarManager.loadSku(); // continues with skuReceived -> startPurchase
                        btnCafebazaar.enabled=false;
                    }
                }
                Item {
                    Layout.fillHeight: true
                }
            }

            Image {
                id: imgPaid
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: height
                property bool t: false
                height: 81
                width: 81
                visible: order.paid||order.manualPaid
                rotation:randomT*randomRotation
                source:order.paid?"../../images/app/Paid-256.png":"../../images/app/ManualPaid-256.png"
            }
        }

        PaneWithTitle{
            id:paneManualPayment
            title: "پرداخت کارت به کارت"
            Layout.fillWidth: true
            Layout.preferredHeight: clmManualPayment.implicitHeight
            Layout.margins: 9
            Material.background: MaterialStyle.primary100
            Material.elevation: 1
            ColumnLayout{
                id:clmManualPayment
                anchors.fill: parent
                spacing:1
                Text {
                    font{
                        pixelSize: 15
                        family: flYekan.name
                    }
                    clip: true
                    wrapMode: Text.Wrap
                    text: "پرداخت دستی و بررسی توسط پشتیبان"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillWidth: true
                    Layout.leftMargin: 9
                    Layout.rightMargin: 9
                    Layout.topMargin: 18
                    color: MaterialStyle.primaryTextColor
                }
                Row{
                    spacing: 1
                    Layout.alignment: Qt.AlignHCenter|Qt.AlignTop
                    Layout.preferredWidth: 252
                    Layout.topMargin: 9
                    Rectangle{
                        implicitWidth: 180
                        implicitHeight: 36
                        border.width: 1
                        border.color:MaterialStyle.secondary300
                        color:MaterialStyle.secondary200
                        Text {
                            text: "5784785232"
                            anchors.centerIn: parent
                            font.family: flYekan.name
                            color: MaterialStyle.primaryTextColor
                        }
                    }
                    Rectangle{
                        implicitWidth: 90
                        implicitHeight: 36
                        border.width: 1
                        border.color:MaterialStyle.secondary300
                        color:MaterialStyle.secondary200
                        Text {
                            text: "شماره حساب"
                            anchors.centerIn: parent
                            font.family: flYekan.name
                            color: MaterialStyle.primaryTextColor
                        }
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                }
                Row{
                    spacing: 1
                    Layout.alignment: Qt.AlignHCenter|Qt.AlignTop
                    Layout.preferredWidth: 252
                    Layout.topMargin: 3
                    Rectangle{
                        implicitWidth: 180
                        implicitHeight: 36
                        border.width: 1
                        border.color:MaterialStyle.secondary300
                        color:MaterialStyle.secondary200
                        Text {
                            text: "ملت"
                            anchors.centerIn: parent
                            font.family: flYekan.name
                            color: MaterialStyle.primaryTextColor
                        }
                    }
                    Rectangle{
                        implicitWidth: 90
                        implicitHeight: 36
                        border.width: 1
                        border.color:MaterialStyle.secondary300
                        color:MaterialStyle.secondary200
                        Text {
                            text: "نزد بانک"
                            anchors.centerIn: parent
                            font.family: flYekan.name
                            color: MaterialStyle.primaryTextColor
                        }
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                }
                Row{
                    spacing: 1
                    Layout.alignment: Qt.AlignHCenter|Qt.AlignTop
                    Layout.preferredWidth: 252
                    Layout.topMargin: 3
                    Rectangle{
                        implicitWidth: 180
                        implicitHeight: 36
                        border.width: 1
                        border.color:MaterialStyle.secondary300
                        color:MaterialStyle.secondary200
                        Text {
                            text: "جویا افزار تخت جمشید"
                            anchors.centerIn: parent
                            font.family: flYekan.name
                            color: MaterialStyle.primaryTextColor
                        }
                    }
                    Rectangle{
                        implicitWidth: 90
                        implicitHeight: 36
                        border.width: 1
                        border.color:MaterialStyle.secondary300
                        color:MaterialStyle.secondary200
                        Text {
                            text: "نام صاحب حساب"
                            anchors.centerIn: parent
                            font.family: flYekan.name
                            color: MaterialStyle.primaryTextColor
                        }
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                }
                //======================================================================
                PaneWithTitle{
                    id:paneQuestionContainer
                    title: "متن رسید پرداخت"
                    Layout.alignment: Qt.AlignTop|Qt.AlignHCenter
                    Layout.preferredHeight: 100
                    Layout.preferredWidth: clmManualPayment.implicitWidth
                    Layout.topMargin: 9
                    Material.background: MaterialStyle.secondary200
                    titleBackColor: MaterialStyle.secondary300
                    ScrollView {
                        id: flickQuestion
                        anchors.fill: parent
                        anchors.topMargin: 18
                        clip: true
                        enabled: !order.manualPaid
                        TextArea {
                            id: textAreasManualPaymentReceipt
                            text: order.manualPaymentReceipt
                            textFormat: TextEdit.PlainText
                            wrapMode: TextArea.Wrap
                            selectByMouse: true
                            placeholderText: "پس از پرداخت رسید را به صورت متنی اینجا وارد کنید"
                            leftPadding: 9
                            rightPadding: 9
                            topPadding: 0
                            bottomPadding: 0
                            background: null
                            font{
                                family: flIranSanse.name
                                pixelSize: 12
                            }
                            onActiveFocusChanged: {
                                if(activeFocus){
                                }
                            }
                        }
                        ScrollBar.vertical: ScrollBar {
                            width: 9
                            height: parent.height
                        }
                        ScrollBar.horizontal: ScrollBar {
                            width: 9
                        }
                    }
                }
                Row{
                    visible: order.manualPaymentReceipt !== ""
                    spacing: 1
                    Layout.alignment: Qt.AlignHCenter|Qt.AlignTop
                    Layout.preferredWidth: 253
                    Layout.topMargin: 3
                    Rectangle{
                        implicitWidth: 108
                        implicitHeight: 36
                        border.width: 1
                        border.color:MaterialStyle.secondary300
                        color:MaterialStyle.secondary200
                        Text {
                            text: order.manualPaid ? "پرداخت شده است":"در حال بررسی"
                            anchors.centerIn: parent
                            font.family: flYekan.name
                            color: MaterialStyle.primaryTextColor
                        }
                    }
                    Rectangle{
                        implicitWidth: 145
                        implicitHeight: 36
                        border.width: 1
                        border.color:MaterialStyle.secondary300
                        color:MaterialStyle.secondary200
                        Text {
                            text: "نتیجه پرداخت دستی"
                            anchors.centerIn: parent
                            font.family: flYekan.name
                            color: MaterialStyle.primaryTextColor
                        }
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                }
                //======================================================================
                JooyaButton{
                    id:btnSaveCriditCardTrasaction
                    Layout.topMargin: 9
                    text: "ثبت رسید"
                    enabled: !order.manualPaid
                    font{
                        pixelSize: 19
                    }
                    onClicked: {
                        console.log(textAreasManualPaymentReceipt.text);
                        order.saveManualPaymentReceipt();
                    }
                }
                Item {
                    Layout.fillHeight: true
                }
            }
        }
        Item {
            Layout.fillHeight: true
        }
    }


    ProgressIndicator{
        id: progressIndicator
    }
    ConfirmationDialog{
        id:dlgManualPay
        onYesClicked: {
            order.manualPay();
        }
    }
    OrderPaymentResultDlg{
        id:dlgPaymentResult
        paymentResult: paymentManager.paymentResult
    }
}


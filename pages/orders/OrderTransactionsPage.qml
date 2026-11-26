import QtQuick
import QtQuick.Controls
import "../../jsf/Bootstrap.js" as Bs
import "../../jooyaQuickControls"
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Window
import Jooya

Page{
    property PaymentManager pm

    Component.onCompleted: {
        pm.getTransactions();
    }

    JooyaGridView{
        id: root
        anchors.fill: parent

        cellWidth: Bs.bootSize(root.width,"xs-12 sm-12 md-6 lg-4 xl-4")
        cellHeight: 220

        delegate: OrderTransactionItem{
            width: root.cellWidth
            height: root.cellHeight
            transaction: currentTransaction
        }
        model: pm.transactions
    }
}

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import "../../jsf/Bootstrap.js" as Bs
import Jooya
import "../../jooyaQuickControls"

JooyaGridView {
    id: gvUserRoles
    property User user: null
    Component.onCompleted: {
        if(user!=null){
            user.getRoles();
        }
    }
    signal rightClicked()
    property bool isVisible: false
    cellWidth:gvUserRoles.width/3
    cellHeight:58

    delegate: KeywordPane {
        width: gvUserRoles.cellWidth
        height: gvUserRoles.cellHeight
        content:model.name
        selected: model.selected
        onItemClicked: {
            if(model.selected){
                user.removeFromRole(model.name);
            }
            else{
                user.addToRole(model.name);
            }
        }
    }
    model: user.roles
}

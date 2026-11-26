import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material

Pane{
    id:rectContainer
    padding: 0
    Material.elevation: 1
    Material.background: MaterialStyle.primary100
    //=================< new properties >===================
    property string title: ""
    TitleItem{
        x: titleHorizontalAlignment === Label.AlignRight ? rectContainer.width - width - 18 : 18
        visible: rectContainer.text!==""
        title: rectContainer.title
    }
}

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material

Pane{
    id:rectContainer
    padding: 0
    Material.elevation: 1
    //=================< new properties >===================
    property string title: "عنوان"
    property color titleBackColor: MaterialStyle.primary200
    TitleItem{
        x: titleHorizontalAlignment === Label.AlignRight ? rectContainer.width - width - 18 : 18
        visible: rectContainer.text!==""
        title: rectContainer.title
        backColor: rectContainer.titleBackColor
    }
}

import QtQuick
import QtQuick.Controls
import Jooya
import "../../jooyaQuickControls"
import QtQuick.Layouts
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material
import "../../items/common"

Rectangle{
    id:itemimg
    property UserImage userImage: null
    color: MaterialStyle.primary200

    ImageItem{
        imageFile: userImage
        defaultImageUrl: "../../images/common/account.png"
        anchors.fill: parent
        TagItem{
            text: userImage.persianDate == "" ? "تاریخ تصویر" : userImage.persianDate
            fontFamily: flYekan.name
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 9
            anchors.left: parent.left
            anchors.leftMargin: 9
        }
    }
}

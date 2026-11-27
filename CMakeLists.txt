cmake_minimum_required(VERSION 3.16)
set(PROJECT_NAME common)
project(${PROJECT_NAME} VERSION 1.0 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets Quick QuickControls2 Qml Network WebSockets Multimedia WebView)

# qt_standard_project_setup()

add_library(${PROJECT_NAME} SHARED)

qt_add_qml_module(${PROJECT_NAME}
    URI JooyaQuick
    VERSION 1.0

    QML_FILES

    pages/users/SignupPhonePage.qml
    pages/users/UserActivationPage.qml
    pages/users/LoginPage.qml
    pages/users/SignupPage.qml
    pages/users/UserImageItem.qml
    pages/users/UserItem.qml
    pages/users/UserProfilePage.qml
    pages/users/UserDisplayNamePage.qml
    pages/chat/ChatPage.qml
    pages/chat/ContactItem.qml
    pages/chat/ChatsPage.qml
    pages/chat/ContactsDialog.qml
    pages/chat/ChatAddPage.qml
    pages/chat/PostItem.qml
    pages/chat/ChatItem.qml
    pages/chat/TalkItem.qml
    pages/orders/BaskeBankPage.qml
    pages/orders/OrderPaymentResultDlg.qml
    pages/orders/OrderTransactionItem.qml
    pages/orders/OrderTransactionsPage.qml
    pages/common/ImageViewer.qml
    pages/common/TakePicturePage.qml
    pages/common/SharePage.qml
    pages/common/SettingsPage.qml
    pages/common/DatePickerDialog.qml
    pages/common/NotifyDisplayPage.qml
    pages/common/NotifyItem.qml
    pages/common/AddKeywordToTypesDialog.qml
    pages/common/NotificationTypeEditDialog.qml
    pages/common/AboutUsPage.qml
    pages/common/FrequentQuestionsPage.qml
    pages/common/FileExplorerPage.qml
    pages/common/ImageEditor.qml
    items/common/ImageViewerItem.qml
    items/common/UserInfoDisplayer.qml
    items/common/ImageItem.qml
    items/common/TitleItem.qml
    items/common/PaneWithTitle.qml
    items/common/RectWithTitle.qml
    items/common/NewProductLabelItem.qml
    items/common/ConfirmationPane.qml
    items/common/HelpBar.qml
    items/common/ToolButtonTextUnder.qml
    items/common/IconImage.qml
    
    
    jooyaQuickControls/CircleImage.qml
    jooyaQuickControls/CirclePercentIndicator.qml
    jooyaQuickControls/CircleSecondIndicator.qml
    jooyaQuickControls/ConfirmationDialog.qml
    jooyaQuickControls/FontLoaderYekan.qml
    jooyaQuickControls/IranSanseFontLoader.qml
    jooyaQuickControls/JooyaButton.qml
    jooyaQuickControls/JooyaCursor.qml
    jooyaQuickControls/JooyaDialog.qml
    jooyaQuickControls/JooyaFlickable.qml
    jooyaQuickControls/JooyaGridView.qml
    jooyaQuickControls/JooyaLabel.qml
    jooyaQuickControls/JooyaListView.qml
    jooyaQuickControls/JooyaMenu.qml
    jooyaQuickControls/JooyaMenuItem.qml
    jooyaQuickControls/JooyaMenuSeparator.qml
    jooyaQuickControls/JooyaPage.qml
    jooyaQuickControls/JooyaProgressBar.qml
    jooyaQuickControls/JooyaTextField.qml
    jooyaQuickControls/JooyaToolTip.qml
    jooyaQuickControls/LabelTextField.qml
    jooyaQuickControls/MessageBar.qml
    jooyaQuickControls/MessageBox.qml
    jooyaQuickControls/ProgressIndicator.qml
    jooyaQuickControls/PropertyItemRow.qml
    jooyaQuickControls/ScrollablePage.qml
    jooyaQuickControls/TextFieldLabeld.qml
    jooyaQuickControls/KeywordPane.qml
    jooyaQuickControls/DatePicker.qml
    jooyaQuickControls/MessageBar2.qml
    jooyaQuickControls/Separator.qml
    jooyaQuickControls/ProIndicator.qml
    jooyaQuickControls/ImageRectItem.qml
    jooyaQuickControls/TagItem.qml
    jooyaQuickControls/ThemChangeAnimator.qml
    
    
    pages/manager/HttpRequestTypePage.qml
    pages/manager/ManagerDialog.qml
    pages/manager/ManagerPrivateKeyPage.qml
    pages/manager/ManagingItem.qml
    pages/manager/RoleAddPage.qml
    pages/manager/RoleItem.qml
    pages/manager/RolePage.qml
    pages/manager/SettingBehpardakhtPage.qml
    pages/manager/SettingSmsPage.qml
    pages/manager/UsersPage.qml
    pages/manager/UserRolesPage.qml
    pages/manager/KeywordItem.qml
    pages/manager/KeywordPage.qml
    pages/manager/KeywordAddPage.qml
    pages/manager/NotifyDiscountEditDialog.qml
    pages/manager/NotifyAppIntroEditDialog.qml
    
    jsf/Bootstrap.js
    jsf/JSUtility.js
    
    
    
    RESOURCES
    
    fonts/IRANSans.ttf
    fonts/Yekan.ttf
    shaders/maskshader.qsb
    
    
    images/manager/behpardakht.png
    images/manager/behpardakht@2x.png
    images/manager/behpardakht@3x.png
    images/manager/behpardakht@4x.png
    images/manager/cryptography.png
    images/manager/cryptography@2x.png
    images/manager/cryptography@3x.png
    images/manager/cryptography@4x.png
    images/manager/http.png
    images/manager/http@2x.png
    images/manager/http@3x.png
    images/manager/http@4x.png
    images/manager/role.png
    images/manager/role@2x.png
    images/manager/role@3x.png
    images/manager/role@4x.png
    images/manager/search-profile.png
    images/manager/search-profile@2x.png
    images/manager/search-profile@3x.png
    images/manager/search-profile@4x.png
    images/manager/smartphone.png
    images/manager/smartphone@2x.png
    images/manager/smartphone@3x.png
    images/manager/smartphone@4x.png
    images/manager/keyword.png
    images/manager/keyword@2x.png
    images/manager/keyword@3x.png
    images/manager/keyword@4x.png
    images/manager/account-cog@4x.png
    images/manager/account-cog@3x.png
    images/manager/account-cog@2x.png
    images/manager/account-cog.png
    
    
    
    
    images/common/google.png
    images/common/google@2x.png
    images/common/google@3x.png
    images/common/google@4x.png
    images/common/account.png
    images/common/account@2x.png
    images/common/account@3x.png
    images/common/account@4x.png
    images/common/back.png
    images/common/back@2x.png
    images/common/back@3x.png
    images/common/back@4x.png
    images/common/bell.png
    images/common/bell@2x.png
    images/common/bell@3x.png
    images/common/bell@4x.png
    images/common/brightness-6.png
    images/common/brightness-6@2x.png
    images/common/brightness-6@3x.png
    images/common/brightness-6@4x.png
    images/common/camera-retake.png
    images/common/camera-retake@2x.png
    images/common/camera-retake@3x.png
    images/common/camera-retake@4x.png
    images/common/camera-switch.png
    images/common/camera-switch@2x.png
    images/common/camera-switch@3x.png
    images/common/camera-switch@4x.png
    images/common/camera.png
    images/common/camera@2x.png
    images/common/camera@3x.png
    images/common/camera@4x.png
    images/common/cart.png
    images/common/cart@2x.png
    images/common/cart@3x.png
    images/common/cart@4x.png
    images/common/cellphone-arrow-down.png
    images/common/cellphone-arrow-down@2x.png
    images/common/cellphone-arrow-down@3x.png
    images/common/cellphone-arrow-down@4x.png
    images/common/chevron-left.png
    images/common/chevron-left@2x.png
    images/common/chevron-left@3x.png
    images/common/chevron-left@4x.png
    images/common/cog.png
    images/common/cog@2x.png
    images/common/cog@3x.png
    images/common/cog@4x.png
    images/common/delete.png
    images/common/delete@2x.png
    images/common/delete@3x.png
    images/common/delete@4x.png
    images/common/dots-vertical.png
    images/common/dots-vertical@2x.png
    images/common/dots-vertical@3x.png
    images/common/dots-vertical@4x.png
    images/common/download.png
    images/common/download@2x.png
    images/common/download@3x.png
    images/common/download@4x.png
    images/common/frequently-asked-questions.png
    images/common/frequently-asked-questions@2x.png
    images/common/frequently-asked-questions@3x.png
    images/common/frequently-asked-questions@4x.png
    images/common/image-filter-hdr.png
    images/common/image-filter-hdr@2x.png
    images/common/image-filter-hdr@3x.png
    images/common/image-filter-hdr@4x.png
    images/common/information.png
    images/common/information@2x.png
    images/common/information@3x.png
    images/common/information@4x.png
    images/common/logout.png
    images/common/logout@2x.png
    images/common/logout@3x.png
    images/common/logout@4x.png
    images/common/menu.png
    images/common/menu@2x.png
    images/common/menu@3x.png
    images/common/menu@4x.png
    images/common/palette.png
    images/common/palette@2x.png
    images/common/palette@3x.png
    images/common/palette@4x.png
    images/common/phone.png
    images/common/phone@2x.png
    images/common/phone@3x.png
    images/common/phone@4x.png
    images/common/plus.png
    images/common/plus@2x.png
    images/common/plus@3x.png
    images/common/plus@4x.png
    images/common/sale.png
    images/common/sale@2x.png
    images/common/sale@3x.png
    images/common/sale@4x.png
    images/common/share-variant.png
    images/common/share-variant@2x.png
    images/common/share-variant@3x.png
    images/common/share-variant@4x.png
    images/common/upload.png
    images/common/upload@2x.png
    images/common/upload@3x.png
    images/common/upload@4x.png
    images/common/weather-night.png
    images/common/weather-night@2x.png
    images/common/weather-night@3x.png
    images/common/weather-night@4x.png
    images/common/white-balance-sunny.png
    images/common/white-balance-sunny@2x.png
    images/common/white-balance-sunny@3x.png
    images/common/white-balance-sunny@4x.png
    images/common/window-close.png
    images/common/window-close@2x.png
    images/common/window-close@3x.png
    images/common/window-close@4x.png
    images/common/magnify@4x.png
    images/common/magnify@3x.png
    images/common/magnify@2x.png
    images/common/magnify.png
    images/common/refresh@4x.png
    images/common/refresh@3x.png
    images/common/refresh@2x.png
    images/common/refresh.png
    images/common/rectangle@4x.png
    images/common/rectangle@3x.png
    images/common/rectangle@2x.png
    images/common/rectangle.png
    images/common/lan-disconnect@4x.png
    images/common/lan-disconnect@3x.png
    images/common/lan-disconnect@2x.png
    images/common/lan-disconnect.png
    images/common/lan-connect@4x.png
    images/common/lan-connect@3x.png
    images/common/lan-connect@2x.png
    images/common/lan-connect.png
    images/common/pencil@4x.png
    images/common/pencil@3x.png
    images/common/pencil@2x.png
    images/common/pencil.png
    images/common/folder-open@4x.png
    images/common/folder-open@3x.png
    images/common/folder-open@2x.png
    images/common/folder-open.png
    images/common/cut@4x.png
    images/common/cut@3x.png
    images/common/cut@2x.png
    images/common/cut.png
    images/common/clock-time-nine.png
    images/common/clock-time-nine@2x.png
    images/common/clock-time-nine@3x.png
    images/common/clock-time-nine@4x.png
    images/common/repeat@4x.png
    images/common/repeat@3x.png
    images/common/repeat@2x.png
    images/common/repeat.png
    images/common/basket-minus@4x.png
    images/common/basket-minus@3x.png
    images/common/basket-minus@2x.png
    images/common/basket-minus.png
    images/common/basket-plus@4x.png
    images/common/basket-plus@3x.png
    images/common/basket-plus@2x.png
    images/common/basket-plus.png
    images/common/basket@4x.png
    images/common/basket@3x.png
    images/common/basket@2x.png
    images/common/basket.png
    images/common/save.png
    images/common/save@2x.png
    images/common/save@3x.png
    images/common/save@4x.png
    images/common/content-save.png
    images/common/content-save@4x.png
    images/common/content-save@3x.png
    images/common/content-save@2x.png
    images/common/bookmark.png
    images/common/bookmark@2x.png
    images/common/bookmark@3x.png
    images/common/bookmark@4x.png
    images/common/bookmark-filled.png
    images/common/bookmark-filled@2x.png
    images/common/bookmark-filled@3x.png
    images/common/bookmark-filled@4x.png
    images/common/open-in-new.png
    images/common/open-in-new@2x.png
    images/common/open-in-new@3x.png
    images/common/open-in-new@4x.png
    images/common/resize.png
    images/common/resize@2x.png
    images/common/resize@3x.png
    images/common/resize@4x.png
    
    
    images/chat/message-reply-text@4x.png
    images/chat/message-reply-text@3x.png
    images/chat/message-reply-text@2x.png
    images/chat/message-reply-text.png
    images/chat/check-all@4x.png
    images/chat/check-all@3x.png
    images/chat/check-all@2x.png
    images/chat/check-all.png
    images/chat/check@4x.png
    images/chat/check@3x.png
    images/chat/check@2x.png
    images/chat/check.png
    images/chat/clock-time-three-outline@4x.png
    images/chat/clock-time-three-outline@3x.png
    images/chat/clock-time-three-outline@2x.png
    images/chat/clock-time-three-outline.png
    images/chat/pin-off@4x.png
    images/chat/pin-off@3x.png
    images/chat/pin-off@2x.png
    images/chat/pin-off.png
    images/chat/pin@4x.png
    images/chat/pin@3x.png
    images/chat/pin@2x.png
    images/chat/pin.png
    images/chat/eye@4x.png
    images/chat/eye@3x.png
    images/chat/eye@2x.png
    images/chat/eye.png
    images/chat/message.png
    images/chat/message@2x.png
    images/chat/message@3x.png
    images/chat/message@4x.png
    images/chat/arrow-left@4x.png
    images/chat/arrow-left@3x.png
    images/chat/arrow-left@2x.png
    images/chat/arrow-left.png
    images/chat/send@4x.png
    images/chat/send@3x.png
    images/chat/send@2x.png
    images/chat/send.png
    images/chat/chevron-down@4x.png
    images/chat/chevron-down@3x.png
    images/chat/chevron-down@2x.png
    images/chat/chevron-down.png
    
    
    images/media/pause.png
    images/media/pause@2x.png
    images/media/pause@3x.png
    images/media/pause@4x.png
    images/media/play.png
    images/media/play@2x.png
    images/media/play@3x.png
    images/media/play@4x.png
    images/media/skip-backward.png
    images/media/skip-backward@2x.png
    images/media/skip-backward@3x.png
    images/media/skip-backward@4x.png
    images/media/skip-forward.png
    images/media/skip-forward@2x.png
    images/media/skip-forward@3x.png
    images/media/skip-forward@4x.png
    images/media/skip-next.png
    images/media/skip-next@2x.png
    images/media/skip-next@3x.png
    images/media/skip-next@4x.png
    images/media/skip-previous.png
    images/media/skip-previous@2x.png
    images/media/skip-previous@3x.png
    images/media/skip-previous@4x.png
    images/media/stop.png
    images/media/stop@2x.png
    images/media/stop@3x.png
    images/media/stop@4x.png
    images/media/volume-high.png
    images/media/volume-high@2x.png
    images/media/volume-high@3x.png
    images/media/volume-high@4x.png
    images/media/volume-mute.png
    images/media/volume-mute3x.png
    images/media/volume-mute4x.png
    images/media/volume-mute@2x.png
    
    
    
)

target_include_directories(${PROJECT_NAME} PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/libs/androidlib
    ${CMAKE_SOURCE_DIR}/libs/corelib ${CMAKE_SOURCE_DIR}/libs/networklib ${CMAKE_SOURCE_DIR}/libs/chatlib
    ${CMAKE_SOURCE_DIR}/libs/notificationlib ${CMAKE_SOURCE_DIR}/libs/quicklib ${CMAKE_SOURCE_DIR}/libs/managerlib
    ${CMAKE_SOURCE_DIR}/libs/settingslib ${CMAKE_SOURCE_DIR}/libs/purchasinglib ${CMAKE_SOURCE_DIR}/libs/loginlib
)

target_link_libraries(${PROJECT_NAME}
    PUBLIC
    Qt6::Core Qt6::CorePrivate Qt6::Gui Qt6::Widgets Qt6::Quick Qt6::QuickControls2 Qt6::Qml Qt6::Network Qt6::WebSockets Qt6::Multimedia Qt6::WebView

    androidlib corelib networklib chatlib notificationlib quicklib managerlib settingslib purchasinglib loginlib
)

if(ANDROID)
    set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME "${PROJECT_NAME}_${CMAKE_ANDROID_ARCH_ABI}")
endif()



import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import JooyaQuick.Controls.Material

Item {
    property double windowWidth: 0
    property double windowHeight: 0
    function displayBackground()
    {
        setAnimationEnabling(true);
        console.log("inerMask.visible "+inerMask.visible);
        if(MaterialStyle.isDark){
            inerMask.height=0;
        }
        else{
            inerMask.y=windowHeight;
        }
    }
    function displayWindowCapturedImg()
    {
        setAnimationEnabling(false);
        inerMask.y=0;
        inerMask.height=windowHeight;
    }
    function setAnimationEnabling(enable)
    {
        animationOnHeight.enabled=enable;
        animationOnY.enabled=enable;
    }
    Image {
        id: windowimg
        parent: Overlay.overlay
        x:0
        y:0
        width: windowWidth
        height: windowHeight
        z:99999
        source:MaterialStyle.windowCapturedImgPath
        fillMode: Image.PreserveAspectCrop
        clip: true
        cache: false
        visible: false
        layer.enabled: true
        layer.smooth: true
    }
    Rectangle {
        id: mask
        parent: Overlay.overlay
        anchors.fill: windowimg
        color: "transparent"
        visible: false
        Rectangle {
            id: inerMask
            x:0
            width: windowimg.width
            height: windowHeight
            opacity: 1.0
            Behavior on height {
                id:animationOnHeight
                NumberAnimation {
                    duration: 900
                    easing.type: Easing.OutQuart
                    onRunningChanged: {
                        if(running)
                        {
                            console.log("@@@ animation on height started @@@");
                            inerMask.visible=true;
                            mask.visible=true;
                        }
                        else
                        {
                            console.log("@@@ animation on height finished @@@");
                            inerMask.visible=false;
                            mask.visible=false;
                            setAnimationEnabling(false);
                        }
                    }
                }
            }
            Behavior on y {
                id:animationOnY
                NumberAnimation {
                    duration: 900
                    easing.type: Easing.OutQuart
                    onRunningChanged: {
                        if(running)
                        {
                            console.log("@@@ animation on y started @@@");
                            inerMask.visible=true;
                            mask.visible=true;
                        }
                        else
                        {
                            console.log("@@@ animation on y finished @@@");
                            inerMask.visible=false;
                            mask.visible=false;
                            setAnimationEnabling(false);
                        }
                    }
                }
            }
        }
        z:99999
        layer.enabled: true
        layer.samplerName: "maskSource"
        layer.effect: ShaderEffect {
            property var colorSource: windowimg
            fragmentShader: "../shaders/maskshader.qsb"
        }
    }

}

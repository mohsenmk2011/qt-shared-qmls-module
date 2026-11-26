import QtQuick
import QtQuick.Controls
import Jooya
import QtMultimedia
import QtQuick.Layouts
import QtQuick.Window
import QtSensors
import "../../jooyaQuickControls"


JooyaPage {
    id:root
    objectName: "TakePicturePage"
    property UserProfile up: null
    Component.onCompleted: {
    }
    Connections{
        target: up
        function onImageWasUploaded(isSuccessfull) {
            if(isSuccessfull){
                sv.pop();
            }
            btnUpload.enabled=true
        }
        function onIsProcessingChanged(isProcessing) {
            progressIndicatorVisible=isProcessing
        }
    }

    property int imageOrientation: 90
    property int screenOrientation: 90

    OrientationSensor {
        id: orient
        active: true
        onReadingChanged: {
            if (reading.orientation === OrientationReading.TopUp)
                screenOrientation=90;
            else if (reading.orientation === OrientationReading.TopDown)
                screenOrientation=270;
            else if (reading.orientation === OrientationReading.LeftUp)
                screenOrientation=180;
            else if (reading.orientation === OrientationReading.RightUp)
                screenOrientation=0;
            else
                screenOrientation=0;
        }
    }
    CaptureSession{
        camera: Camera {
            id: camera
            // position: Camera.BackFace
            whiteBalanceMode: Camera.WhiteBalanceFlash

            flashMode: Camera.FlashRedEyeReduction
            focusMode: {
                focusMode: Camera.FocusModeAutoNear
                focusPointMode: Camera.FocusPointCenter
            }
        }
        videoOutput: cameraDisplay
        imageCapture {
            onImageCaptured: {
                camera.stop();
                photoPreview.source = preview
                up.loadImage(imageOrientation,preview);
            }
            onImageSaved: {
                console.log("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                console.log("#################################");
                console.log("=================================");
                console.log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                console.log("*** Camera.onImageSaved ***");
                console.log("path=> "+path);
                //up.loadImage(imageOrientation,"file://"+ path);
                console.log("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                console.log("#################################");
                console.log("=================================");
                console.log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
            }
        }

    }

    VideoOutput {
        id:cameraDisplay
        anchors.fill: parent
        fillMode: VideoOutput.Stretch
        // orientation: true
        focus : visible // to receive focus and capture key events when visible
    }
    Image {
        id: photoPreview
        anchors.fill: parent
        visible: false
    }
    RoundButton{
        id: btnCapture
        anchors.bottom:cameraDisplay.bottom
        anchors.bottomMargin: 10
        anchors.horizontalCenter: cameraDisplay.horizontalCenter
        width: 72
        height: 72
        highlighted: true
        enabled: screenOrientation === 90
        contentItem: Image {
            fillMode: Image.Pad
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            source: cameraDisplay.visible?"../images/common/camera.png":"../images/common/camera-retake.png"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if(cameraDisplay.visible){
                    imageOrientation=screenOrientation;
                    camera.imageCapture.capture();
                    cameraDisplay.visible=false;
                    photoPreview.visible=true;
                }
                else{
                    camera.start();
                    photoPreview.visible=false;
                    cameraDisplay.visible=true;
                }
            }
        }
    }
    RoundButton{
        id: btnUpload
        anchors.left: btnCapture.right
        anchors.leftMargin: 10
        anchors.bottom:cameraDisplay.bottom
        anchors.bottomMargin: 10
        width: 64
        height: 64
        highlighted: true
        visible: photoPreview.visible
        contentItem: Image {
            fillMode: Image.Pad
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../images/common/upload.png"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                btnUpload.enabled=false;
                up.uploadProfileImage();
            }
        }
    }

}

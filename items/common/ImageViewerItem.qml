import QtQuick

Item {
    id: viewport
    property string imageUrl: ""
    property alias imageScale: content.scale
    // Allow children declared by the caller to go inside content
    default property alias contentChildren: content.data
    clip: true

    // Zoomable image and annotations
    Item {
        id: content

        // Use the image's original dimensions
        width: img.implicitWidth > 0
               ? img.implicitWidth : 600
        height: img.implicitHeight > 0
                ? img.implicitHeight : 450

        // Initially fit the image in the viewport.
        // These bindings are replaced when zooming starts.
        x: (viewport.width - width * scale) / 2
        y: (viewport.height - height * scale) / 2

        transformOrigin: Item.TopLeft
        scale: Math.min(
                   1.0,
                   viewport.width / Math.max(1, width),
                   viewport.height / Math.max(1, height)
                   )

        Image {
            id: img
            anchors.fill: parent
            source: imageUrl
            fillMode: Image.Stretch
        }
/// muscles name and arreow should be here
    }

    // Zoom using the mouse wheel, keeping the point under
    // the cursor stationary.
    function zoomAt(px, py, factor) {
        const oldScale = content.scale
        const newScale = Math.max(
                           0.1,
                           Math.min(10.0, oldScale * factor)
                           )

        if (newScale === oldScale)
            return

        const ratio = newScale / oldScale

        content.x = px - (px - content.x) * ratio
        content.y = py - (py - content.y) * ratio
        content.scale = newScale
    }

    WheelHandler {
        id: wheelHandler
        target: content
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad

        onWheel: function(event) {
            console.log("Wheel event received:",event.angleDelta.y)
            const factor = event.angleDelta.y > 0
                         ? 1.1 : 1.0 / 1.1

            viewport.zoomAt(
                        point.position.x,
                        point.position.y,
                        factor
                        )

            event.accepted = true
        }
    }
    PinchHandler {
        id: pinchHandler
        target: null

        minimumScale: 0.5
        maximumScale: 5.0
        onScaleChanged: (delta) => {
             console.log("delta=> "+delta);
             viewport.zoomAt(centroid.position.x,centroid.position.y,delta);
        }
    }

    DragHandler {
        id: panHandler

        target: content

        // Mouse on desktop and touch on Android
        acceptedDevices: PointerDevice.Mouse
                         | PointerDevice.TouchScreen
                         | PointerDevice.TouchPad

        // Only begin dragging with the left mouse button
        acceptedButtons: Qt.LeftButton

        // Allow panning even when the pointer begins over
        // the image or its annotation items.
        grabPermissions: PointerHandler.CanTakeOverFromAnything
    }
}

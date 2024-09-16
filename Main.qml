import QtCore
import QtQuick
import QtLocation
import QtPositioning

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("NintyS' Localizator")

    // Init
    Component.onCompleted: {
        location.request()
        // nM.register()
    }

    // Pobieranie lokalizacji i innego gówna

    LocationPermission {
        id: location
    }

    PositionSource {
        id: positionSource

        active: true
        updateInterval: 1000
        preferredPositioningMethods: PositionSource.AllPositioningMethods
        onPositionChanged: {
            console.log("Pozycja: ", positionSource.position.coordinate)
        }
    }

    Timer {
        interval: 1500; running: true; repeat: true
        onTriggered: {
            nM.sendData(positionSource.position.coordinate.latitude, positionSource.position.coordinate.longitude)
        }
    }

    // GUI

    // Rectangle {
    //     height: 50
    //     width: parent.width

    //     Text {
    //         id: name
    //         text: "Device name: "
    //         font.pixelSize: 24
    //     }

    // }

    Plugin {
        id: mapPlugin

        name: "osm"
    }

    Map {
        id: map

        property geoCoordinate startCentroid
        property MapCircle circle

        height: parent.height // - 50
        width: parent.width

        // y: 100

        // anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(positionSource.position.coordinate.latitude, positionSource.position.coordinate.longitude)
        zoomLevel: 14

        MapCircle {
            radius: 100
            color: 'green'
            border.width: 3

            center {
                latitude: positionSource.position.coordinate.latitude
                longitude: positionSource.position.coordinate.longitude
            }

        }

        PinchHandler {
            id: pinch

            target: null
            onActiveChanged: {
                if (active)
                    map.startCentroid = map.toCoordinate(pinch.centroid.position, false);

            }
            onScaleChanged: (delta) => {
                map.zoomLevel += Math.log2(delta);
                map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position);
            }
            grabPermissions: PointerHandler.TakeOverForbidden
        }

        WheelHandler {
            id: wheel

            // workaround for QTBUG-87646 / QTBUG-112394 / QTBUG-112432:
            // Magic Mouse pretends to be a trackpad but doesn't work with PinchHandler
            // and we don't yet distinguish mice and trackpads on Wayland either
            acceptedDevices: Qt.platform.pluginName === "cocoa" || Qt.platform.pluginName === "wayland" ? PointerDevice.Mouse | PointerDevice.TouchPad : PointerDevice.Mouse
            rotationScale: 1 / 120
            property: "zoomLevel"
        }

        DragHandler {
            id: drag

            target: null
            onTranslationChanged: (delta) => {
                return map.pan(-delta.x, -delta.y);
            }
        }

        Shortcut {
            enabled: map.zoomLevel < map.maximumZoomLevel
            sequence: StandardKey.ZoomIn
            onActivated: map.zoomLevel = Math.round(map.zoomLevel + 1)
        }

        Shortcut {
            enabled: map.zoomLevel > map.minimumZoomLevel
            sequence: StandardKey.ZoomOut
            onActivated: map.zoomLevel = Math.round(map.zoomLevel - 1)
        }

    }

}

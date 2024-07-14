import QtQuick
import QtLocation
import QtPositioning
import QtQuick.Controls

ApplicationWindow {
    visible: true
    width: 640
    height: 480

    PositionSource {
        id: positionSource
        active: true
        updateInterval: 1000 // Update interval in milliseconds
        onPositionChanged: {
            var position = positionSource.position.coordinate
            console.log("Latitude: " + position.latitude + "\nLongitude: " + position.longitude)
            pm.sendPos(position.latitude, position.longitude)
        }
    }

    Plugin {
        id: mapPlugin
        name: "osm"
    }

    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        width: parent.width
        height: parent.height

        // var position2 = positionSource.position.coordinate

        center: QtPositioning.coordinate(positionSource.position.coordinate.latitude, positionSource.position.coordinate.longitude) // Oslo
        zoomLevel: 25
        property geoCoordinate startCentroid

        property MapCircle circle

        MapCircle {
                center {
                    latitude: positionSource.position.coordinate.latitude
                    longitude: positionSource.position.coordinate.longitude
                }
                radius: 3.0
                color: 'green'
                border.width: 3
                opacity: 0.8
            }

        PinchHandler {
                    id: pinch
                    target: null
                    onActiveChanged: if (active) {
                        map.startCentroid = map.toCoordinate(pinch.centroid.position, false)
                    }
                    onScaleChanged: (delta) => {
                        map.zoomLevel += Math.log2(delta)
                        map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
                    }
                    onRotationChanged: (delta) => {
                        map.bearing -= delta
                        map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
                    }
                    grabPermissions: PointerHandler.TakeOverForbidden
                }
                WheelHandler {
                    id: wheel
                    // workaround for QTBUG-87646 / QTBUG-112394 / QTBUG-112432:
                    // Magic Mouse pretends to be a trackpad but doesn't work with PinchHandler
                    // and we don't yet distinguish mice and trackpads on Wayland either
                    acceptedDevices: Qt.platform.pluginName === "cocoa" || Qt.platform.pluginName === "wayland"
                                     ? PointerDevice.Mouse | PointerDevice.TouchPad
                                     : PointerDevice.Mouse
                    rotationScale: 1/120
                    property: "zoomLevel"
                }
                DragHandler {
                    id: drag
                    target: null
                    onTranslationChanged: (delta) => map.pan(-delta.x, -delta.y)
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

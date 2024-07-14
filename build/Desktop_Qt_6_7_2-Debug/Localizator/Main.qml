import QtQuick
import QtLocation
import QtPositioning
import QtQuick.Controls

ApplicationWindow {
    visible: true
    width: 640
    height: 480

    Plugin {
        id: mapPlugin
        name: "osm"
    }

    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin

        // var position2 = positionSource.position.coordinate

        center: QtPositioning.coordinate(0, 0) // Oslo
        zoomLevel: 14
        property geoCoordinate startCentroid
    }


    Rectangle {
        width: parent.width
        height: parent.height
        anchors.centerIn: parent

        Text {
            id: locationText
            text: "Waiting for location..."
            anchors.centerIn: parent
        }

        PositionSource {
            id: positionSource
            active: true
            updateInterval: 50 // Update interval in milliseconds
            onPositionChanged: {
                var position = positionSource.position.coordinate
                locationText.text = "Latitude: " + position.latitude + "\nLongitude: " + position.longitude
            }
        }
    }
}

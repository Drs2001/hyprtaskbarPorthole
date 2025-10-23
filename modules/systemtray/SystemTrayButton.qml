// ImageButton.qml (in your modules/widgets folder)
import QtQuick
import Quickshell.Io
import qs.singletons

Rectangle {
    id: root
    
    // Properties you can customize
    property string imageSource: "root:/assets/arch_blue.png"
    property int imageSize: 24
    property color buttonColor: "transparent"
    property color hoverColor: Themes.hoverColor
    property color borderColor: Qt.lighter(Themes.hoverColor, 1.2)
    property string program: "walker"
    
    // Signal emitted when clicked
    signal clicked()
    
    width: imageSize + 16
    height: imageSize + 16
    radius: 6
    color: mouseArea.containsMouse ? hoverColor : buttonColor

    // Border appears on hover
    border.color: mouseArea.containsMouse ? borderColor : "transparent"
    border.width: 1
    
    // Smooth color transitions
    Behavior on color {
        ColorAnimation { duration: 150 }
    }

    Behavior on border.color {
        ColorAnimation { duration: 180 }
    }
    
    Image {
        id: buttonImage
        anchors.centerIn: parent
        source: root.imageSource
        width: root.imageSize
        height: root.imageSize
        fillMode: Image.PreserveAspectFit
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            launcher.running = true
        }
    }

    Process {
        id: launcher
        command: [root.program]
        running: false
    }
}
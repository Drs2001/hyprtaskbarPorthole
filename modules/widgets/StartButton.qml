import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import qs.singletons

Button {
    id: root

    property string imageSource: "root:/assets/arch_blue.png"
    property string alternateImageSource: "root:/assets/toothless.gif"

    implicitWidth: 40
    implicitHeight: 40

    contentItem: AnimatedImage {
        id: buttonImage
        anchors.centerIn: parent
        source: root.imageSource
        width: root.imageSize
        height: root.imageSize
        fillMode: Image.PreserveAspectFit
        playing: root.imageSource.endsWith(".gif")
        paused: false
    }

    background: Rectangle {
        color: root.hovered ? Themes.hoverColor : "transparent"
        border.color: root.hovered ? Themes.hoverShadow : "transparent"
        radius: 6
    }

    onClicked: {
        launcher.running = true
    }

    // *** Easter Egg :) ***
    onPressAndHold: {
        holdTimer.start()
    }

    onReleased: {
        holdTimer.stop()
    }

    Timer {
        id: holdTimer
        interval: 5000 
        repeat: false
        onTriggered: {
            var temp = root.imageSource
            root.imageSource = root.alternateImageSource
            root.alternateImageSource = temp
        }
    }
    //*********************
    
    Process {
        id: launcher
        command: ["walker"]
        running: false
    }
}
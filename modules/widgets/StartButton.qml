import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import qs.singletons

Button {
    id: root

    property string imageSource: "root:/assets/arch_blue.png"

    implicitWidth: 40
    implicitHeight: 40

    contentItem: Image {
        id: buttonImage
        anchors.centerIn: parent
        source: root.imageSource
        width: root.imageSize
        height: root.imageSize
        fillMode: Image.PreserveAspectFit
    }

    background: Rectangle {
        color: root.hovered ? Themes.hoverColor : "transparent"
        border.color: root.hovered ? Themes.hoverShadow : "transparent"
        radius: 6
    }

    onClicked: {
        launcher.running = true
    }

    Process {
        id: launcher
        command: ["walker"]
        running: false
    }
}
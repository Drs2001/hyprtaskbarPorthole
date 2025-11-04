import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.singletons

Button {
    id: button
    required property var window

    implicitWidth: 48
    implicitHeight: 48

    contentItem: Image{
        source: Quickshell.iconPath(window[0].application.icon, true)
        sourceSize.width: 48
        sourceSize.height: 48
        fillMode: Image.PreserveAspectFit
    }

    background: Rectangle{
        color: button.hovered ? Themes.hoverColor : "transparent"
        border.color: button.hovered ? Themes.hoverShadow : "transparent"
        radius: 6
    }

    

    onClicked:{
        console.log(window[0].title)
        console.log(DesktopEntries.heuristicLookup("Prime Video"))
    }
}
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.singletons

Button {
    id: button
    required property var windows
    property var minimized: false

    implicitWidth: 48
    implicitHeight: 48

    contentItem: Image{
        source: windows[0].iconPath
        sourceSize.width: 48
        sourceSize.height: 48
        fillMode: Image.PreserveAspectFit
    }

    background: Rectangle{
        color: button.hovered ? Themes.hoverColor : "transparent"
        border.color: button.hovered ? Themes.hoverShadow : "transparent"
        radius: 6
    }

    WindowPopupView{
        id: popup
    }
}

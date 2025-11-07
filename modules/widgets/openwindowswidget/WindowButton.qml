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

    //TODO: handle the array of windows that share id, currently just looks at the first window and ignores the others
    onClicked: {
        if(windows[0].minimized){
            var workspaceId = Hyprland.focusedWorkspace.id

            // We fullscreen temporarily here to fix a weird bug with hyprland where swapping workspaces while another window is fullscreend cause the sub window to turn invisible
            // Recreate -> open two windows in the same workspace, fullscreen one to hide the other then change the workspace of the hidden window and it will turn invisible. 
            // Toggling fullscreen forces a redraw because hyprland doesnt have a redraw command exposed.
            // (May be fixed in future hyprland releases will check back on this)
            windows[0].window.wayland.fullscreen = true
            windows[0].window.wayland.fullscreen = false
            //*****************************************************************************/

            Hyprland.dispatch("movetoworkspacesilent " + workspaceId + ", address:0x" + windows[0].window.address);
            windows[0].minimized = false
        }
        else {
            Hyprland.dispatch("movetoworkspacesilent special, address:0x" + windows[0].window.address);
            windows[0].minimized = true
        }
    }
    

    WindowPopupView{
        id: popup
    }
}

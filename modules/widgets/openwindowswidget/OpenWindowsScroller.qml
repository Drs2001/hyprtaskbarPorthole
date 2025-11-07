import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.singletons

//TODO: Figure out how to use scroll wheel for horizontal scrolling
ScrollView {
    id: windowScroller
    Layout.fillWidth: true
    Layout.maximumWidth: root.width - rightWidgets.width

    // ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    ScrollBar.vertical.policy: ScrollBar.AlwaysOff

    ScrollBar.horizontal.interactive: true
    RowLayout {
        height: parent.height

        Repeater {
            model: ApplicationsManager.openWindows
            delegate: WindowButton{
                required property var modelData
                windows: modelData
                Layout.fillWidth: true
            }
        }
    }
}
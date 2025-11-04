pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
    id: root

    property var entries: []
    property var openWindows: Hyprland.toplevels
    
    Component.onCompleted: updateEntries()
    
    Connections {
        target: DesktopEntries.applications
        function onValuesChanged() {
            updateEntries()
        }
    }
    
    function updateEntries() {
        var apps = DesktopEntries.applications.values.slice()
        entries = apps.sort((a, b) => a.name.localeCompare(b.name))
    }
}
pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root

    property var entries: []
    
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
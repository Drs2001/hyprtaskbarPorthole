pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
    id: root

    property var entries: []
    property var rawWindows: Hyprland.toplevels.values
    property var openWindows: createOpenWindows()
    
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

    // Create custom window dict to return(We use function to keep binding to Hyprland toplevel values)
    function createOpenWindows(){
        var dict = {}

        rawWindows.filter(w => w.wayland).forEach(w => {
            var appId = w.wayland.appId
            var application = DesktopEntries.heuristicLookup(appId)

            // Check if we found something with the heuristic look up and if not check if its  chrome webapp
            if(!application){
                if(appId.includes("chrome")){
                    application = DesktopEntries.heuristicLookup("chromium")
                }
            }
            
            // Second check incase it was a chrome web app (Probably a simpler way to do this than 2 checks but hey it works so -_('~')_-)
            if(application){
                 if(!dict[appId]) {
                    dict[appId] = []
                }

                dict[appId].push({
                    id: appId,
                    window: w,
                    application: application
                })
            }
        })

        return Object.values(dict)
    }
}
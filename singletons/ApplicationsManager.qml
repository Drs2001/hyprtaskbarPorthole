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
            
            // We attempt to get the icon path here as not all appIds corrospond to applicaitons, so we want to make sure some icon is displayed
            var iconPath = ""
            if(application){
                iconPath = Quickshell.iconPath(application.icon, true)
            }
            else {
                iconPath = Quickshell.iconPath(appId, true)
            }

            if(iconPath == ""){
                if(appId.includes("steam")){
                    iconPath = Quickshell.iconPath(appId.replace("app", "icon"), true)
                }
                
                if(iconPath == ""){
                    iconPath = Quickshell.iconPath(findIconFallback(appId), true)
                }

                if(iconPath == ""){
                    iconPath = Quickshell.iconPath("application-default-icon", true)
                }
            }

            var minimized = false

                if(!dict[appId]) {
                dict[appId] = []
            }

            if(w.workspace.id == -99){
                minimized = true
            }
            dict[appId].push({
                id: appId,
                minimized: minimized,
                window: w,
                application: application,
                iconPath: iconPath
            })
            
        })

        return Object.values(dict)
    }

    function findIconFallback(appId){
        // 2. Convert to lowercase for case-insensitive matching
        let searchId = appId.toLowerCase();
        
        // 3. Remove version numbers and common suffixes
        // Match patterns like "1.21.1", "v2.0", etc.
        searchId = searchId.replace(/[_\s-]*(v?\d+\.)*\d+(\.\d+)*[_\s-]*/g, '');
        
        // 4. Remove common special characters and cleanup
        searchId = searchId.replace(/[*&$@#!()[\]{}]/g, '');
        
        // 5. Remove common suffixes
        searchId = searchId.replace(/[_\s-]*(beta|alpha|stable|dev|nightly|git)$/i, '');
        
        // 6. Split on common separators and take first significant part
        let parts = searchId.split(/[_\s-]+/);
        searchId = parts[0] || searchId;
        
        // 7. Try to find icon with this cleaned name
        return searchId;
    }
}
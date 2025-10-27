import QtQuick
import Quickshell
import Quickshell.Io
import qs.singletons

Text{
    id: root
    font.family: "Symbols Nerd Font"
    font.pixelSize: 16
    color: Themes.textColor

    property string networkStatus: "disconnected"
    property string networkIcon: "\udb81\uddaa" 

    function updateNetworkIcon() {
        // Update icon based on network status
        if(networkStatus.includes("ethernet")){
            root.text = "\udb80\udc02";  // ethernet icon
        }
        else if (networkStatus.includes("wireless")) {
            root.text = "\udb81\udda9";  // wifi icon
        } 
         else {
            root.text = "\udb81\uddaa";  // disconnected icon
        }
    }
    
    Process {
        id: nmcliProc
        command: ["nmcli", "-t", "-f", "STATE,TYPE", "connection", "show", "--active"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                root.networkStatus = this.text
                updateNetworkIcon()
            }
        }
    }
    
    Timer {
        interval: 1000  // Check every 1 seconds
        running: true
        repeat: true
        onTriggered: nmcliProc.running = true
    }
    
    Component.onCompleted: updateNetworkIcon()
}
pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
    property string volumeIcon: "\ueee8"

    PwObjectTracker {
        id: sinkTracker
        objects: [Pipewire.defaultAudioSink]
    }

    // Function to update the audio icon based on current audio levels
    function updateIcon(){
        let sink = Pipewire.defaultAudioSink

        if(sink){
            if(sink.audio.muted){
                this.volumeIcon = "\ueee8"
            }
            else if(sink.audio.volume > 0.66){
                this.volumeIcon = "\uf028"
            }
            else if(sink.audio.volume > 0.33){
                this.volumeIcon = "\uf027"
            }
            else if(sink.audio.volume > 0){
                this.volumeIcon = "\uf026"
            }
            else{
                this.volumeIcon = "\ueee8"
            }
        }
    }

    // Timer to poll current audio levels
    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: updateIcon()
    }
}
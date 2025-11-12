pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
    id: root

    readonly property var nodes: Pipewire.nodes.values.reduce((acc, node) => {
        if (!node.isStream) {
            if (node.isSink)
                acc.sinks.push(node);
            else if (node.audio)
                acc.sources.push(node);
        }
        else{
            if(node.audio){
                acc.programs.push(node)
            }
        }
        return acc;
    }, {
        sources: [],
        sinks: [],
        programs: []
    })

    readonly property list<PwNode> sinks: nodes.sinks // A list of hardware devices that can output audio
    readonly property list<PwNode> sources: nodes.sources // A list of hardware devices that can input audio
    readonly property list<PwNode> programs: nodes.programs // A list of programs with a audio stream, either outputting audio or inputing
    readonly property list<PwNode> outputPrograms: programs.filter( // List of programs outputting audio
        node => node.properties["media.class"]?.includes("Stream/Output/Audio")
    )

    property string volumeIcon: "\ueee8"
    property real volumeLevel: 0.0
    property string volumePercentage: ""
    property PwNode sink: Pipewire.defaultAudioSink
    // property real currentVolume: sink ? sink.audio.volume : 0

    // Function to update the audio icon based on current audio levels
    function updateIcon(){
        if(sink){
            if(sink.audio.muted){
                volumeIcon = "\ueee8"
            }
            else if(sink.audio.volume > 0.66){
                volumeIcon = "\uf028"
            }
            else if(sink.audio.volume > 0.33){
                volumeIcon = "\uf027"
            }
            else if(sink.audio.volume > 0){
                volumeIcon = "\uf026"
            }
            else{
                volumeIcon = "\ueee8"
            }
        }
    }

    function updateVolumeLevel(){
        if(sink){
            volumeLevel = sink.audio.volume
        }
    }

    function updateVolumePercentage(){
        if(sink){
            volumePercentage = (Math.round(volumeLevel * 100)) + "%"
        }
    }

    // sets the volume level of the current output device
    function setVolume(newVolume: real): void {
        if (sink?.ready && sink?.audio) {
            sink.audio.muted = false;

            // We currently use execDetached as setting the volume doesnt always work through the api, specifically for some bluetooth devices.
            // Using the wireplumber command is more reliable
            // sink.audio.volume = Math.max(0, Math.min(1.5, newVolume)); may switch back in future update if it becomes more reliable
            Quickshell.execDetached({
                    command: ["wpctl", "set-volume", "@DEFAULT_SINK@", Math.max(0, Math.min(1.5, newVolume))]
            });
        }
    }

    function setDefaultSink(newSink: PwNode): void {
        Pipewire.preferredDefaultAudioSink = newSink
    }

    // Timer to poll current audio levels
    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            updateIcon()
            updateVolumeLevel()
            updateVolumePercentage()
        }
    }

    PwObjectTracker {
        id: sinkTracker
        objects: [...root.sinks, ...root.sources, ...root.programs]
    }
}
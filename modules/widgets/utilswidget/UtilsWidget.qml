import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import qs.singletons

Button {
    id: root
    property string volumeIcon: "\ueee8"

    implicitWidth: 32
    implicitHeight: 32

    PwObjectTracker {
        id: sinkTracker
        objects: [Pipewire.defaultAudioSink]
    }

    // Function to update the audio icon based on current audio levels
    function updateIcon(){
        let sink = Pipewire.defaultAudioSink

        if(sink){
            if(sink.audio.muted){
                root.volumeIcon = "\ueee8"
            }
            else if(sink.audio.volume > 0.66){
                root.volumeIcon = "\uf028"
            }
            else if(sink.audio.volume > 0.33){
                root.volumeIcon = "\uf027"
            }
            else if(sink.audio.volume > 0){
                root.volumeIcon = "\uf026"
            }
            else{
                root.volumeIcon = "\ueee8"
            }
        }
    }

    Component.onCompleted: updateIcon()

    contentItem: Text {
        id: arrowIcon
        text: root.volumeIcon
        font.family: "Symbols Nerd Font"
        font.pixelSize: 16
        color: Themes.textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        implicitWidth: 32
        implicitHeight: 32
        color: root.hovered ? Themes.hoverColor : "transparent"
        border.color: root.hovered ? Qt.lighter(Themes.hoverColor, 1.2) : "transparent"
        radius: 6
    }

    // Timer to poll current audio levels
    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: updateIcon()
    }
}
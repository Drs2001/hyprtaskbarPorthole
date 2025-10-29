import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.singletons

Item {
    required property var device
    property bool expanded: false
    
    // Dynamically set the height so it changes when we expose the sub menu
    implicitHeight: column.implicitHeight

    // Animate the height change
    Behavior on height {  
        NumberAnimation {
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }
    
    // Stacks button and sub menu defaulting sub menu to invisible
    Column {
        id: column
        width: parent.width
        
        // Main device button
        Button {
            id: deviceButton
            width: parent.width
            height: 40
            text: device.deviceName
            
            onClicked: expanded = !expanded
            
            contentItem: Row {
                Text {
                    text: device.deviceName
                    color: "black"
                    verticalAlignment: Text.AlignVCenter
                }
                Text {
                    text: expanded ? "▼" : "▶"
                    color: "black"
                }
            }
        }
        
        // Revealer for actions
        Item {
            id: revealer
            width: parent.width
            height: expanded ? actions.implicitHeight : 0
            clip: true
            
            Behavior on height {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
            
            opacity: expanded ? 1 : 0
            Behavior on opacity {
                NumberAnimation { duration: 150 }
            }
            
            Column {
                id: actions
                width: parent.width
                padding: 8
                spacing: 4
                
                Button {
                    text: device.connected ? "Disconnect" : "Connect"
                    width: parent.width - 16
                    onClicked: {
                        console.log("Connect/Disconnect")
                    }
                }
                
                Button {
                    text: "Remove"
                    width: parent.width - 16
                    visible: device.paired
                    onClicked: {
                        console.log("Remove device")
                    }
                }
            }
        }
    }
}
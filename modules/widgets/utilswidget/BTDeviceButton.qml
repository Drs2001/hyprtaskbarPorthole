import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.singletons

Item {
    required property var device
    property bool expanded: false
    property bool connecting: false

    width: parent.width
    
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
            
            onClicked: {
                if(device.connected) {
                    expanded = !expanded
                }
                else {
                    if(!device.paired){
                        BluetoothManager.enablePairable()
                    }
                    device.connect()
                }
            }
            
            contentItem: Column {
                Text {
                    text: device.deviceName
                    color: Themes.textColor
                    verticalAlignment: Text.AlignVCenter
                }
                Text {
                    function getConnectionText(){
                        if(device.connected){
                            return "Connected"
                        }
                        else{
                            if(connecting){
                                return "Connecting..."
                            }
                            else{
                                return "Not connected"
                            }

                        }
                    }
                    text: getConnectionText()
                    color: Themes.textColor
                    verticalAlignment: Text.AlignVCenter
                }
            }

            background: Rectangle {
                color: deviceButton.hovered ? Themes.hoverColor : "transparent"
                border.color: deviceButton.hovered ? Themes.hoverShadow : "transparent"
                radius: 6
            }
        }
        
        // Revealer menu for action buttons on connected bluetooth devices
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
            
            Row { 
                id: actions
                layoutDirection: Qt.RightToLeft
                width: parent.width
                padding: 8
                spacing: 8

                // Revealer menu button for forgetting a paired device
                Button {
                    id: removeButton
                    padding: 8
                    visible: device.paired
                    onClicked: {
                        device.forget()
                    }
                    contentItem: Text{
                        text: "Forget"
                        color: Themes.textColor
                    }
                    background: Rectangle {
                        color: removeButton.hovered ? Qt.lighter(Themes.hoverColor) : Themes.hoverColor
                        border.color: removeButton.hovered ? Qt.lighter(Themes.hoverColor, 1.2) : "transparent"
                        radius: 6
                    }
                }

                // Revealer menu button for disconnecting bluetooth device
                Button {
                    id: disconnectButton
                    padding: 8
                    onClicked: {
                        if(device.connected){
                            device.disconnect()
                        }
                    }
                    contentItem: Text{
                        text: "Disconnect"
                        color: Themes.textColor
                    }
                    background: Rectangle {
                        color: disconnectButton.hovered ? Qt.lighter(Themes.hoverColor) : Themes.hoverColor
                        border.color: disconnectButton.hovered ? Qt.lighter(Themes.hoverColor, 1.2) : "transparent"
                        radius: 6
                    }
                }
            }
        }

        // Set adapter pairable to false and trust device after pairing
        Connections {
            target: device
            function onPairedChanged() {
                if(!device.trusted && device.paired){
                    device.trusted = true
                }
            }

            function onStateChanged(){
                var state = device.state.toString()
                if(state == "0"){
                    connecting = false
                }
                else if(state == "1"){
                    connecting = false
                }
                else if(state == "2"){
                    //Do nothing for now
                }
                else if(state == "3"){
                    connecting = true
                }
            }
        }
    }
}
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Bluetooth

Singleton {
    id: root

    property var adapter: Bluetooth.defaultAdapter

    // Booleans used for themeing
    property var isEnabled: true
    property var isConnected: false
    
    // Sorted device lists
    property var connectedDevices: adapter?.devices?.values.filter(d => d.connected)
    property var pairedDevices: adapter?.devices?.values.filter(d => d.paired && !d.connected)
    property var avaliableDevices: adapter?.devices?.values.filter(d => !d.paired && !d.connected && d.deviceName)

    // Starts discovery for the adapter
    function startDiscovery(){
        if(!adapter.discovering){
            adapter.discovering = true
        }
    }

    // Sets the pairability of the bluetooth adapter.(This is needed so that the device can bond to the adapter, otherwise it only soft connects)
    function enablePairable(){
        adapter.pairableTimeout = 10 // set the pairable timeout to ensure it always disables pairing (May update later to manual enable/ disable of pairable)
        adapter.pairable = true
    }

    // Toggle the bluetooth adapter(adapter.state, 0 = Disabled, 1 = Enabled, 4 = Blocked)
    function toggleBluetooth(){
        if(adapter.state == 4){
            bluetoothUnblock.running = true
        }
        else if(adapter.state == 1){
            bluetoothBlock.running = true
        }
        else if(adapter.state == 0){
            adapter.enabled = true
        }
    }

    Process {
        id: bluetoothUnblock
        command: ["rfkill", "unblock", "bluetooth"]
        running: false
    }

    Process {
        id: bluetoothBlock
        command: ["rfkill", "block", "bluetooth"]
        running: false
    }
}
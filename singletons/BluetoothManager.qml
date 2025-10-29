pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Bluetooth

Singleton {
    id: root

    property var adapter: Bluetooth.defaultAdapter
    
    // Sorted device lists
    property var connectedDevices: adapter.devices.values.filter(d => d.connected)
    property var pairedDevices: adapter.devices.values.filter(d => d.paired && !d.connected)
    property var avaliableDevices: adapter.devices.values.filter(d => !d.paired && !d.connected && d.deviceName)

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
}
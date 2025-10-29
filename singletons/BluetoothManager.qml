pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Bluetooth

Singleton {
    id: root

    property var adapter: Bluetooth.defaultAdapter
    
    function getDevices(){
        return adapter.devices.values
    }
}
pragma Singleton

import Quickshell
import Quickshell.Services.UPower
import QtQuick

Singleton {
    id: root

    property var isLaptop: UPower.onBattery
    
}
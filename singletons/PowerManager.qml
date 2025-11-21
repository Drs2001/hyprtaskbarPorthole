pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import QtQuick

Singleton {
    id: root

    property var battery: {
        for(var i = 0; i < UPower.devices.values.length; i++) {
            var device = UPower.devices.values[i]
            if(device.isLaptopBattery){
                return device
            }
        }
        return null
    }

    property var isLaptop: {
        if(battery){
            return true
        }
        return false
    }

    property var batteryPercentage: {
        if(battery){
            return Math.round(battery.percentage * 100)
        }
        else{
            return -1
        }
    }

    property var isCharging: updateChargeIndicator()

    property var batteryIcon: "\uf244"

    function updateIcon(){
        if(battery){
            if(batteryPercentage > 80){
                batteryIcon = "\uf240"
            }
            else if(batteryPercentage > 0.60){
                batteryIcon = "\uf241"
            }
            else if(batteryPercentage > 0.40){
                batteryIcon = "\uf242"
            }
            else if(batteryPercentage > 20){
                batteryIcon = "\uf243"
            }
            else{
                batteryIcon = "\uf244"
            }
        }
    }

    function updateChargeIndicator(){
        if(battery){
            if(battery.timeToFull > 0){
                return true
            }
            return false
        }
        return false
    }

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            updateIcon()
            updateChargeIndicator()
        }
    }

    
}
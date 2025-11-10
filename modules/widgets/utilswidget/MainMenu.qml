import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import Quickshell
import qs.singletons

Item {
    implicitHeight: 300
    Flow {
        id: trayIconsFlow
        width: parent.width
        spacing: 8
        padding: 8
        
        // Bluetooth Button
        BTMenuButton{
            stack: rootStack
        }
    }
}

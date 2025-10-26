// SystemTrayPopup.qml
import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.SystemTray
import qs.singletons

Popup {
    id: popup
    popupType: Popup.Window
    y: -height - 16

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 200
        color: Themes.backgroundColor
        border.color: Themes.borderColor
        radius: 10
    }

    onClosed: {
        menuOpen = false
    }

    Column {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 4
    
        Flow {
            id: trayIconsFlow
            width: parent.width
            spacing: 8
            padding: 8
            
            Repeater {
                id: items

                model: ScriptModel {
                values: [...SystemTray.items.values]
                }

                TrayItem {
                    barPopup: popup
                }
            }
        }
        
    }
}
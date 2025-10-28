// SystemTrayPopup.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import Quickshell
import Quickshell.Services.SystemTray
import qs.singletons

Popup {
    id: popup
    popupType: Popup.Window
    y: -height - 16

    background: Rectangle {
        id: trayBackground
        implicitWidth: 200
        color: Themes.backgroundColor
        border.color: Themes.hoverColor
        border.width: 1.5
        radius: 10
    }

    onClosed: {
        menuOpen = false
    }

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
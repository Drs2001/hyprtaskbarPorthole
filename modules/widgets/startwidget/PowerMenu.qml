import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.singletons

Popup {
    height: 100
    width: 100
    popupType: Popup.Window

    y: -height - 20

    background: Rectangle {
        color: Themes.backgroundColor
        radius: 10
    }

    ColumnLayout{
        Layout.fillWidth: true
        
        Button{
            text: "Power off"
            onClicked: {
                Quickshell.execDetached({
                    command: ["systemctl", "poweroff"]
                });
            }
        }
        Button{
            text: "Restart"
            onClicked: {
                Quickshell.execDetached({
                    command: ["systemctl", "reboot"]
                });
            }
        }
    }
}
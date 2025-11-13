import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.singletons

Popup {
    height: 100
    width: 100
    popupType: Popup.Item

    y: -height

    background: Rectangle {
        color: Themes.primaryColor
        border.color: Themes.primaryHoverShadow
        radius: 10
    }

    ColumnLayout{
        anchors.fill: parent
        
        Button{
            id: powerButton
            Layout.fillWidth: true
            background: Rectangle{
                color: powerButton.hovered ? Themes.primaryHoverColor : "transparent"
                radius: 10
            }
            contentItem: Text{
                text: "\udb81\udc25 Power off"
                color: Themes.textColor
            }
            onClicked: {
                Quickshell.execDetached({
                    command: ["systemctl", "poweroff"]
                });
            }
        }
        Button{
            id: rebootButton
            Layout.fillWidth: true
             background: Rectangle{
                color: rebootButton.hovered ? Themes.primaryHoverColor : "transparent"
                radius: 10
            }
            contentItem: Text{
                text: "\udb81\udc59 Reboot"
                color: Themes.textColor
            }
            onClicked: {
                Quickshell.execDetached({
                    command: ["systemctl", "reboot"]
                });
            }
        }
    }
}
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.singletons

Popup {
    height: 100
    width: 100
    popupType: Popup.Window

    y: -height

    background: Rectangle {
        color: Themes.backgroundColor
        border.color: Themes.hoverShadow
        radius: 10
    }

    ColumnLayout{
        anchors.fill: parent
        
        Button{
            id: powerButton
            Layout.fillWidth: true
            background: Rectangle{
                color: powerButton.hovered ? Themes.hoverColor : "transparent"
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
                color: rebootButton.hovered ? Themes.hoverColor : "transparent"
                radius: 10
            }
            contentItem: Text{
                text: "\udb81\udf09 Reboot"
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
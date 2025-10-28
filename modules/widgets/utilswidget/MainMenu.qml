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
        
        Button {
            id: bluetooth
            implicitHeight: 40
            implicitWidth: 80

            contentItem: Text{
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "\uf293"
                color: "white"
            }

            background: Rectangle{
                radius: 4
                color: bluetooth.hovered ? Themes.hoverColor : "gray"
            }

            onClicked: {
                stack.push("BluetoothMenu.qml") // Push files as QML wraps files as components
            }
        }
    }
}

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
        Row {
            Button {
                id: bluetoothToggle
                implicitHeight: 45
                implicitWidth: 45

                contentItem: Text{
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "\udb80\udcaf"
                    color: Themes.textColor
                }

                background: Rectangle{
                    radius: 0
                    topLeftRadius: 4
                    bottomLeftRadius: 4
                    color: bluetoothToggle.hovered ? Themes.accentHover : Themes.accentColor
                }

                onClicked: {
                    //TODO Implement bluetooth toggle
                }
            }
            Button {
                id: bluetoothOpen
                implicitHeight: 45
                implicitWidth: 45

                contentItem: Text{
                    font.pixelSize: 15
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "\uf054"
                    color: Themes.textColor
                }

                background: Rectangle{
                    radius: 0
                    topRightRadius: 4
                    bottomRightRadius: 4
                    color: bluetoothOpen.hovered ? Themes.accentHover : Themes.accentColor
                }

                onClicked: {
                    stack.push("BluetoothMenu.qml") // Push files as QML wraps files as components
                }
            }
        }
    }
}

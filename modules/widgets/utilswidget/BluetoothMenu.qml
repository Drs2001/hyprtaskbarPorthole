import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Bluetooth
import qs.singletons

Item {
    implicitHeight: 400
    ColumnLayout {
        Flow{
            width: parent.width
            Button {
                id: backButton
                implicitHeight: 40
                implicitWidth: 40

                contentItem: Text{
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "\uf060"
                    color: "white"
                }

                background: Rectangle{
                    radius: 4
                    color: backButton.hovered ? Themes.hoverColor : "transparent"
                }

                onClicked: {
                    stack.pop()
                    
                }
            }
        }
        Flow {
            width: parent.width
            Button {
                id: bluetooth
                implicitHeight: 40
                implicitWidth: 80

                contentItem: Text{
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "TEST"
                    color: "white"
                }

                background: Rectangle{
                    radius: 4
                    color: bluetooth.hovered ? Themes.hoverColor : "gray"
                }

                onClicked: {
                    // stack.pop()
                    var adapter = Bluetooth.defaultAdapter
                    console.log(adapter.devices.values[1].deviceName)
                    // adapter.devices.values[1].connect()
                    
                }
            }
        }
    }
}

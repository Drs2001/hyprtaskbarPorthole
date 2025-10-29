import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import qs.singletons

Item {
    implicitHeight: 400
    ColumnLayout {
        implicitWidth: parent.width
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
        Repeater {
            implicitWidth: parent.width

            model: BluetoothManager.getDevices()
            delegate: BTDeviceButton{
                required property var modelData
                device: modelData
                implicitWidth: parent.width
            }
        }
    }
}

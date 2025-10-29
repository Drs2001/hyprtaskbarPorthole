import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import qs.singletons

Item {
    implicitHeight: 400

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Flow{
            Layout.fillWidth: true
            
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
            Button {
                id: refreshButton
                implicitHeight: 40
                implicitWidth: 40

                contentItem: Text{
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "\udb81\udc50"
                    color: "white"
                }

                background: Rectangle{
                    radius: 4
                    color: refreshButton.hovered ? Themes.hoverColor : "transparent"
                }

                onClicked: {
                    BluetoothManager.startDiscovery()
                }
            }
        }

        ScrollView {
            id: scroll
            Layout.fillWidth: true
            Layout.fillHeight: true

            contentWidth: availableWidth
            ColumnLayout {
                width: parent.width
                spacing: 8

                Text {
                    text: "Paired Devices"
                    color: "white"
                    font.bold: true
                    Layout.fillWidth: true
                }
                Repeater {
                    model: BluetoothManager.connectedDevices
                    delegate: BTDeviceButton{
                        required property var modelData
                        device: modelData
                        Layout.fillWidth: true
                    }
                }
                Repeater {
                    model: BluetoothManager.pairedDevices
                    delegate: BTDeviceButton{
                        required property var modelData
                        device: modelData
                        Layout.fillWidth: true
                    }
                }

                Text {
                    text: "Avaliable Devices"
                    color: "white"
                    font.bold: true
                    Layout.fillWidth: true
                }

                Repeater {
                    model: BluetoothManager.avaliableDevices
                    delegate: BTDeviceButton{
                        required property var modelData
                        device: modelData
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
}

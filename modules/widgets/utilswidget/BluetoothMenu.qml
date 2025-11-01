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
                    color: Themes.textColor
                }

                background: Rectangle{
                    color: backButton.hovered ? Themes.hoverColor : "transparent"
                    border.color: backButton.hovered ? Themes.hoverShadow : "transparent"
                    radius: 6
                }

                onClicked: {
                    stack.pop()
                    
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
                    color: Themes.textColor
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
                    color: Themes.textColor
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
        Flow{
            Layout.fillWidth: true
            layoutDirection: Qt.RightToLeft
            Button {
                id: refreshButton
                implicitHeight: 40
                implicitWidth: 40

                contentItem: Text{
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "\udb81\udc50"
                    color: Themes.textColor
                }

                background: Rectangle{
                    color: refreshButton.hovered ? Themes.hoverColor : "transparent"
                    border.color: refreshButton.hovered ? Themes.hoverShadow : "transparent"
                    radius: 6
                }

                onClicked: {
                    BluetoothManager.startDiscovery()
                }
            }
        }
    }
}

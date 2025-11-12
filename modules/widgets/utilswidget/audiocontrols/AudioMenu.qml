import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import qs.singletons

Item {
    required property var stack
    implicitHeight: 400

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        RowLayout{
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
                    color: backButton.hovered ? Themes.primaryHoverColor : "transparent"
                    border.color: backButton.hovered ? Themes.primaryHoverShadow : "transparent"
                    radius: 6
                }

                onClicked: {
                    stack.pop()
                    
                }
            }
            Text{
                text: "Sound Output"
                color: Themes.textColor
                font.pixelSize: 14
                verticalAlignment: Text.AlignVCenter
            }

        }

        ScrollView {
            id: scroll
            visible: BluetoothManager.adapter.enabled
            Layout.fillWidth: true
            Layout.fillHeight: true

            contentWidth: availableWidth
            ColumnLayout {
                width: parent.width
                spacing: 8

                Text {
                    text: "Output Devices"
                    color: Themes.textColor
                    font.bold: true
                    Layout.fillWidth: true
                }
                Repeater {
                    model: AudioManager.sinks
                    delegate: Button{
                        required property var modelData
                        Layout.fillWidth: true
                        text: modelData.description

                        contentItem: Text {
                            text: modelData.description
                            color: Themes.textColor
                            horizontalAlignment: Text.AlignLeft
                            elide: Text.ElideRight 
                        }

                        background: Rectangle{
                            color: (modelData.id == AudioManager.sink.id) ? Themes.primaryHoverColor : "transparent"
                            radius: 8
                        }

                        onClicked: {
                            AudioManager.setDefaultSink(modelData)
                        }
                    }
                }
                Text {
                    text: "Volume Mixer"
                    color: Themes.textColor
                    font.bold: true
                    Layout.fillWidth: true
                }
                Repeater {
                    model: AudioManager.outputPrograms
                    delegate: RowLayout{
                        required property var modelData
                        Layout.fillWidth: true

                        Button{
                            Layout.preferredWidth: 32
                            Layout.preferredHeight: 32
                            background: Rectangle{
                                color: "transparent"
                            }
                            contentItem: Image {
                                fillMode: Image.PreserveAspectFit
                                source: Quickshell.iconPath(modelData.properties["application.icon-name"] || "application-menu", true)
                            }
                        }
                        Slider {
                            id: control
                            from: 0
                            value: modelData.audio.volume
                            to: 1.5
                            stepSize: 0.01

                            background: Rectangle {
                                x: control.leftPadding
                                y: control.topPadding + control.availableHeight / 2 - height / 2
                                implicitWidth: 200
                                implicitHeight: 4
                                width: control.availableWidth
                                height: implicitHeight
                                radius: 2
                                color: "#bdbebf"

                                Rectangle {
                                    width: control.visualPosition * parent.width
                                    height: parent.height
                                    color: Themes.accentColor
                                    radius: 2
                                }
                            }

                            handle: Rectangle {
                                x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
                                y: control.topPadding + control.availableHeight / 2 - height / 2
                                implicitWidth: 20
                                implicitHeight: 20
                                radius: 13
                                color: control.pressed ? "#f0f0f0" : "#f6f6f6"
                                border.color: "#bdbebf"
                            }

                            onMoved: {
                                modelData.audio.volume = control.value
                            }
                        }

                    } 
                }
            }
        }
    }
}

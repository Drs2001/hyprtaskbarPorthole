import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.modules.widgets.utilswidget.bluetooth
import qs.modules.widgets.utilswidget.audiocontrols
import qs.singletons

Item {
    id: rootMenu
    implicitHeight: 400
    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        Flow {
            id: trayIconsFlow
            Layout.fillWidth: true
            Layout.preferredHeight: (parent.height - bottomBar.height) / 2
            Layout.leftMargin: 15
            Layout.topMargin: 20
            spacing: 10
            
            // Bluetooth Button
            BTMenuButton{
                stack: rootStack
            }
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: '#585858'
        }

        ColumnLayout{
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: rootMenu.height - trayIconsFlow.height - bottomBar.height
            RowLayout{
                spacing: 20
                Text {
                    text: AudioManager.volumeIcon
                    font.family: "Symbols Nerd Font"
                    font.pixelSize: 16
                    color: Themes.textColor
                }
                Slider {
                    id: control
                    from: 0
                    value: AudioManager.volumeLevel
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
                        AudioManager.setVolume(control.value)
                    }
                }
                // Bluetooth Button
                AudioMenuButton{
                    stack: rootStack
                }
            }
        }

        Rectangle {
            id: bottomBar
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            color: Themes.primaryColor
            bottomLeftRadius: 10
            bottomRightRadius: 10
        }

    }
    
}

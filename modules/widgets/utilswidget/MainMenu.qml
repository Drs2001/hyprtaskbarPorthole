import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.modules.widgets.utilswidget.bluetooth
import qs.modules.widgets.utilswidget.audiocontrols
import qs.singletons

Item {
    id: rootMenu
    implicitHeight: 300
    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        Flow {
            id: trayIconsFlow
            Layout.fillWidth: true
            Layout.preferredHeight: rootMenu.height * 0.55
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
            Layout.preferredHeight: rootMenu.height * 0.30
            RowLayout{
                spacing: 20
                Button {
                    id: audioToggle
                    background: Rectangle {
                        implicitHeight: 32
                        implicitWidth: 32
                        color: audioToggle.hovered ? Themes.primaryHoverColor : "transparent"
                        radius: 5
                    }
                    contentItem: Text {
                        text: AudioManager.volumeIcon
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Symbols Nerd Font"
                        font.pixelSize: 16
                        color: Themes.textColor
                    }

                    onClicked: {
                        AudioManager.toggleSinkMute()
                    }
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

                        Popup {
                            id: handlePopup
                            popupType: Popup.Item
                            y: -height - 10
                            x: (parent.width - width) / 2
                            visible: hoverHandler.hovered || control.pressed
                            closePolicy: Popup.NoAutoClose

                            background: Rectangle {
                                implicitWidth: 40
                                implicitHeight: 20
                                color: Themes.primaryColor
                                radius: 5
                            }

                            contentItem: Text {
                                horizontalAlignment: Text.AlignHCenter
                                text: Math.round(AudioManager.volumeLevel * 100)
                                color: Themes.textColor
                            }
                        }

                        HoverHandler {
                            id: hoverHandler
                        }
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
            Layout.preferredHeight: rootMenu.height * 0.15
            color: Themes.primaryColor
            bottomLeftRadius: 10
            bottomRightRadius: 10
        }

    }
    
}

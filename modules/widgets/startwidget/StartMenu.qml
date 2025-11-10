import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import qs.singletons

Item {
    implicitHeight: 500

    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        
        Text {
            text: "All apps"
            color: Themes.textColor
            font.bold: true
            Layout.fillWidth: true
            Layout.leftMargin: 15
            Layout.bottomMargin: 15
            Layout.topMargin: 15
        }

        ScrollView {
            id: scroll
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: 15
            Layout.rightMargin: 15

            contentWidth: availableWidth

            ColumnLayout {
                width: parent.width

                Repeater {
                    model: ApplicationsManager.entries
                    delegate: ColumnLayout {
                        required property var modelData
                        required property int index
                        spacing: 5
                        Layout.fillWidth: true
                        Text {
                            visible: index === 0 || 
                                    modelData.name.charAt(0).toUpperCase() !== 
                                    ApplicationsManager.entries[index - 1].name.charAt(0).toUpperCase()
                            text: modelData.name.charAt(0).toUpperCase()
                            color: Themes.textColor
                            font.pixelSize: 16
                            Layout.fillWidth: true
                        }
                        ApplicationButton{
                            application: modelData
                            Layout.fillWidth: true
                        }
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            color: Themes.backgroundColor
            bottomLeftRadius: 10
            bottomRightRadius: 10

            RowLayout {
                anchors.fill: parent
                Item {
                    Layout.fillWidth: true
                }
                Button{
                    id: powerMenuButton

                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    Layout.rightMargin: 15
                    Layout.alignment: Qt.AlignVCenter

                    contentItem: Text{
                        text: "\u23fb"
                        color: Themes.textColor
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 32
                    }
                    background: Rectangle {
                        color: powerMenuButton.hovered ? Themes.hoverColor : "transparent"
                        radius: 6
                    }

                    onClicked: {
                        powerPopup.open()
                    }

                    PowerMenu {
                        id: powerPopup
                        x: -((powerPopup.width/2) - (powerMenuButton.width/2))
                    }
                }
            }
        }
        
    }
}

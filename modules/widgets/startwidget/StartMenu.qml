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
        ScrollView {
            id: scroll
            Layout.fillWidth: true
            Layout.fillHeight: true

            contentWidth: availableWidth

            ColumnLayout {
                width: parent.width
                spacing: 8

                Text {
                    text: "Applications"
                    color: Themes.textColor
                    font.bold: true
                    Layout.fillWidth: true
                }
                Repeater {
                    model: ApplicationsManager.entries
                    delegate: ApplicationButton{
                        required property var modelData
                        application: modelData
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
}

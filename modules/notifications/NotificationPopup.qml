import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import qs.singletons

PanelWindow {
    id: notiPopup
    required property var modelData

    screen: root.modelData
    visible: true
    color: "transparent"

    anchors {
        bottom: true
        right: true
    }
    
    implicitHeight: contentRect.implicitHeight
    implicitWidth: 300
    
    margins {
        bottom: 20
        right: 20
    }

    Rectangle{
        id: contentRect
        anchors.fill: parent
        color: Themes.primaryColor
        radius: 10

        implicitHeight: bodyColumn.implicitHeight

         ColumnLayout{
            id: bodyColumn
            anchors.fill: parent
            anchors.margins: 0

            RowLayout{
                id: topRow
                Layout.fillWidth: true
                Layout.preferredHeight: 34
                Layout.leftMargin: 5
                Layout.topMargin: 5
                Layout.rightMargin: 5
                spacing: 8
                Image{
                    Layout.preferredHeight: 24
                    Layout.preferredWidth: 24
                    source: Quickshell.iconPath(modelData.icon, true)
                    fillMode: Image.PreserveAspectFit
                }
                Text {
                    text: modelData.appName
                    color: Themes.textColor
                }
                // Spacer
                Item{
                    Layout.fillWidth: true
                }
                Button{
                    id: closeNoti
                    implicitWidth: 16
                    implicitHeight: 16

                    background: Rectangle {
                        color: closeNoti.hovered ? "red" : "transparent"
                        radius: 2
                    }
                    
                    contentItem: Text {
                        text: "X"
                        color: Themes.textColor
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: {
                        NotificationManager.updateVisibleNotification()
                    }
                }
            }
            RowLayout{
                Layout.fillWidth: true
                Layout.margins: 10
                spacing: 8
                Image {
                    visible: modelData.image != ""
                    Layout.preferredHeight: 48
                    Layout.preferredWidth: 48
                    source: modelData.image
                    fillMode: Image.PreserveAspectFit
                }
                Text {
                    Layout.fillWidth: true
                    text: modelData.body
                    color: Themes.textColor
                    wrapMode: Text.WordWrap
                }
            }
        }
    }

        Timer {
        id: dismissTimer
        interval: 5000
        onTriggered: {
            NotificationManager.updateVisibleNotification()
        }
    }

    Component.onCompleted: {
        dismissTimer.start()
    }
}
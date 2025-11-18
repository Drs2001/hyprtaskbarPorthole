import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import qs.singletons

PanelWindow {
    required property var modelData

    color: "red"
    screen: root.modelData
    visible: true

    anchors {
        top: true
        right: true
    }
    
    implicitHeight: 50
    implicitWidth: 200
    
    margins {
        top: 20
        right: 20
    }

    Button{
        text: "CLICK ME"
        onClicked: {
            NotificationManager.removeNotification(modelData.id)
        }
    }

        Timer {
        id: dismissTimer
        interval: 5000
        onTriggered: {
            NotificationManager.removeNotification(modelData.id)
        }
    }

    Component.onCompleted: {
        dismissTimer.start()
    }
}
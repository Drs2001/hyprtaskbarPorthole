// Bar.qml
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.modules.widgets
import qs.singletons

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      WlrLayershell.namespace: "qsBar"

      color: Themes.backgroundColor

      anchors {
        bottom: true
        left: true
        right: true
      }

      implicitHeight: 50
      margins {
        top: 0
        left: 0
        right: 0
      }

      // Thin border seperator line
      Rectangle {
        anchors {
          top: parent.top
          left: parent.left
          right: parent.right
        }
        height: 1 
        color: '#585858'
      }

      Item {
        anchors.fill: parent
        ClockWidget {
          anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            rightMargin: 10
          }
        }

        StartButton {
          anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            leftMargin: 5
          }
        }
      }
    }
  }
}
import QtQuick
import QtQuick.Controls
import Quickshell
import qs.singletons

Button {
    id: root

    required property var popupWindow 
    property bool menuOpen: false

    implicitWidth: 32
    implicitHeight: 32

    contentItem: Text {
        id: arrowIcon
        text: "⌃"
        font.pixelSize: 28
        color: Themes.textColor
        rotation: menuOpen ? 180 : 0
        horizontalAlignment: Text.AlignHCenter
        
        Behavior on rotation {
            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
        }
    }

    background: Rectangle {
        implicitWidth: 32
        implicitHeight: 32
        color: root.hovered ? Themes.hoverColor : "transparent"
        border.color: root.hovered ? Qt.lighter(Themes.hoverColor, 1.2) : "transparent"
        radius: 6
    }

    onClicked: {
        menuOpen = !menuOpen
        popupWindow.visible = menuOpen
    }

    Connections {
        target: popupWindow
        function onVisibleChanged() {
            if (!popupWindow.visible) {
                menuOpen = false
            }
        }
    }
}
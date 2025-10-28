import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import Quickshell
import qs.singletons

Popup {
    id: popup
    popupType: Popup.Window

    width: 300
    height: stack.currentItem.implicitHeight

    y: -height - 20

    background: Rectangle {
        id: trayBackground
        color: Themes.backgroundColor
        border.color: Themes.hoverColor
        border.width: 1.5
        radius: 10
    }

    StackView {
        id: stack
        initialItem: "MainMenu.qml" // We initialize with the file directly as QML automatically wraps seperate files as components
        anchors.fill: parent
    }

    // Check if the stack has more than the main menu view on it and if so reset it to display the main menu
    onOpened: {
        if(stack.depth > 1){
            stack.pop(null, StackView.Immediate)
        }
    }

    onClosed: {
        menuOpen = false
    }
}
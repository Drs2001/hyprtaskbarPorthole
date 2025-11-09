import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import Quickshell
import qs.singletons

Popup {
    id: popup
    popupType: Popup.Window
    padding: 0

    width: 600
    height: stack.currentItem.implicitHeight

    y: -height - 20

    background: Rectangle {
        id: trayBackground
        color: Themes.hoverColor
        radius: 10
    }

    StackView {
        id: stack
        initialItem: "StartMenu.qml" // We initialize with the file directly as QML automatically wraps seperate files as components
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
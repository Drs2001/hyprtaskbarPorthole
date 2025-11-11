import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import Quickshell
import qs.singletons

Popup {
    id: popup
    popupType: Popup.Window
    padding: 0

    width: 320
    height: rootStack.currentItem.implicitHeight

    y: -height - 20

    background: Rectangle {
        id: trayBackground
        color: Themes.popupBackgroundColor
        border.color: Themes.primaryHoverShadow
        border.width: 1
        radius: 10
    }

    StackView {
        id: rootStack
        initialItem: "MainMenu.qml" // We initialize with the file directly as QML automatically wraps seperate files as components
        anchors.fill: parent
    }

    // Check if the stack has more than the main menu view on it and if so reset it to display the main menu
    onOpened: {
        if(rootStack.depth > 1){
            rootStack.pop(null, StackView.Immediate)
        }
    }

    onClosed: {
        menuOpen = false
    }
}
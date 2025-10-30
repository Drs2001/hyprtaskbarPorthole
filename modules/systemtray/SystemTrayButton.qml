import QtQuick
import QtQuick.Controls
import Quickshell
import qs.singletons

Button {
    id: root
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
        border.color: root.hovered ? Themes.hoverShadow : "transparent"
        radius: 6
    }

    onClicked: {
        if(menuOpen){
            trayPopup.close()
        }
        else{
            trayPopup.open()
        }
        menuOpen = !menuOpen
    }

    SystemTrayPopup{
        id: trayPopup
    }
}
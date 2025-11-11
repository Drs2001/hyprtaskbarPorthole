import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import qs.singletons

Button {
    id: root
    property bool menuOpen: false

    implicitHeight: 32

    contentItem: RowLayout{
        NetworkIcon{
            id: networkIcon
            Layout.alignment: Qt.AlignHCenter
        }
        Text {
            id: volumeIcon
            Layout.alignment: Qt.AlignHCenter
            text: AudioManager.volumeIcon
            font.family: "Symbols Nerd Font"
            font.pixelSize: 16
            color: Themes.textColor
        }
    }

    background: Rectangle {
        implicitWidth: 50
        color: root.hovered ? Themes.primaryHoverColor : "transparent"
        border.color: root.hovered ? Themes.primaryHoverShadow : "transparent"
        radius: 6
    }

    onClicked: {
        if(menuOpen){
            popup.close()
        }
        else{
            popup.open()
        }
        menuOpen = !menuOpen
    }

    UtilsPopup{
        id: popup
    }
}
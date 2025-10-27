import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import qs.singletons

Item {
    id: root

    required property SystemTrayItem modelData
    required property var barPopup

    implicitWidth: 25
    implicitHeight: 25

    Popup {
        id: trayMenuPopup
        // y: root.y + root.height + 8
        contentWidth: 304
        contentHeight: idMenu.contentHeight - 8
        modal: true
        focus: true
        popupType: Popup.Window

        background: Rectangle {
            color: Themes.backgroundColor
            radius: 8
        }

        contentItem: TrayItemMenu {
            id: idMenu
            rootMenu: QsMenuOpener { menu: modelData.menu }
            trayMenu: QsMenuOpener { menu: modelData.menu }
        }

        onClosed: {
            idMenu.trayMenu = idMenu.rootMenu
        }

        // Component.onCompleted: {
        //     if (barPopup && !barPopup.trayMenus.includes(trayMenuPopup))
        //         barPopup.trayMenus.push(trayMenuPopup);
        // }

        // Component.onDestruction: {
        //     if (barPopup)
        //         barPopup.trayMenus = barPopup.trayMenus.filter(p => p !== trayMenuPopup);
        // }
    }


    Rectangle {
        anchors.fill: parent
        color: mouse.hovered ? Themes.hoverColor : "transparent"
        radius: 5

        HoverHandler {
            id:mouse
        }

        IconImage {
            id: icon
            anchors.fill: parent
            anchors.margins: 4
            asynchronous: true
            source: {
                let icon = root.modelData.icon;
                if (icon.includes("?path=")) {
                    const [name, path] = icon.split("?path=");
                    icon = `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
                }
                return icon;
            }
        }

        MouseArea {
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            anchors.fill: parent

            onClicked: event => {
                if (event.button === Qt.LeftButton) {
                    modelData.activate();
                } else if (event.button === Qt.RightButton) {
                    idMenu.trayMenu.menu = root.modelData.menu
                    trayMenuPopup.open();
                }
            }
        }
        
    }
}
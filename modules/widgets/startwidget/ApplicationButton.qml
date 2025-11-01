import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.singletons

Item {
    required property var application
    implicitHeight: button.implicitHeight  
    implicitWidth: button.implicitWidth    
    
    Button {
        id: button
        width: parent.width

        contentItem: Row{
            spacing: 8

            // Temporary solution for displaying icons, doesnt fully work and some icons look pixelated
            Image {
                source: Quickshell.iconPath(application.icon, true)
                height: 24
                width: 24
            }
            Text{
                text: application.name
                color: Themes.textColor
            }
        }

        background: Rectangle{
            color: button.hovered ? Themes.hoverColor : "transparent"
            border.color: button.hovered ? Themes.hoverShadow : "transparent"
            radius: 6
        }

        onClicked: {
            application.execute()
            popup.close()
        }
    }
}
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.singletons

Popup {
    popupType: Popup.Window
    y: -height - 10
    
    background: Rectangle {
        color: Themes.backgroundColor
        border.color: Themes.hoverColor
        border.width: 1.5
        radius: 10
    }

    // MouseArea {
    //     anchors.fill: parent

    //     onClicked: {
    //         console.log("Test")
    //     }
    // }
    
    contentItem: RowLayout{
        ColumnLayout{
            Layout.preferredWidth: 200
            
            RowLayout{
                Layout.fillWidth: true
                Text{
                    text: window[0].window.title
                    color: Themes.textColor
                    font.pixelSize: 12
                    elide: Text.ElideRight 
                    clip: true
                    Layout.fillWidth: true
                }
                Button{
                    implicitHeight: 24
                    implicitWidth: 24
                    text: "X"
                    Layout.alignment: Qt.AlignRight
                    onClicked:{
                        console.log(window)
                    }
                }
            }
            ScreencopyView {
                Layout.preferredWidth: 200
                constraintSize: Qt.size(200, 200)
                captureSource: window[0].window.wayland
                live: true
            }
        }
    }
}
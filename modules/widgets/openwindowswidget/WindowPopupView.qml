import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.singletons

PopupWindow {
    anchor.item: button
    anchor.rect.y: -height - 20
    implicitHeight: backgroundRec.height
    implicitWidth: backgroundRec.width
    color: "transparent"

    // These propertys handle hovering different elements in our popup window
    //(NOTE: Probably a better way to do this but it's 1am and works so. Will come back to and refactor later.)
    property bool closeButtonHovered: false
    property bool singleWindowHovered: false

    // Whether to open the window or not
    property bool shouldShow: {
        const hoverConditions = (button.hovered || closeButtonHovered || singleWindowHovered)
        return hoverConditions
    }

    onShouldShowChanged: {
        updateTimer.restart()
    }

    // Timer to control updating the popup visibility after changing should show(Can change the time interval according to needs)
    Timer {
        id: updateTimer
        interval: 100
        onTriggered: {
            popup.visible = popup.shouldShow
        }
    }
    
    // Popup window background
    Rectangle{
        id: backgroundRec
        implicitHeight: previewRowLayout.implicitHeight
        implicitWidth: previewRowLayout.implicitWidth 
        color: Themes.backgroundColor
        radius: 12

        // Row layout to hold all the windows associated with the application
        RowLayout{
            id: previewRowLayout
            anchors.centerIn: parent
            spacing: 10

            // Display all open windows in the popup
             Repeater {
                model: windows
                delegate: Rectangle{
                    id: delegateRoot
                    required property var modelData
                    property var padding: 15
                    property var isHovered: false
                    implicitWidth: columnLayout.implicitWidth + padding
                    implicitHeight: columnLayout.implicitHeight + padding
                    radius: 12
                    color: isHovered ? Themes.hoverColor : Themes.backgroundColor

                    ColumnLayout{
                        id: columnLayout
                        anchors.centerIn: parent
                        implicitWidth: screenCopyView.width

                        RowLayout{
                            Text{
                                text: modelData.window.title
                                color: Themes.textColor
                                font.pixelSize: 12
                                elide: Text.ElideRight 
                                clip: true
                                Layout.fillWidth: true
                            }
                            Button{
                                id: closeWindowButton
                                implicitHeight: 20
                                implicitWidth: 20
                                background: Rectangle {
                                    color: closeWindowButton.hovered ? "red" : "transparent"
                                    radius: 5
                                }
                                contentItem: Text{
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    text: "X"
                                    color: Themes.textColor
                                }
                                Layout.alignment: Qt.AlignRight
                                onClicked:{
                                    modelData.window.wayland.close()
                                }

                                // Need this to make sure the window stays open even if we hover the child button
                                onHoveredChanged: {
                                    if(closeWindowButton.hovered){
                                        closeButtonHovered = true
                                    }
                                    else{
                                        closeButtonHovered = false
                                    }
                                }
                            }
                        }
                        WindowPreview {
                            id: screenCopyView
                            waylandWindow: modelData.window.wayland
                        }
                    }
                    MouseArea {
                        id: singleWindowArea
                        anchors.fill: parent
                        hoverEnabled: true
                        z: -1
                        
                        onClicked: {
                            if(modelData.minimized){
                                 var workspaceId = Hyprland.focusedWorkspace.id

                                // We fullscreen temporarily here to fix a weird bug with hyprland where swapping workspaces while another window is fullscreend cause the sub window to turn invisible
                                // Recreate -> open two windows in the same workspace, fullscreen one to hide the other then change the workspace of the hidden window and it will turn invisible. 
                                // Toggling fullscreen forces a redraw because hyprland doesnt have a redraw command exposed.
                                // (May be fixed in future hyprland releases will check back on this)
                                modelData.window.wayland.fullscreen = true
                                modelData.window.wayland.fullscreen = false
                                //*****************************************************************************/

                                Hyprland.dispatch("movetoworkspacesilent " + workspaceId + ", address:0x" + modelData.window.address);
                                modelData.minimized = false
                                modelData.window.wayland.activate()
                            }
                            else{
                                // Wont move mouse cursor and focus if window is already focused by hyprland
                                modelData.window.wayland.activate()
                                singleWindowHovered = false
                            }
                        }

                        onContainsMouseChanged: {
                            if(singleWindowArea.containsMouse){
                                singleWindowHovered = true
                                isHovered = true
                            }
                            else{
                                singleWindowHovered = false
                                isHovered = false
                            }
                        }
                    }
                }
            }
        }
    }
}
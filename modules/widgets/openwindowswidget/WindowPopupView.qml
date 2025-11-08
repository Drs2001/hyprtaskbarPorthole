import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland
import qs.singletons

PopupWindow {
    anchor.item: button
    anchor.rect.y: -height - 20
    implicitHeight: backgroundRec.height
    implicitWidth: backgroundRec.width
    color: "transparent"

    property bool anyChildButtonHovered: false // Handles any child buttons we may want to hover

    // Whether to open the window or not
    property bool shouldShow: {
        const hoverConditions = (popupMouseArea.containsMouse || button.hovered || anyChildButtonHovered)
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

    // Mouse area covering the entire popupwindow
    MouseArea {
        id: popupMouseArea
        anchors.bottom: parent.bottom
        implicitWidth: popup.implicitWidth
        implicitHeight: popup.implicitHeight
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
        propagateComposedEvents: true
        z: -1
    }
    
    // Popup window background
    Rectangle{
        id: backgroundRec
        property var padding: 15
        implicitHeight: previewRowLayout.implicitHeight + padding
        implicitWidth: previewRowLayout.width + padding
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
                delegate: ColumnLayout{
                    required property var modelData
                    Layout.preferredWidth: screenCopyView.width

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
                                    anyChildButtonHovered = closeWindowButton.hovered
                                }
                                else{
                                    anyChildButtonHovered = closeWindowButton.hovered
                                }
                            }
                        }
                    }
                    WindowPreview {
                        id: screenCopyView
                        waylandWindow: modelData.window.wayland
                    }
                }
            }
        }
    }
}
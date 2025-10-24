// SystemTrayPopup.qml
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.SystemTray
import qs.singletons

PopupWindow {
    id: popup
    
    required property var barWindow
    required property var trayButton
    
    color: "transparent"
    visible: false
    
    implicitWidth: 200
    implicitHeight: 200

     // Calculate position when visibility changes
    onVisibleChanged: {
        if (visible) {
            updatePosition()
        }
    }
    
    function updatePosition() {
        // Map tray button position to window coordinates
        var buttonPos = trayButton.mapToItem(barWindow.contentItem, 0, 0)
        anchor.rect.x = buttonPos.x -100
        anchor.rect.y = -height - 8
    }
    
    // Position above the tray button
    anchor.window: barWindow
    anchor.rect {
        x: 0
        y: -height - 8  // 8px gap above the bar
    }
    anchor.adjustment: PopupAdjustment.None
    
    Rectangle {
        anchors.fill: parent
        color: Themes.backgroundColor || "#2b2b2b"
        radius: 8
        border.color: Themes.borderColor || "#3b3b3b"
        border.width: 1
        
        Column {
            anchors.fill: parent
            anchors.margins: 8
            spacing: 4
        
            Flow {
                id: trayIconsFlow
                width: parent.width
                spacing: 8
                padding: 8
                
                Repeater {
                    model: SystemTray.items
                    
                    Rectangle {
                        width: 24
                        height: 24
                        radius: 6
                        color: trayMouseArea.containsMouse ? Themes.hoverColor : "transparent"
                        
                        Image {
                            anchors.centerIn: parent
                            width: 16
                            height: 16
                            source: modelData.icon
                            fillMode: Image.PreserveAspectFit
                        }
                        
                        MouseArea {
                            id: trayMouseArea
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            anchors.fill: parent
                            hoverEnabled: true
                            onPressed: function(mouse) {
                                if(mouse.button === Qt.LeftButton){
                                    modelData.activate()
                                }
                                else if (mouse.button === Qt.RightButton) {
                                    if(modelData.hasMenu){
                                        modelData.display(popup, mouse.x, mouse.y)
                                    }
                                }
                            }
                        }
                        
                        Behavior on color {
                            ColorAnimation { duration: 150 }
                        }
                    }
                }
            }
            
        }
    }
}
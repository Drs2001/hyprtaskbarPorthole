// SystemTrayPopup.qml
import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.singletons

PopupWindow {
    id: popup
    
    required property var barWindow
    required property var trayButton
    
    color: "transparent"
    visible: false
    
    implicitWidth: 200
    implicitHeight: 400

    // WlrLayershell.namespace: "qsBarPopup"  // Unique namespace for blur rules

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
    // anchor.gravity: Edges.Top | Edges.HCenter
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
            
            Text {
                text: "System Tray"
                font.bold: true
                font.pixelSize: 14
                color: Themes.textColor || "#ffffff"
                padding: 8
            }
            
            Rectangle {
                width: parent.width
                height: 1
                color: Themes.borderColor || "#3b3b3b"
            }
            
            Flickable {
                width: parent.width
                height: parent.height - 40
                contentHeight: trayIconsFlow.height
                clip: true
                
                Flow {
                    id: trayIconsFlow
                    width: parent.width
                    spacing: 8
                    padding: 8
                    
                    Repeater {
                        model: ["🔊", "🔋", "📶", "⚙️", "📋", "🔔"]
                        
                        Rectangle {
                            width: 48
                            height: 48
                            radius: 6
                            color: trayMouseArea.containsMouse ? Themes.hoverColor : "transparent"
                            
                            Text {
                                anchors.centerIn: parent
                                text: modelData
                                font.pixelSize: 24
                            }
                            
                            MouseArea {
                                id: trayMouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    console.log("Tray item clicked:", modelData)
                                    popup.visible = false
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
}
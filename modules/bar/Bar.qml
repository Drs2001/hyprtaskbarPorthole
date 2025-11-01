// Bar.qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.modules.widgets
import qs.modules.widgets.startwidget
import qs.modules.widgets.utilswidget
import qs.modules.systemtray
import qs.singletons

Scope {
    Variants {
        model: Quickshell.screens
        
        PanelWindow {
            id: root
            required property var modelData
            screen: modelData
            
            WlrLayershell.namespace: "qsBar"
            color: Themes.backgroundColor
            
            anchors {
                bottom: true
                left: true
                right: true
            }
            
            implicitHeight: 50
            
            margins {
                top: 0
                left: 0
                right: 0
            }
            
            // Thin border seperator line
            Rectangle {
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                height: 1
                color: '#585858'
            }
            
            // Main horizontal layout for the taskbar
            RowLayout {
                anchors.fill: parent
                
                StartButton {
                    Layout.leftMargin: 5
                }
                
                Item { Layout.fillWidth: true } // spacer
                
                WrapperItem {
                    rightMargin: 10
                    
                    RowLayout {
                        SystemTrayButton{
                            id: trayButton
                        }
                        UtilsWidget{}
                        ClockWidget {}
                    }
                }
            }
        }
    }
}
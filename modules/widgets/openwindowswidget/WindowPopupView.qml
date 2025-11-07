import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import qs.singletons

PopupWindow {
    anchor.item: button
    anchor.rect.y: -height - 20
    implicitHeight: backgroundRec.height
    implicitWidth: backgroundRec.width
    
    Rectangle{
        id: backgroundRec
        property var padding: 10
        implicitHeight: previewRowLayout.implicitHeight + padding
        implicitWidth: previewRowLayout.width + padding
        color: Themes.backgroundColor

        RowLayout{
            id: previewRowLayout
            anchors.centerIn: parent
            spacing: 10

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
                            implicitHeight: 24
                            implicitWidth: 24
                            text: "X"
                            Layout.alignment: Qt.AlignRight
                            onClicked:{

                            }
                        }
                    }
                    ScreencopyView {
                        id: screenCopyView
                        constraintSize: Qt.size(200, 100) // declared as (width, height)
                        captureSource: modelData.window.wayland
                        live: true
                    }
                }
            }
        }
    }
}
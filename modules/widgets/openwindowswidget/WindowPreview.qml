import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland
import qs.singletons

Item {
    required property var waylandWindow
    implicitWidth: screenCopyView.width
    implicitHeight: screenCopyView.height
    
    ScreencopyView {
        id: screenCopyView
        constraintSize: Qt.size(200, 100) // declared as (width, height)
        captureSource: waylandWindow
        live: true
        visible: false // Hide it so only the multi-effect version renders
    }

    Rectangle {
        id: screenCopyMask
        layer.enabled: true
        width: screenCopyView.width
        height: screenCopyView.height
        radius: 5
        visible: false // Hide the mask so only the multi-effect is rendered
    }

    MultiEffect {
        source: screenCopyView
        anchors.fill: parent
        maskEnabled: true
        maskSource: screenCopyMask
    }
}
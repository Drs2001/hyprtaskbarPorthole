pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    // Theme mode toggle
    property bool isDark: true

    // Colors that change based on theme
    property color backgroundColor: isDark ? Qt.rgba(0.109, 0.109, 0.109, 1) : Qt.rgba(1, 1, 1, 0.8)
    property color textColor: isDark ? Qt.rgba(1, 1, 1) : Qt.rgba(0, 0, 0)
    property color hoverColor: Qt.lighter(backgroundColor, 1.8)

    // Font Control
    property string textFont: "Inter"
}
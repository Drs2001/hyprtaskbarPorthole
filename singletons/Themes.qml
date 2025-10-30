pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    // Theme mode toggle
    property bool isDark: true

    // Colors that change based on theme
    property color backgroundColor: isDark ? Qt.rgba(0.110, 0.110, 0.110, 1.0) : Qt.rgba(0.933, 0.933, 0.933, 1.0)
    property color textColor: isDark ? Qt.rgba(1, 1, 1) : Qt.rgba(0, 0, 0)
    property color hoverColor: isDark ? Qt.lighter(backgroundColor, 1.464) : Qt.lighter(backgroundColor, 1.038)
    property color hoverShadow: isDark ? Qt.lighter(backgroundColor, 1.8) : Qt.darker(backgroundColor, 1.038)
    property color accentColor: Qt.rgba(0.149, 0.502, 0.569, 1.0)
    property color accentHover: isDark ? Qt.lighter(accentColor, 1.8) : Qt.darker(accentColor, 1.8)

    // Font Control
    property string textFont: "Inter"
}
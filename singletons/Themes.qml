pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    // Font Control
    property string textFont: "Inter"

    readonly property var themeNames: ["dark", "light"]

    property string currentTheme: "dark"

    readonly property var themes: ({
        "dark": {
            primaryColor: '#181818',
            primaryHoverColor: '#393939',
            primaryHoverShadow: "#303030",
            textColor: "#FFFFFF",
            accentColor: Qt.rgba(0.09, 0.72, 0.84),
            accentHover: Qt.lighter(Qt.rgba(0.09, 0.72, 0.84), 1.8),
            accentTextColor: "black",
            popupBackgroundColor: '#202020',
            utilButtonDisabled: '#2b2b2b',
            utilButtonBorder: '#7e7e7e'

        },
        "light": {
            primaryColor: Qt.rgba(0.933, 0.933, 0.933, 1.0),
            primaryHoverColor: Qt.lighter(Qt.rgba(0.933, 0.933, 0.933, 1.0), 1.038),
            primaryHoverShadow: Qt.darker(Qt.rgba(0.933, 0.933, 0.933, 1.0), 1.8),
            textColor: Qt.rgba(0, 0, 0),
            accentColor: Qt.rgba(0.09, 0.72, 0.84),
            accentHover: Qt.darker(Qt.rgba(0.09, 0.72, 0.84), 1.8),
            accentTextColor: "black",
            popupBackgroundColor: Qt.lighter(Qt.rgba(0.933, 0.933, 0.933, 1.0), 1.038),
            utilButtonDisabled: Qt.lighter(Qt.rgba(0.933, 0.933, 0.933, 1.0), 1.03),
            utilButtonBorder: "#3B3B3B"
        }
    })

    // Base colors
    // property color primaryColor: themes[currentTheme].primaryColor
    property color primaryColor: activePalette.window
    // property color primaryHoverColor: themes[currentTheme].primaryHoverColor
    property color primaryHoverColor: activePalette.highlight
    // property color primaryHoverShadow: themes[currentTheme].primaryHoverShadow
    property color primaryHoverShadow: activePalette.shadow
    // property color textColor: themes[currentTheme].textColor
    property color textColor: activePalette.text
    // property color accentColor: themes[currentTheme].accentColor
    property color accentColor: activePalette.accent
    // property color accentHover: themes[currentTheme].accentHover
    property color accentHover: Qt.lighter(activePalette.accent, 1.8)
    property color accentTextColor: themes[currentTheme].accentTextColor

    // property color popupBackgroundColor: themes[currentTheme].popupBackgroundColor
    property color popupBackgroundColor: activePalette.base

    // Utility menu pallet
    // property color utilButtonDisabled: themes[currentTheme].utilButtonDisabled
    property color utilButtonDisabled: disabledPalette.accent
    property color utilButtonBorder: themes[currentTheme].utilButtonBorder

    property SystemPalette activePalette: SystemPalette {
        colorGroup: SystemPalette.Active
    }

    property SystemPalette disabledPalette: SystemPalette {
        colorGroup: SystemPalette.Disabled
    }
}
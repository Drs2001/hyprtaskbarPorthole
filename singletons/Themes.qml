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
            primaryColor: "#1C1C1C",
            primaryHoverColor: "#292929",
            primaryHoverShadow: "#303030",
            textColor: "#FFFFFF",
            accentColor: Qt.rgba(0.09, 0.72, 0.84),
            accentHover: Qt.lighter(Qt.rgba(0.09, 0.72, 0.84), 1.8),
            accentTextColor: "black",
            popupBackgroundColor: "#242424",
            utilButtonDisabled: "#313131",
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
    property color primaryColor: themes[currentTheme].primaryColor
    property color primaryHoverColor: themes[currentTheme].primaryHoverColor
    property color primaryHoverShadow: themes[currentTheme].primaryHoverShadow
    property color textColor: themes[currentTheme].textColor
    property color accentColor: themes[currentTheme].accentColor
    property color accentHover: themes[currentTheme].accentHover
    property color accentTextColor: themes[currentTheme].accentTextColor

    property color popupBackgroundColor: themes[currentTheme].popupBackgroundColor

    // Utility menu pallet
    property color utilButtonDisabled: themes[currentTheme].utilButtonDisabled
    property color utilButtonBorder: themes[currentTheme].utilButtonBorder
}
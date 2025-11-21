import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.singletons

Button{
  id: batteryButton

  background: Rectangle {
    color: batteryButton.hovered ? Themes.primaryHoverColor : "transparent"
    radius: 5
  }
  contentItem: RowLayout {
    Text {
      text: PowerManager.batteryIcon
      color: Themes.textColor

      font.family: Themes.textFont
      font.pixelSize: 16
    }

    Text {
      text: PowerManager.batteryPercentage
      color: Themes.textColor
      
      font.family: Themes.textFont
      font.pixelSize: 12
    }
  }

  onClicked: {
  }
}

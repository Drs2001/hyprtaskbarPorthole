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

    Item {
      height: 16
      width: 16

      Text {
        text: PowerManager.batteryIcon
        color: Themes.textColor

        font.family: Themes.textFont
        font.pixelSize: 20
        anchors.centerIn: parent
      }

      Text{
        text: "\uf0e7"
        color: Themes.textColor

        font.family: Themes.textFont
        font.pixelSize: 14
        anchors.centerIn: parent
        visible: PowerManager.isCharging
      }
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

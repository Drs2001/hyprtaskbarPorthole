import QtQuick
import QtQuick.Controls
import qs.singletons

Button{
  id: clockButton
  property bool menuOpen: false

  background: Rectangle {
    color: clockButton.hovered ? Themes.primaryHoverColor : "transparent"
    radius: 5
  }
  contentItem: Column {
    Text {
      text: Time.time
      color: Themes.textColor
      anchors.right: parent.right 

      font.family: Themes.textFont
      font.pixelSize: 14
    }

    Text {
      text: Time.date
      color: Themes.textColor
      anchors.right: parent.right
      
      font.family: Themes.textFont
      font.pixelSize: 14
    }
  }

  onClicked: {
      if(menuOpen){
          popupLoader.item.visible = false
      }
      else{
          popupLoader.item.visible = true
      }
      menuOpen = !menuOpen
  }

  CalendarPopup {
    id: popupLoader
  }
}

import QtQuick
import qs.singletons

Column {
  Text {
    text: Time.time
    color: Themes.textColor
    anchors.right: parent.right 

    font.family: Themes.textFont
  }

  Text {
    text: Time.date
    color: Themes.textColor
    anchors.right: parent.right
    
    font.family: Themes.textFont
  }
}

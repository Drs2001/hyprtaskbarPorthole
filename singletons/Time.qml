pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  property string time
  property string date

  Process {
    id: timeProc
    command: ["sh", "-c", "date +'%-I:%M %p'"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: root.time = this.text
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: timeProc.running = true
  }

  Process {
    id: dateProc
    command: ["sh", "-c", "date +'%m/%d/%Y'"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: root.date = this.text
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: dateProc.running = true
  }
}
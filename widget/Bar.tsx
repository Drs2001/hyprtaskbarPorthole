import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import { execAsync } from "ags/process"
import { createPoll } from "ags/time"
import GLib from "gi://GLib"
import Systray from "./SysTray"

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const time = createPoll("", 1000, 'date "+%l:%M %p"')
  const date = createPoll("", 1000, 'date "+%m/%d/%Y"')
  const { BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor
  const ASSETS_PATH = `${GLib.get_current_dir()}/assets`

  return (
    <window
      visible
      name="bar"
      class="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={BOTTOM | LEFT | RIGHT}
      application={app}
    >
      <centerbox cssName="centerbox">
        <button
          class="startbutton"
          $type="start"
          onClicked={() => execAsync("walker")}
          hexpand
          halign={Gtk.Align.START}
        >
          <image 
            file={`${ASSETS_PATH}/arch_blue.png`}
            pixelSize={20}
          />
        </button>
        <box $type="center" />
        <box $type="end" halign={Gtk.Align.END} spacing={6}>
          <menubutton 
            class="systraybutton"
            direction={Gtk.ArrowType.UP}
          >
            <popover class="systraymenu">
              <Systray />
            </popover>
          </menubutton>
          <menubutton class="datetime">
            <box orientation={Gtk.Orientation.VERTICAL}>
              <label label={time} halign={Gtk.Align.END}/>
              <label label={date} halign={Gtk.Align.END}/>
            </box>
            <popover>
              <Gtk.Calendar />
            </popover>
          </menubutton>
        </box>
      </centerbox>
    </window>
  )
}

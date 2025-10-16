import { Gtk } from "ags/gtk4"
import Wp from "gi://AstalWp"

export default function VolumeIndicator() {
  const audio = Wp.get_default()
  const label = new Gtk.Label({
    halign: Gtk.Align.END,
  })

  const updateIcon = () => {
    const speaker = audio.get_default_speaker()
    if (!speaker) return

    if (speaker.mute) {
      label.label = ""
    } else if (speaker.volume <= 0.33) {
      label.label = ""
    } else if (speaker.volume <= 0.66) {
      label.label = ""
    } else {
      label.label = ""
    }
  }

  // Initial set
  updateIcon()

  // React to changes
  audio.get_default_speaker().connect("notify::volume", updateIcon)
  audio.get_default_speaker().connect("notify::mute", updateIcon)

  return label
}

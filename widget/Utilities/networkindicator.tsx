import { Gtk } from "ags/gtk4"
import Network from "gi://AstalNetwork"
import GLib from "gi://GLib"

export default function NetworkIndicator() {
  const network = Network.get_default()
  const label = new Gtk.Label({
    halign: Gtk.Align.END,
  })

  const updateIcon = () => {
    switch (network.get_primary()) {
        // Wired connection
        case 1:
            label.label = "󰀂"
            break
        // Wifi connection
        case 2:
            let strength = network.wifi.strength
            if (strength > 80){
                label.label = "󰤨"
            }
            else if(strength > 60){
                label.label = "󰤥"
            }
            else if(strength > 40){
                label.label = "󰤢"
            }
            else if(strength > 20){
                label.label = "󰤟"
            }
            else if(strength > 0){
                label.label = "󰤯"
            }
            break
        // No connection default
        default:
            label.label = "󰤮"
            break
    }
  }

  // Initial set
    updateIcon()

  // React to changes
    network.connect("notify::primary", updateIcon)
    network.connect("notify::state", updateIcon)
    network.connect("notify::devices", updateIcon)

    // Poll strength every second
    GLib.timeout_add(GLib.PRIORITY_DEFAULT, 1000, () => {
    if (network.get_primary() === 2) {
        updateIcon()
    }
    return true // keep repeating
    })

    return label
}

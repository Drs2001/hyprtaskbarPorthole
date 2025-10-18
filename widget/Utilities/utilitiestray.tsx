import AstalTray from 'gi://AstalTray';
import { Gtk } from 'ags/gtk4';
import GLib from "gi://GLib"
import NetworkIndicator from "./networkindicator"
import { execAsync } from 'ags/process';

export interface UtilsTrayProps {
  iconSize?: number; // default 16
  spacing?: number;  // default 4
}

export default function UtilsTray({ iconSize = 16, spacing = 10 }: UtilsTrayProps) {

  // Button bar
  const buttonBox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, spacing: 6 })
  
  // Content area
  const contentBox = new Gtk.Box({ orientation: Gtk.Orientation.VERTICAL, spacing: 6 })
  
  // Wrap button and content into a vertical box for tray
  const mainBox = new Gtk.Box({ orientation: Gtk.Orientation.VERTICAL, spacing: 6 })
  mainBox.append(buttonBox)
  // mainBox.append(contentBox)

  // Create content widgets
  const bluetoothWidget = new Gtk.Button({ label: "" })
  const networkWidget = new Gtk.Button({ label: "󰀂" })
  const volumeWidget = new Gtk.Button({ label: "" })
  const systemWidget = new Gtk.Button({ label: "󰍛" })

  bluetoothWidget.connect("clicked", () => {
    execAsync(["blueberry"])
    .then((out) => console.log(out))
    .catch((err) => console.error(err))
  })

  networkWidget.connect("clicked", () => {
    execAsync(["nm-connection-editor"])
    .then((out) => console.log(out))
    .catch((err) => console.error(err))
  })

  volumeWidget.connect("clicked", () => {
    execAsync(["kitty", "--class=Wiremix", "-e", "wiremix"])
    .then((out) => console.log(out))
    .catch((err) => console.error(err))
  })

  systemWidget.connect("clicked", () => {
    execAsync(["missioncenter"])
    .then((out) => console.log(out))
    .catch((err) => console.error(err))
  })

  buttonBox.append(bluetoothWidget)
  buttonBox.append(networkWidget)
  buttonBox.append(volumeWidget)
  buttonBox.append(systemWidget)

  // // Store them in a map for easy switching
  // const panels = {
  //   Net: networkWidget,
  //   Sys: systemWidget,
  //   Vol: volumeWidget,
  // }

  // // Add all widgets to contentBox but hide them initially
  // Object.values(panels).forEach(w => {
  //   contentBox.append(w)
  //   w.hide()
  // })

  // // Function to switch visible panel
  // let currentPanel: Gtk.Widget | null = null
  // const showPanel = (name: keyof typeof panels) => {
  //   if (currentPanel) currentPanel.hide()
  //   currentPanel = panels[name]
  //   currentPanel.show()
  // }

  // // Buttons
  // Object.keys(panels).forEach(name => {
  //   const btn = new Gtk.Button({ label: name })
  //   btn.connect("clicked", () => showPanel(name as keyof typeof panels))
  //   buttonBox.append(btn)
  // })

  // // Show the first panel by default
  // GLib.idle_add(GLib.PRIORITY_DEFAULT_IDLE, () => {
  //   showPanel("Net")
  //   return GLib.SOURCE_REMOVE
  // })

  return mainBox
}

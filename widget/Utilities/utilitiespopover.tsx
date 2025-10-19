import AstalTray from 'gi://AstalTray';
import { Gtk } from 'ags/gtk4';
import GLib from "gi://GLib"
import { execAsync } from 'ags/process';
import BluetoothMenu from './bluetoothmenu';

export default function UtilsPopover() {
  const popoverMenu = new Gtk.Popover()
  popoverMenu.add_css_class("systraymenu")

  // Wrap button and content into a vertical box for tray
  const mainBox = new Gtk.Box({ orientation: Gtk.Orientation.VERTICAL, spacing: 6 })

  popoverMenu.set_child(mainBox)

  // Clears the children of the main box
  function clearChildren() {
    let child;
    while ((child = mainBox.get_first_child())) {
      mainBox.remove(child);
    }
  }

  // Clear mainBox and update it to the new one
  function updateBox(box: Gtk.Box) {
    clearChildren()
    mainBox.append(box)
  }

  // Button bar (Default view for the utilities popover)
  const buttonBox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, spacing: 6 })

  // Set the popover view to the button box
  mainBox.append(buttonBox)

  // Declare back button to be used in sub-menus
  const backButton = new Gtk.Button({ label: "<--" })
  backButton.connect("clicked", () => {
    updateBox(buttonBox)
  })

  // Declare sub-menus
  const bluetoothMenu = BluetoothMenu(backButton)

  // Create buttons
  const bluetoothWidget = new Gtk.Button({ label: "" })
  const networkWidget = new Gtk.Button({ label: "󰀂" })
  const volumeWidget = new Gtk.Button({ label: "" })
  const systemWidget = new Gtk.Button({ label: "󰍛" })

  bluetoothWidget.connect("clicked", () => {
    updateBox(bluetoothMenu)
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

  popoverMenu.connect("closed", () =>{
      updateBox(buttonBox)
  })

  return popoverMenu
}

import { Gtk } from 'ags/gtk4';
import GLib from "gi://GLib"
import { execAsync } from 'ags/process';
import BluetoothMenu from './bluetoothmenu';

export default function UtilsPopover() {
  const popoverMenu = new Gtk.Popover()
  popoverMenu.add_css_class("systraymenu")

  popoverMenu.set_autohide(false); // TEMPORARY FOR DEBUGGING REMOVE FOR FINAL BUILD

  // Create a stack for animated transitions
  const stack = new Gtk.Stack({
    transition_type: Gtk.StackTransitionType.SLIDE_LEFT,
    transition_duration: 200, // ms
  });

  stack.set_vhomogeneous(false);
  stack.set_vexpand(false);
  stack.set_hexpand(false);

  popoverMenu.set_child(stack)

  // Button bar (Default view for the utilities popover)
  const buttonBox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, spacing: 6 })
  buttonBox.set_vexpand(false);
  buttonBox.set_hexpand(false);
  buttonBox.set_valign(Gtk.Align.START);

  // Declare back button to be used in sub-menus
  const backButton = new Gtk.Button({ label: "<--" })
  backButton.connect("clicked", () => {
    stack.transition_type = Gtk.StackTransitionType.SLIDE_RIGHT
    stack.set_visible_child(buttonBox)
  })

  // Declare sub-menus
  const bluetoothMenu = BluetoothMenu(backButton)

  stack.add_named(buttonBox, "main")
  stack.add_named(bluetoothMenu, "bluetooth")

  // Create buttons
  const bluetoothWidget = new Gtk.Button({ label: "" })
  const networkWidget = new Gtk.Button({ label: "󰀂" })
  const volumeWidget = new Gtk.Button({ label: "" })
  const systemWidget = new Gtk.Button({ label: "󰍛" })

  bluetoothWidget.connect("clicked", () => {
    stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT
    stack.set_visible_child(bluetoothMenu)
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
      stack.set_visible_child(buttonBox)
  })

  return popoverMenu
}

import AstalTray from 'gi://AstalTray';
import { Gtk } from 'ags/gtk4';
import GLib from "gi://GLib"
import { execAsync } from 'ags/process';

export default function BluetoothMenu(backButton: Gtk.Button) {
  // Wrap button and content into a vertical box for tray
  const mainBox = new Gtk.Box({ orientation: Gtk.Orientation.VERTICAL, spacing: 6 })

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
  
  // Content area
  const contentBox = new Gtk.Box({ orientation: Gtk.Orientation.VERTICAL, spacing: 6 })

  contentBox.append(backButton)

  mainBox.append(contentBox)


  return mainBox
}

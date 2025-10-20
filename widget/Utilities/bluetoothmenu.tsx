import { Gtk } from 'ags/gtk4';
import GLib from "gi://GLib"
import Bluetooth from "gi://AstalBluetooth"

export default function BluetoothMenu(backButton: Gtk.Button) {
    const bluetooth = Bluetooth.get_default()
    const adapter = bluetooth.get_adapter()

    for( const device of bluetooth.get_devices()) {
        console.log(device.name)
        console.log(device.paired)
        console.log(device.connected)
    }

    // Wrap button and content into a vertical box for tray
    const mainBox = new Gtk.Box({ orientation: Gtk.Orientation.VERTICAL, spacing: 6 })

    // Top bar containing the back button, title, and bluetooth toggle
    const topBox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, spacing: 6 })
    topBox.append(backButton)
    topBox.append(new Gtk.Label({label: "Bluetooth", halign: Gtk.Align.START}))

    // Middle section containing the paired devices list
    const middleBox = new Gtk.Box({ orientation: Gtk.Orientation.VERTICAL, spacing: 6 })
    middleBox.append(new Gtk.Label({label: "Paired devices", halign: Gtk.Align.START}))

    // Bottom section containing the non-paired device list
    const bottomBox = new Gtk.Box({ orientation: Gtk.Orientation.VERTICAL, spacing: 6 })
    bottomBox.append(new Gtk.Label({label: "Not paired", halign: Gtk.Align.START}))

    mainBox.append(topBox)
    mainBox.append(middleBox)
    mainBox.append(bottomBox)


    return mainBox
}

import { Gtk } from 'ags/gtk4';
import GLib from "gi://GLib"
import Bluetooth from "gi://AstalBluetooth"
import DeviceRow from "./devicerow"
import { timeout } from "ags/time"
import BluetoothController from "./bluetoothController";

export default function BluetoothMenu(backButton: Gtk.Button) {
    const bt = new BluetoothController()
    let pairedDevices: Bluetooth.Device[] = []
    let discoveredDevices: Bluetooth.Device[] = []

    // Wrap title box, scroller, and bottombox
    const mainBox = new Gtk.Box({ orientation: Gtk.Orientation.VERTICAL, spacing: 6 })

    // Wrap button and content into a vertical box for tray
    const devicesBox = new Gtk.Box({ orientation: Gtk.Orientation.VERTICAL, spacing: 6 })

    // Top bar containing the back button, title, and bluetooth toggle
    const titleBox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, spacing: 6 })
    titleBox.append(backButton)
    titleBox.append(new Gtk.Label({label: "Bluetooth", halign: Gtk.Align.START}))

    // Middle section containing the paired devices list
    const pariedDevicesBox = new Gtk.Box({ orientation: Gtk.Orientation.VERTICAL, spacing: 6 })
    pariedDevicesBox.append(new Gtk.Label({label: "Paired devices", halign: Gtk.Align.START, cssClasses: ["subheading"]}))

    // Lower middle section containing the non-paired device list
    const discoveredDevicesBox = new Gtk.Box({ orientation: Gtk.Orientation.VERTICAL, spacing: 6 })
    discoveredDevicesBox.append(new Gtk.Label({label: "Not paired", halign: Gtk.Align.START, cssClasses: ["subheading"]}))

    // Bottom section containing the settings button and refresh button
    const bottomBox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, halign: Gtk.Align.END, spacing: 6 })
    const refreshButton = new Gtk.Button({ label: "Refresh"})
    refreshButton.connect("clicked", () =>{
        bt.discoverNewDevices(refreshDiscoveredDevices)
    })
    bottomBox.append(refreshButton)

    // Refreshes the paired devices list
    function refreshPairedDevices(){
        pairedDevices = bt.getPairedDevices()
        // Empty the box
        const title = pariedDevicesBox.get_first_child()
        let child = title?.get_next_sibling() || null
        while(child){
            const next = child.get_next_sibling()
            pariedDevicesBox.remove(child)
            child = next
        }
        for(const device of pairedDevices){
            const deviceRow = DeviceRow(device, refreshPairedDevices)
            pariedDevicesBox.append(deviceRow)
        }
    }

    // Refreshes the discovered devices list
    function refreshDiscoveredDevices(){
        const title = discoveredDevicesBox.get_first_child()
        let child = title?.get_next_sibling() || null
        while(child){
            const next = child.get_next_sibling()
            discoveredDevicesBox.remove(child)
            child = next
        }

        discoveredDevices = bt.getDiscoveredDevices()
        for(const device of discoveredDevices){
            const deviceRow = DeviceRow(device, refreshAllDevices)
            discoveredDevicesBox.append(deviceRow)
        }
    }

    // Refreshes both lists
    function refreshAllDevices(){
        refreshPairedDevices()
        refreshDiscoveredDevices()
    }

    // Get initial paired devices
    refreshPairedDevices()

    // Get initial discovered devices
    refreshDiscoveredDevices()

    devicesBox.append(pariedDevicesBox)
    devicesBox.append(new Gtk.Separator({ orientation: Gtk.Orientation.HORIZONTAL, cssClasses: ["seperator"]}));
    devicesBox.append(discoveredDevicesBox)
    

    // === Wrap mainBox in a scrolled window ===
    const scroller = new Gtk.ScrolledWindow({
        vexpand: true,   // let it expand vertically if the container allows
        hexpand: false,  // width will be fixed
        overlay_scrolling: true, // optional: nice overlay scrollbars
    });

    scroller.add_css_class("bluetoothmenu")
    scroller.set_child(devicesBox)

    // Optional: force a fixed size for the popover content
    scroller.set_size_request(-1, 400) // width x height in pixels

    const test = new Gtk.ProgressBar({
        fraction: 0,
    })

    mainBox.append(titleBox)
    mainBox.append(test)
    mainBox.append(scroller)
    mainBox.append(bottomBox)

    // Function to pulse the progress bar
    function pulseProgressBar() {
        test.pulse();  // animate a small step
        return true;   // returning true keeps the timeout repeating
    }

    // Set a timer to pulse every 50ms
    GLib.timeout_add(GLib.PRIORITY_DEFAULT, 50, pulseProgressBar);

    // TODO when the menu opens
    // scroller.connect("map", () =>{
    //     console.log("OPEN")
    // })


    return mainBox
}

import { Gtk } from 'ags/gtk4';
import GLib from "gi://GLib"
import Bluetooth from "gi://AstalBluetooth"
import DeviceRow from "./devicerow"
import { timeout } from "ags/time"

export default function BluetoothMenu(backButton: Gtk.Button) {
    const bluetooth = Bluetooth.get_default()
    const adapter = bluetooth.get_adapter()
    const connectedDevices: Bluetooth.Device[] = []
    const pairedDevices: Bluetooth.Device[] = []
    const discoveredDevices: Bluetooth.Device[] = []

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
        try {
            if(adapter?.discovering){
                return adapter?.stop_discovery()
            }

            adapter?.start_discovery();

            const discoveryTimeout = 10000
            timeout(discoveryTimeout, () => {
                if(adapter?.discovering){
                    adapter.stop_discovery()
                }
            })
        } catch (err) {
            print(`Failed to start discovery: ${err}`);
        }
    })
    bottomBox.append(refreshButton)

    // Function to get paired and connected devices and populate their lists
    function getPairedDevices(){
        // Reset arrays
        connectedDevices.length = 0
        pairedDevices.length = 0
        for(const device of bluetooth.get_devices()){
            if(device.get_paired()){
                if(device.get_connected()){
                    connectedDevices.push(device)
                }
                else{
                    pairedDevices.push(device)
                }
            }
        }
    }

    // Gets a list of discovered devices
    function getDiscoveredDevices(){
        // Reset arrays
        discoveredDevices.length = 0
        for(const device of bluetooth.get_devices()){
            if(!device.get_paired() && device.name){
                discoveredDevices.push(device)
            }
        }
    }

    // Refreshes the paired devices list
    function refreshPairedDevices(){
        getPairedDevices()
        // Empty the box
        const title = pariedDevicesBox.get_first_child()
        let child = title?.get_next_sibling() || null
        while(child){
            const next = child.get_next_sibling()
            pariedDevicesBox.remove(child)
            child = next
        }
        for(const device of connectedDevices){
            const deviceRow = DeviceRow(device, refreshPairedDevices)
            pariedDevicesBox.append(deviceRow)
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

        getDiscoveredDevices()
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

    mainBox.append(titleBox)
    mainBox.append(scroller)
    mainBox.append(bottomBox)

    adapter?.connect("notify::discovering", () =>{
        refreshDiscoveredDevices()
    })

    // TODO when the menu opens
    // scroller.connect("map", () =>{
    //     console.log("OPEN")
    // })


    return mainBox
}

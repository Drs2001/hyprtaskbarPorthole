import { Gtk } from "ags/gtk4";
import { timeout } from "ags/time"
import Bluetooth from "gi://AstalBluetooth";
import BluetoothController from "./bluetoothController"

export default function DeviceRow(
  device: Bluetooth.Device,
  refreshDevices?: (() => void) | null
): Gtk.Widget {
  const bt = new BluetoothController()
  const deviceName = device.get_name() || "Unknown Device";

  const statusLabel = new Gtk.Label({
    label: device.get_connected() ? "Connected" : "Disconnected",
    halign: Gtk.Align.START,
    xalign: 0,
  });
  statusLabel.add_css_class("statusLabel")

  // The action button inside the revealer
  const actionButton = new Gtk.Button({
    label: device.get_connected() ? "Disconnect" : "Connect",
    halign: Gtk.Align.END,
  });

  let timer: ReturnType<typeof timeout> | null = null;

  actionButton.connect("clicked", () => {
    if (device.get_connected()) {
      try {
        device.disconnect_device(null);
      } catch (err) {
        print(`Failed to connect: ${err}`);
      }
    } else {
      try {
        if(device.paired){
          device.connect_device(null);
        }
        else{
          bt.pairDevice(device)
          .then(() => {
          })
          .catch((err) => {
              statusLabel.label = "Pairing failed";
              console.error("Pairing error:", err);
          });
        }
        statusLabel.label = "Conecting..."
        timer = timeout(10000, () => {
          if(!device.get_connected()){
            statusLabel.label = "Connection failed"
          }
          timer = null
        })
      } catch (err) {
        print(`Failed to connect: ${err}`);
      }
    }
  });

  // This doesn't just notify when connected but for any connection change
  device.connect("notify::connected", () => {
    if(device.get_connected() && device.get_paired()){
      if(timer){
        timer.cancel()
        timer = null
      }

      if (refreshDevices){ 
        refreshDevices()
      }
    }
    else if(device.get_paired()){
      if (refreshDevices){ 
        refreshDevices()
      }
    }
  })

  device.connect("notify::trusted", () => {
  })

  device.connect("notify::paired", () => {
    device.set_trusted(true)
    device.connect_device(null)
    
    if (refreshDevices){ 
        refreshDevices()
    }
  })

  // Revealer that animates the button sliding down
  const revealer = new Gtk.Revealer({
    reveal_child: false,
    transition_type: Gtk.RevealerTransitionType.SLIDE_DOWN,
    transition_duration: 100, // ms
  });
  revealer.set_child(actionButton);

  const titleLabel = new Gtk.Label({
    label: deviceName,
    halign: Gtk.Align.START,
    xalign: 0,
  });

  const contentBox = new Gtk.Box({
    orientation: Gtk.Orientation.VERTICAL,
    spacing: 2,
  });
  contentBox.append(titleLabel);
  contentBox.append(statusLabel);

  // Header button for the device name
  const header = new Gtk.Button({
    child: contentBox,
    halign: Gtk.Align.FILL,
  });

  header.connect("clicked", () => {
    // Toggle visibility of the action button
    revealer.reveal_child = !revealer.reveal_child;
  });

  // Vertical container for this device
  const deviceBox = new Gtk.Box({
    orientation: Gtk.Orientation.VERTICAL,
    spacing: 4,
  });

  deviceBox.append(header);
  deviceBox.append(revealer);
  deviceBox.add_css_class("devicerow")

  return deviceBox;
}

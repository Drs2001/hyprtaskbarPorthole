import { Gtk } from "ags/gtk4";
import Bluetooth from "gi://AstalBluetooth";

export default function DeviceRow(device: Bluetooth.Device): Gtk.Widget {
  // The action button inside the revealer
  const actionButton = new Gtk.Button({
    label: device.get_connected() ? "Disconnect" : "Connect",
    halign: Gtk.Align.END,
  });

  actionButton.connect("clicked", () => {
    if (device.get_connected()) {
    //   device.disconnect_service();
      actionButton.set_label("Connect");
    } else {
    //   device.connect_service();
      actionButton.set_label("Disconnect");
    }
  });

  // Revealer that animates the button sliding down
  const revealer = new Gtk.Revealer({
    reveal_child: false,
    transition_type: Gtk.RevealerTransitionType.SLIDE_DOWN,
    transition_duration: 100, // ms
  });
  revealer.set_child(actionButton);

  // Header button for the device name
  const header = new Gtk.Button({
    label: device.get_name() || "Unknown Device",
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
  deviceBox.append(new Gtk.Separator({ orientation: Gtk.Orientation.HORIZONTAL }));

  return deviceBox;
}

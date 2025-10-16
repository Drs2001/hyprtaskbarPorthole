import AstalTray from 'gi://AstalTray';
import { Gtk } from 'ags/gtk4';

export interface UtilsTrayProps {
  iconSize?: number; // default 16
  spacing?: number;  // default 4
}

export default function UtilsTray({ iconSize = 16, spacing = 10 }: UtilsTrayProps) {
  const tray = AstalTray.Tray.get_default()
  // Container for tray icons
  const trayBox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, spacing: spacing })
  const trayIcons: Gtk.Image[] = []


  function updateTrayItems() {
  // Remove old widgets from trayBox
  for (const icon of trayIcons) {
    trayBox.remove(icon)
  }
  trayIcons.length = 0

  // Add new tray items
  const items = tray.get_items()
  for (const item of items) {
    const icon = item.get_gicon()
    if (!icon) continue

    const image = new Gtk.Image({ gicon: icon, pixel_size: iconSize })
    const gesture = new Gtk.GestureClick({ button: 3 })
    gesture.connect("pressed", () => {
      const menuModel = item.get_menu_model() // returns Gio.MenuModel | null
      if (menuModel) {
        const popoverMenu = new Gtk.PopoverMenu({ menu_model: menuModel, has_arrow: false })
        popoverMenu.set_parent(image)  // anchor to the tray icon
        popoverMenu.insert_action_group('dbusmenu', item.get_action_group())
        popoverMenu.popup()
      }
    })
    image.add_controller(gesture)

    trayBox.append(image)
    trayIcons.push(image)
  }
}


  // Initial render
  updateTrayItems()

  // Listen for new items added/removed dynamically
  tray.connect("item-added", updateTrayItems)
  tray.connect("item-removed", updateTrayItems)

  return trayBox
}

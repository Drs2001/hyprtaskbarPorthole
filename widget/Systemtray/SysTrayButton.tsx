import { Gtk } from "ags/gtk4"
import Systray from "./SysTray"

export default function SysTrayButton() {
  const popover = (
    <popover class="systraymenu">
      <Systray />
    </popover>
  ) as Gtk.Popover;

  const button = (
    <menubutton
      class="systraybutton"
      direction={Gtk.ArrowType.UP}
    >
      {popover}
    </menubutton>
  ) as Gtk.MenuButton;

  // When popover visibility changes, toggle arrow direction
  popover.connect("show", () => {
    button.direction = Gtk.ArrowType.DOWN;
  });

  popover.connect("hide", () => {
    button.direction = Gtk.ArrowType.UP;
  });

  return button;
}

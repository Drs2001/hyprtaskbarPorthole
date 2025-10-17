import { Gtk } from "ags/gtk4"
import Hyprland from "gi://AstalHyprland"

export default function HideWindowsButton() {
  const hypr = Hyprland.get_default()
  let areHidden = false
  const windowWorkspaceMap: Record<string, number> = {}

  const icon = new Gtk.Label({
    label: "", // open eye
  })

  const button = new Gtk.Button({
    halign: Gtk.Align.END,
    child: icon,
  })

  button.add_css_class("hidewindowsbutton")

  button.connect("clicked", () => {
    let clients = hypr.get_clients();
    for (const client of clients){
        if(areHidden){
            const ws = windowWorkspaceMap[client.address]
            hypr.message(`dispatch movetoworkspacesilent ${ws},address:0x${client.address}`)
            delete windowWorkspaceMap[client.address]
        }
        else{
            windowWorkspaceMap[client.address] = client.workspace.id
            hypr.message(`dispatch movetoworkspacesilent special,address:0x${client.address}`)
        }
    }

    areHidden = !areHidden
    icon.label = areHidden ? "" : "" // closed eye / open eye
  })

  return button
}

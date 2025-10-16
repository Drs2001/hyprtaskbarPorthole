import { Astal, Gdk, Gtk } from "ags/gtk4";
import Notifd from "gi://AstalNotifd";
import app from "ags/gtk4/app";

export default function NotifdWidget(gdkmonitor: Gdk.Monitor) {
  const { RIGHT, TOP } = Astal.WindowAnchor;
  const notifd = Notifd.get_default();
  
  // Keep track of currently displayed notifications
  const activeNotifications: Map<number, Astal.Window> = new Map();
  
  // Listen for new notifications
  notifd.connect("notified", (_, id) => {
    const n = notifd.get_notification(id);
    if (!n) return;
    const hints = n.get_hints().recursiveUnpack() as any;
    let imagePath = hints["image-path"] || null;

    let appIcon = hints["desktop-entry"] || null;
    
    const notifWindow = (
      <window
        name={`notification-${id}`}
        class="Notification"
        gdkmonitor={gdkmonitor}
        anchor={TOP | RIGHT}
        exclusivity={Astal.Exclusivity.IGNORE}
        application={app}
      >
        <box orientation={Gtk.Orientation.VERTICAL}>
            <box orientation={Gtk.Orientation.HORIZONTAL}>
                {(appIcon) && (
                <image 
                    iconName={appIcon}
                />
                )}
                <label label={n.appName}/>
            </box>
            <box orientation={Gtk.Orientation.HORIZONTAL}>
                {(imagePath) && (
                <image 
                    file={imagePath} 
                />
                )}
                <box orientation={Gtk.Orientation.VERTICAL}>
                    <label label={n.summary} class="summary" halign={Gtk.Align.END}/>
                    <label label={n.body} class="body" halign={Gtk.Align.END}/>
                </box>
            </box>
        </box>
      </window>
    ) as Astal.Window;
    
    // Show the notification window
    notifWindow.show();
    activeNotifications.set(id, notifWindow);
    
    // Automatically remove it after 5 seconds
    setTimeout(() => {
      notifWindow.destroy();
      activeNotifications.delete(id);
    }, 5000);
  });
  
  // Listen for notification resolution (when user dismisses or notification expires)
  notifd.connect("resolved", (_, id) => {
    const notifWindow = activeNotifications.get(id);
    if (notifWindow) {
      notifWindow.destroy();
      activeNotifications.delete(id);
    }
  });
  
  // Return null since notifications create their own windows
  return null;
}
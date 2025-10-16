import app from "ags/gtk4/app"
import style from "./style.scss"
import Bar from "./widget/Bar"
import NotifdWidget from "./widget/Notification";

app.start({
  css: style,
  main() {
    const monitors = app.get_monitors();

    monitors.map((monitor) => {
      // Render the taskbar
      Bar(monitor);
    });
    NotifdWidget(monitors[0]);
  },
});

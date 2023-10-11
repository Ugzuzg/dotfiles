// by Ugzuzg
// Install:
// mkdir -p ~/.local/share/gnome-shell/extensions/keyboard@ugzuzg
// cp ./extension.js ./metadata.json ~/.local/share/gnome-shell/extensions/keyboard@ugzuzg
// Usage:
// gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/InputSources --method org.gnome.Shell.Extensions.InputSources.Call 0

import { Extension } from "resource:///org/gnome/shell/extensions/extension.js";
import Gio from "gi://Gio";
import * as Keyboard from "resource:///org/gnome/shell/ui/status/keyboard.js";

const MR_DBUS_IFACE = `
<node>
    <interface name="org.gnome.Shell.Extensions.InputSources">
        <method name="Call">
            <arg type="u" direction="in" name="layoutIndex"/>
        </method>
    </interface>
</node>`;

class InputSourcesExtension extends Extension {
  enable() {
    this._dbus = Gio.DBusExportedObject.wrapJSObject(MR_DBUS_IFACE, this);
    this._dbus.export(
      Gio.DBus.session,
      "/org/gnome/Shell/Extensions/InputSources"
    );
  }

  disable() {
    this._dbus.flush();
    this._dbus.unexport();
    delete this._dbus;
  }

  Call(layoutIndex) {
    Keyboard.getInputSourceManager().inputSources[layoutIndex].activate();
  }
}

export default InputSourcesExtension;

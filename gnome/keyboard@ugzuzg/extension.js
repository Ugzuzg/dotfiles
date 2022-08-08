// by Ugzuzg
// License: GPLv3
// Install:
// mkdir -p ~/.local/share/gnome-shell/extensions/keyboard@ugzuzg
// cp ./extension.js ./metadata.json ~/.local/share/gnome-shell/extensions/keyboard@ugzuzg
// Usage:
// gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/InputSources --method org.gnome.Shell.Extensions.InputSources.Call 0

const { Gio } = imports.gi;

const MR_DBUS_IFACE = `
<node>
    <interface name="org.gnome.Shell.Extensions.InputSources">
        <method name="Call">
            <arg type="u" direction="in" name="layoutIndex"/>
        </method>
    </interface>
</node>`;

class Extension {
    enable() {
        this._dbus = Gio.DBusExportedObject.wrapJSObject(MR_DBUS_IFACE, this);
        this._dbus.export(Gio.DBus.session, '/org/gnome/Shell/Extensions/InputSources');
    }

    disable() {
        this._dbus.flush();
        this._dbus.unexport();
        delete this._dbus;
    }

    Call(layoutIndex) {
        imports.ui.status.keyboard.getInputSourceManager().inputSources[layoutIndex].activate()
    }
}

function init() {
    return new Extension();
}

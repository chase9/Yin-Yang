from yin_yang.meta import Desktop
from . import firefox, brave, gedit, only_office
from . import sound, notify
from . import system, gtk, kvantum, wallpaper, custom
from . import vscode, atom, konsole
from ._plugin import Plugin, ExternalPlugin


# NOTE initialize your plugin over here:
# The order in the list specifies the order in the config gui
def get_plugins(desktop: Desktop) -> [Plugin]:
    return [
        system.System(desktop),
        gtk.Gtk(desktop),
        kvantum.Kvantum(),
        wallpaper.Wallpaper(desktop),
        firefox.Firefox(),
        brave.Brave(),
        vscode.Vscode(),
        atom.Atom(),
        gedit.Gedit(),
        only_office.OnlyOffice(),
        konsole.Konsole(),
        custom.Custom(),
        sound.Sound(),
        notify.Notification()
    ]


# this lets us skip all external plugins in yin_yang.py while keeping _plugin "private"
ExternalPlugin = ExternalPlugin

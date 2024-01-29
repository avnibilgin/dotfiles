#   ___ _____ ___ _     _____    ____             __ _
#  / _ \_   _|_ _| |   | ____|  / ___|___  _ __  / _(_) __ _
# | | | || |  | || |   |  _|   | |   / _ \| '_ \| |_| |/ _` |
# | |_| || |  | || |___| |___  | |__| (_) | | | |  _| | (_| |
#  \__\_\|_| |___|_____|_____|  \____\___/|_| |_|_| |_|\__, |
#                                                      |___/

# Icons: https://fontawesome.com/search?o=r&m=free

import os
import re
import socket
import subprocess
import psutil
import json
import asyncio
from libqtile import hook
from libqtile import qtile
from typing import List
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown, KeyChord
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.widget import Spacer, Backlight
from libqtile.widget.image import Image
from libqtile.dgroups import simple_key_binder
from pathlib import Path
from libqtile.log_utils import logger
from libqtile.backend.wayland import InputConfig

from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration
from qtile_extras.widget.decorations import PowerLineDecoration
#from conf.keyboard import *

# --------------------------------------------------------
# Your configuration
# --------------------------------------------------------

# Keyboard layout in conf/keyboard.py

# Show wlan status bar widget (set to False if wired network)
show_wlan = True
# show_wlan = False

# Show bluetooth status bar widget
# show_bluetooth = True
show_bluetooth = False


# --------------------------------------------------------
# General Variables
# --------------------------------------------------------

# Get home path
home = str(Path.home())

# Get Core name: x11 or wayland
core_name = qtile.core.name
logger.warning("Using config.py with " + core_name)

# --------------------------------------------------------
# Define Status Bar
# --------------------------------------------------------
try:
    wm_bar = Path(home + "/.cache/.qtile_bar_x11.sh").read_text().replace("\n", "")
except:
    wm_bar = "qtile"


logger.warning("Status bar: " + wm_bar)

# --------------------------------------------------------
# Check for Desktop/Laptop
# --------------------------------------------------------

# 3 = Desktop
platform = int(os.popen("cat /sys/class/dmi/id/chassis_type").read())

# --------------------------------------------------------
# Benutzerdefinierte Funktionen
# --------------------------------------------------------

@lazy.function
def window_to_next_free_group(qtile):
    i = qtile.groups.index(qtile.current_group)
    num_groups = len(qtile.groups)

    for offset in range(1, num_groups):
        next_group_index = (i + offset) % num_groups
        next_group = qtile.groups[next_group_index]

        if not next_group.windows:
            # Die nächste Gruppe ist frei, verschiebe das Fenster dorthin
            qtile.current_window.togroup(next_group.name)
            next_group.toscreen(toggle=False)
            break

def entferne_titeltext(text):
    return ""

# --------------------------------------------------------
# Set default apps
# --------------------------------------------------------

terminal = "alacritty"
editor = "geany"
file = "dolphin"
browser = "firefox"

# --------------------------------------------------------
# Keybindings
# --------------------------------------------------------

mod = "mod4" # SUPER KEY

keys = [

    # Layouts
    # ~ Key([mod], "j", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),

    # Applications
    # ~ Key([mod], "t", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "KP_Enter", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "r", lazy.spawn("alacritty --class=ranger -e sudo -E ranger"), desc="Launch ranger"),
    Key([mod], "a", lazy.spawn("rofi -show drun"), desc="Launch Rofi"),
    Key([mod], "space", lazy.spawn(browser), desc="Launch Browser"),
    Key([mod], "d", lazy.spawn(file), desc="Launch File Manager"),
    Key([mod], "e", lazy.spawn(editor), desc="Launch Editor"),
    Key([mod], "Escape", lazy.spawn("lxtask"), desc="Launch Task Manager"),
    Key([mod], "o", lazy.spawn("obsidian"), desc="Launch PK Manager"),

    # Window --> Active window actions
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "Return", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "w", lazy.window.toggle_floating(), desc='Toggle floating'),
    # ~ Key([mod], "h", minimize_all(), desc="Toggle hide/show all windows on current group"),

    # Window --> Move/Resize

    Key([mod], "KP_Subtract", lazy.layout.shrink(), desc="Grow window to the left"),
    Key([mod], "KP_Add", lazy.layout.grow(), desc="Grow window to the right"),
    Key([mod], "m", lazy.layout.maximize(), desc='Toggle between min and max sizes'),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # ~ Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    # ~ Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    # ~ Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    # ~ Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),

    # Window --> Focus
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    # ~ Key([mod, "shift"], "space", lazy.layout.next(), desc="Move window focus to other window around"),

    # Move Window --> Move in current workspace
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),

    # Swap Active with left or right
    # ~ Key([mod, "control"], "Left", lazy.layout.swap_left()),
    # ~ Key([mod, "control"], "Right", lazy.layout.swap_right()),
    # ~ Key([mod, "shift"], "Left", lazy.layout.swap_left()),
    # ~ Key([mod, "shift"], "Right", lazy.layout.swap_right()),

    # SCREENSHOTS

    # Original gespeichert
    Key([], "Print", lazy.spawn(home + "/.config/qtile/scripts/screenshot.sh sel_sav_org")),

    # Bearbeitet und gespeichert
    Key(["shift"], "Print", lazy.spawn(home + "/.config/qtile/scripts/screenshot.sh sel_sav_mod")),

    # Original in die Zwischenablage
    Key(["control"], "Print", lazy.spawn(home + "/.config/qtile/scripts/screenshot.sh sel_clp_org")),

    # Bearbeitet in die Zwischenablage
    Key(["control", "shift"], "Print", lazy.spawn(home + "/.config/qtile/scripts/screenshot.sh sel_clp_mod")),

    # LOGIN / LOGOUT / LOCK
    Key([mod], "Delete", lazy.spawn(home + "/.config/rofi/powermenu/type-1/powermenu.sh"), desc="Open Powermenu"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod, "shift"], "l", lazy.spawn("betterlockscreen -l"), desc="Lock Desktop"),

    # RESTARTS / RELOADS
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),

    # THEMING
    # ~ Key([mod, "shift"], "s", lazy.spawn(home + "/.config/qtile/scripts/barswitcher.sh"), desc="Switch Status Bar"),
    # ~ Key([mod, "shift"], "w", lazy.spawn(home + "/.config/qtile/scripts/wallpaper.sh"), desc="Update Theme and Wallpaper"),
    # ~ Key([mod, "control"], "w", lazy.spawn(home + "/.config/qtile/scripts/wallpaper.sh select"), desc="Select Theme and Wallpaper"),

    #--- SWITCH between ALL workspaces ---#

    # Switch workspaces relative to the active workspace
    Key([mod], "Tab", lazy.screen.next_group(skip_empty=True), desc="Toggle next FREE group"),
    Key(["control"], "Tab", lazy.screen.next_group(), desc="Toggle next group"),

    # Switch workspaces directly with Key([mod], "1-5"


    #--- MOVE active WINDOW between WORKSPACES ---#

    # Move active Window to the "first empty" workspace
    Key([mod, "shift"], "Return", window_to_next_free_group()),

    # Move active window to workspace with Key([mod, "SHIFT"], "1-5"

     Key([mod], "s", lazy.group["secret"].toscreen(), desc="Launch secret group"),
     Key([mod, "shift"], "s", lazy.window.togroup("secret"), desc="Move window to secret group"),

]

# --------------------------------------------------------
# Groups
# --------------------------------------------------------

groups = [
    Group("1", layout='monadtall'),
    Group("2", layout='monadtall'),
    Group("3", layout='monadtall'),
    Group("4", layout='monadtall'),
    Group("5", layout='max',
                  matches=[
                    Match(wm_class="obsidian"),
                    Match(wm_class="spotify"),
                    Match(wm_class="Gimp-2.10"),
                    Match(wm_class="Darktable"),
                    Match(wm_class="Chat-gpt"),
                    Match(wm_class="Inkscape")
                    ]
         ),
    Group("secret", label="", layout='monadtall'),
]

dgroups_key_binder = simple_key_binder(mod)

# --------------------------------------------------------
# Scratchpads
# --------------------------------------------------------

groups.append(ScratchPad("scratchpad", [
    DropDown("terminal", "alacritty", x=0.505, y=0.012, width=0.49, height=0.49, on_focus_lost_hide=False ),
    DropDown("keepassxc", "keepassxc", x=0.5, y=0.02, width=0.49, height=0.49, on_focus_lost_hide=False ),
    DropDown("feathernotes", "feathernotes", x=0.74, y=0.02, width=0.25, height=0.50, on_focus_lost_hide=False ),
]))

keys.extend([
    Key([mod], 'F12', lazy.group["scratchpad"].dropdown_toggle("terminal")),
    Key([mod], 'x', lazy.group["scratchpad"].dropdown_toggle("keepassxc")),
    Key([mod], 'y', lazy.group["scratchpad"].dropdown_toggle("feathernotes"))
]),

# --------------------------------------------------------
# Pywal Colors
# --------------------------------------------------------

colors = os.path.expanduser('~/.cache/wal/colors.json')
colordict = json.load(open(colors))
Color0=(colordict['colors']['color0'])
Color1=(colordict['colors']['color1'])
Color2=(colordict['colors']['color2'])
Color3=(colordict['colors']['color3'])
Color4=(colordict['colors']['color4'])
Color5=(colordict['colors']['color5'])
Color6=(colordict['colors']['color6'])
Color7=(colordict['colors']['color7'])
Color8=(colordict['colors']['color8'])
Color9=(colordict['colors']['color9'])
Color10=(colordict['colors']['color10'])
Color11=(colordict['colors']['color11'])
Color12=(colordict['colors']['color12'])
Color13=(colordict['colors']['color13'])
Color14=(colordict['colors']['color14'])
Color15=(colordict['colors']['color15'])

# --------------------------------------------------------
# Setup Layout Theme
# --------------------------------------------------------

layout_theme = {
    "border_width": 2,
    "margin": 10,
    "border_focus": "FFFFFF",
    "border_normal": Color2,
    "single_border_width": 0
}

layout_Max_theme = {
    "border_width": 0,
    "margin": 10,
}

# --------------------------------------------------------
# Layouts
# --------------------------------------------------------

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_Max_theme)
  # layout.MonadWide(**layout_theme),
  # layout.RatioTile(**layout_theme),
  # layout.Floating()
]

# --------------------------------------------------------
# Setup Widget Defaults
# --------------------------------------------------------

widget_defaults = dict(
    font="Fira Sans SemiBold",
    fontsize=12,
    padding=3
)
extension_defaults = widget_defaults.copy()

# --------------------------------------------------------
# Decorations
# https://qtile-extras.readthedocs.io/en/stable/manual/how_to/decorations.html
# --------------------------------------------------------

decor_left = {
    "decorations": [
        PowerLineDecoration(
            # path="arrow_left"
            # path="rounded_left"
            # path="forward_slash"
            path="back_slash"
        )
    ],
}

decor_right = {
    "decorations": [
        PowerLineDecoration(
            #path="arrow_right"
            #path="rounded_right"
            #path="forward_slash"
            path="back_slash"
        )
    ],
}

# --------------------------------------------------------
# Widgets
# --------------------------------------------------------

widget_list = [
    widget.TextBox(
        **decor_left,
        background=Color1+".4",
        text='APPS',
        foreground='ffffff',
        desc='',
        padding=10,
        mouse_callbacks={
        "Button1": lambda: qtile.spawn(home + "/.config/jgmenu/qtile/menu-launcher.sh"),
        "Button2": lambda: qtile.spawn(home + "/.config/jgmenu/qtile/apps-menu.sh"),
        "Button3": lambda: qtile.spawn("rofi -show drun")},
    ),
    widget.TextBox(
        **decor_left,
        background="#ffffff.4",
        text="",
        foreground="000000.6",
        fontsize=16,
        mouse_callbacks={"Button1": lambda: qtile.spawn(file)},
    ),
    widget.TextBox(
        **decor_left,
        background="#ffffff.4",
        text="",
        foreground="000000.6",
        fontsize=16,
        mouse_callbacks={"Button1": lambda: qtile.spawn(browser)},
    ),
    widget.TextBox(
        **decor_left,
        background="#ffffff.4",
        text="",
        foreground="000000.6",
        fontsize=16,
        mouse_callbacks={"Button1": lambda: qtile.spawn(terminal)},
    ),
    widget.TextBox(
        **decor_left,
        background="#ffffff.4",
        text="",
        foreground="000000.6",
        fontsize=16,
        mouse_callbacks={"Button1": lambda: qtile.spawn(editor)},
    ),
    widget.GroupBox(
        **decor_left,
        background="#ffffff.7",
        highlight_method='block',
        highlight='ffffff',
        block_border='ffffff',
        highlight_color=['ffffff','ffffff'],
        block_highlight_text_color='000000',
        foreground='ffffff',
        rounded=True,
        this_current_screen_border='ffffff',
        active='ffffff'
    ),
    widget.WindowName(
        **decor_left,
        max_chars=50,
        background=Color2+".4",
        width=400,
        padding=10
    ),
    widget.TaskList(
        **decor_left,
        background="#000000.3",
        theme_path="/usr/share/icons/Papirus",
        theme_mode="preferred",
        icon_size=18,
        highlight_method="block",
        borderwidth=0,
        border="000000.0",
        title_width_method="uniform",
        max_title_width=25,
        parse_text=entferne_titeltext,
    ),
    widget.Spacer(),
    widget.Spacer(
        length=30
    ),
    widget.TextBox(
        **decor_right,
        background="#000000.3"
    ),
    widget.Memory(
        **decor_right,
        background=Color10+".4",
        padding=10,
        measure_mem='M',
        format="{MemUsed:.0f} MB"
    ),
    widget.Volume(
        **decor_right,
        background=Color12+".4",
        padding=10,
        fmt="<span size='11pt'> </span> {}",
        mouse_callbacks={"Button3": lambda: qtile.spawn("pavucontrol -t 0")},
    ),
    widget.GenPollText(
        **decor_right,
        background=Color12+".4",
        padding=5,
        fmt=" <span size='9pt'> {} </span>",
        fontsize=16,
        func=lambda: subprocess.check_output([home + "/.config/qtile/scripts/qtile-bluetooth-name.sh"]).decode('utf-8').strip(),
        update_interval=10,
        mouse_callbacks={"Button1": lambda: qtile.spawn(home + "/.config/jgmenu/qtile/bluetooth-menu/bluetooth-menu.sh")},
    ),
    widget.GenPollCommand(
        **decor_right,
        cmd=(home + "/.config/qtile/scripts/qtile-ddc-module-steps.sh show"),
        #cmd=(home + "/.config/qtile/scripts/qtile-ddc-module.sh"),
        fmt=" <span size='9pt'> {}% </span>",
        update_interval=1,
        shell=True,
        background=Color12+".4",
        padding=5,
        fontsize=16,
            mouse_callbacks={
        "Button1": lazy.spawn(home + "/.config/qtile/scripts/qtile-ddc-module-steps.sh min"),
        "Button3": lazy.spawn(home + "/.config/qtile/scripts/qtile-ddc-module-steps.sh max"),
        "Button4": lazy.spawn(home + "/.config/qtile/scripts/qtile-ddc-module-steps.sh plus"),
        "Button5": lazy.spawn(home + "/.config/qtile/scripts/qtile-ddc-module-steps.sh minus"),
        },
    ),
    widget.Wlan(
        **decor_right,
        interface="wlp0s29u1u7",
        background=Color2+".4",
        width=65,
        padding=10,
        format="<span size='11pt'>󱚹 </span> {percent:2.0%}",
        mouse_callbacks={"Button1": lambda: qtile.spawn("alacritty -e nmtui")},
    ),
    widget.Clock(
        **decor_right,
        background=Color4+".4",
        padding=10,
        format="%a, %e. %b.  %R",
    ),
    widget.GenPollCommand(
        **decor_right,
        cmd=(home + "/.config/qtile/scripts/qtile-timer.sh"),
        update_interval=1,
        background=Color4+".4",
        width=36,
        padding=5,
        mouse_callbacks={
        "Button1": lazy.spawn(home + "/.config/qtile/scripts/qtile-timer-steps.sh date30set"),
        "Button2": lazy.spawn(home + "/.config/qtile/scripts/qtile-timer-steps.sh date1set"),
        "Button3": lazy.spawn(home + "/.config/qtile/scripts/qtile-timer-steps.sh readyset"),
        "Button4": lazy.spawn(home + "/.config/qtile/scripts/qtile-timer-steps.sh up"),
        "Button5": lazy.spawn(home + "/.config/qtile/scripts/qtile-timer-steps.sh down"),
        },
    ),
    widget.CheckUpdates(
        **decor_right,
        background=Color2+".4",
        distro = "Arch_checkupdates",
		display_format = " <span size='9pt'> {updates} </span>",
        execute="pamac-manager --updates",
		update_interval = 900,
		colour_have_updates = 'bf616a',
		colour_no_updates = 'ffffff',
        no_update_string = '',
        padding=5,
        fontsize=16,
    ),
    widget.GenPollCommand(
        **decor_right,
        cmd=(home + "/.config/qtile/scripts/qtile-dunst.sh"),
        update_interval=1,
        background=Color2+".4",
        padding=5,
        fontsize=16,
        mouse_callbacks={
        "Button1": lambda: qtile.spawn("dunstctl set-paused toggle"),
        "Button4": lambda: qtile.spawn("dunstctl close"),
        "Button5": lambda: qtile.spawn("dunstctl history-pop"),
        },
    ),
    # ~ widget.GenPollCommand(
        # ~ **decor_right,
        # ~ cmd=(home + "/.config/qtile/scripts/qtile-update.sh"),
        # ~ update_interval=1,
        # ~ background=Color2+".4",
        # ~ padding=5,
        # ~ fontsize=16,
        # ~ mouse_callbacks={
        # ~ "Button1": lambda: qtile.spawn(home + "/.config/qtile/scripts/qtile-update.sh up"),
        # ~ },
    # ~ ),
    widget.TextBox(
        **decor_right,
        background=Color2+".4",
        padding=5,
        text="󰅍",
        fontsize=16,
        mouse_callbacks={"Button1": lambda: qtile.spawn("xdotool key Alt_L+Down")},
    ),
    widget.TextBox(
        **decor_right,
        background=Color2+".4",
        padding=5,
        text=" ",
        fontsize=14,
        mouse_callbacks={
        "Button1": lambda: qtile.spawn(home + "/.config/jgmenu/qtile/exit-menu/exit-menu.sh"),
        "Button3": lambda: qtile.spawn(home + "/.config/rofi/powermenu/type-1/powermenu.sh")},
    ),
]

# Hide Modules if not on laptop
# ~ if (show_wlan == False):
    # ~ del widget_list[13:14]

# ~ if (show_bluetooth == False):
    # ~ del widget_list[12:13]

# ~ if (core_name == "x11"):
    # ~ del widget_list[13:14]


# --------------------------------------------------------
# Screens
# --------------------------------------------------------

if (wm_bar == "qtile"):
    logger.warning("Loading qtile bar")
    screens = [
        Screen(
                top=bar.Bar(
    		    widget_list,
                30,
                padding=20,
                opacity=0.7,
                border_width=[0, 0, 0, 0],
                margin=[0,0,0,0],
                background="#000000.3",
                ),
                # ~ wallpaper='~/.cache/current_wallpaper.jpg',
                # ~ wallpaper_mode='fill',
            ),
    ]
else:
    screens = [Screen(top=bar.Gap(size=28))]
    if (core_name == "x11"):
        screens = [Screen(top=bar.Gap(size=28))]
    else:
        screens = [Screen(top=bar.Gap(size=0))]

# --------------------------------------------------------
# Drag floating layouts
# --------------------------------------------------------

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

# --------------------------------------------------------
# Define floating layouts
# --------------------------------------------------------

floating_layout = layout.Floating(
    border_width=1,
    border_focus="FFFFFF",
    border_normal=Color2,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="pamac-manager"),  # software
        Match(wm_class="org.keepassxc.KeePassXC"),  # GPG key password entry
        Match(wm_class="pavucontrol"),
        Match(wm_class="copyq"),
        Match(wm_class="blueman-manager"),
        Match(wm_class="qt5ct"),
        Match(wm_class="nm-applet"),
        Match(wm_class="nm-connection-editor"),
        Match(wm_class='kdenlive'),       # kdenlive
        Match(wm_class="confirmreset"),  # gitk
       # Match(wm_class="dialog"), # dialog boxes
       # Match(wm_class="polkit-kde-authentication-agent-1"), # authentication
        Match(wm_class="download"),       # downloads
        Match(wm_class="file_progress"),  # file progress boxes
        Match(wm_class="toolbar"),        # toolbars
        Match(wm_class="notification"),   # notifications
        Match(wm_class="Yad"),            # yad boxes
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="error"),          # error msgs
        Match(wm_class='pinentry-gtk-2'), # GPG key password entry
        Match(title="pinentry"),  # GPG key password entry
        Match(title="branchdialog"),  # gitk
        Match(title='Confirmation'),      # tastyworks exit box
        Match(title='Qalculate!'),        # qalculate-gtk
        Match(title="tastycharts"),       # tastytrade pop-out charts
        Match(title="tastytrade"),        # tastytrade pop-out side gutter
        Match(title="tastytrade - Portfolio Report"), # tastytrade pop-out allocation
        Match(wm_class="tasty.javafx.launcher.LauncherFxApp"), # tastytrade settings
    ]
)

# Manuelles deaktivieren der Floating-Fenster

@hook.subscribe.client_new
def disable_floating(window):
    rules = [
        # Match(wm_class="pavucontrol")
    ]

    if any(window.match(rule) for rule in rules):
        window.togroup(qtile.current_group.name)
        window.cmd_disable_floating()

# --------------------------------------------------------
# General Setup
# --------------------------------------------------------

dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "focus"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.

# --------------------------------------------------------
# Windows Manager Name
# --------------------------------------------------------

wmname = "QTILE"

# --------------------------------------------------------
# Hooks
# --------------------------------------------------------

# HOOK startup
@hook.subscribe.startup_once
def autostart():
    autostartscript = "~/.config/qtile/autostart.sh"
    home = os.path.expanduser(autostartscript)
    subprocess.Popen([home])


# Verschobenes Fenster zur neuen Gruppe folgen.
# Funktioniert bei "window_to_next_free_group" oder group "matches"

@hook.subscribe.client_new
def modify_window(client):
    # Gruppe "Scratchpad" ausschließen
    for group in groups:
        match = next((m for m in group.matches if m.compare(client)), None)
        if match:
            targetgroup = qtile.groups_map[group.name]  # Verwende qtile.groups_map, um die richtige Gruppe zu erhalten
            targetgroup.toscreen(toggle=False)
            break


# Verschobenes Fenster zur neuen Gruppe folgen (außnahme ScratchPad).
# Funktioniert bei "gezielt" angesprochenen Gruppen (z.B. "Mod+Shift+3")

@hook.subscribe.group_window_add
def on_window_add(group, window):
     if group.name != "scratchpad":
        group.toscreen()


# Holt die Passwort-Abfrage des KDE-Polkit-Agenten nach vorne

@hook.subscribe.client_managed
async def restack_polkit(client):
    if "polkit-kde-authentication-agent-1" in client.get_wm_class():
        await asyncio.sleep(0.1)
        client.bring_to_front()

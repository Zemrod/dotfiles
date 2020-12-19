import os
import subprocess
from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, ScratchPad, DropDown, Key, Screen
from libqtile.lazy import lazy

import colors # symlink to $HOME/.cache/wal/colors.py

mod = "mod4"
terminal = "alacritty"
altterminal = "st"
rofi = "rofi -disable-history -case-sensitive -sort -show run"

keys = [
    # Switch between windows in current stack pane
    Key([mod],          "k", lazy.layout.down(),
        desc="Move focus down in stack pane"),
    Key([mod],          "j", lazy.layout.up(),
        desc="Move focus up in stack pane"),

    # Move windows up or down in current stack
    Key([mod, "shift"], "k", lazy.layout.shuffle_down(),
        desc="Move window down in current stack "),
    Key([mod, "shift"], "j", lazy.layout.shuffle_up(),
        desc="Move window up in current stack "),

    # Switch window focus to other pane(s) of stack
    Key([mod],          "Tab", lazy.layout.next(),
        desc="Switch window focus to other pane(s) of stack"),

    # Swap panes of split stack
    Key([mod, "shift"], "Tab", lazy.layout.rotate(),
        desc="Swap panes of split stack"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    # Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
    #     desc="Toggle between split and unsplit sides of stack"),

    # Applications
    Key([mod],          "Return", lazy.spawn(terminal),
        desc="Launch terminal"),

    Key([mod, "shift"], "Return", lazy.spawn(altterminal),
        desc="Launch alternate terminal"),

    Key([mod],          "d", lazy.spawn("emacs"), desc="Launch emacs"),

    Key([mod],          "c", lazy.spawn("code"), desc="Launch VSCode"),

    Key([mod, "shift"], "d", lazy.spawn("discord"), desc="Launch Discord"),

    Key([mod],          "b", lazy.spawn("brave"), desc="Launch Brave"),

    Key([mod],          "p", lazy.spawn(rofi), desc="Launch rofi"),

    # Key([mod, "shift"], "p", lazy.spawn("st -e bpytop"), desc="Launch bpytop"),

    # Toggle between different layouts as defined below
    Key([mod],          "space", lazy.next_layout(),
        desc="Toggle between layouts"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),

    Key([mod],          "q", lazy.restart(), desc="Restart qtile"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    Key([mod],          "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),

    # Audio
    Key([],             "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +10%"),
        desc="raise volume"),
    Key([],             "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -10%"),
        desc="lower volume"),
    Key([],             "XF86AudioMute",
        lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"),
        desc="mute/unmute volume"),

    # floating command
    Key([mod],          "t", lazy.window.toggle_floating(),
        desc="toggle floating of windows"),
]

group_names = ["1: Dev",
               "2: Web",
               "3",
               "4",
               "5",
               "6",
               "7",
               "8: Discord",
               "9"]

# groups = [Group(i) for i in "123456789"]

scratchpad = [ScratchPad("scratchpad", [
    # ScratchPad for sypheed
    DropDown("mail", "sylpheed", opacity=1.0),

    # ScratchPad for liferea
    DropDown("rss", "liferea", height=0.7, opacity=1.0),

    # Scratchpad for bpytop
    DropDown("res", "st -e bpytop", height=0.7, opacity=1.0),
])]

groups = [Group(name) for name in group_names]

groups = scratchpad + groups

keys.extend([
    Key([mod],          "s", lazy.group["scratchpad"].dropdown_toggle("mail"),
        desc="Launch sylpheed"),
    Key([mod],          "f", lazy.group["scratchpad"].dropdown_toggle("rss"),
        desc="Launch liferea"),
    Key([mod, "shift"], "p", lazy.group["scratchpad"].dropdown_toggle("res"),
        desc="Launch bpytop"),
])

for i, name in enumerate(group_names, 1):
    keys.append(Key([mod],          str(i), lazy.group[name].toscreen()))
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))

layout_theme = {"border_width": 0,
                "margin": 15
                }
layouts = [
    # layout.Stack(num_stacks=2),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Columns(),
    # layout.Matrix(),
    # layout.MonadTall(**layout_theme),
    # layout.MonadWide(),
    # layout.RatioTile(),
    layout.Tile(**layout_theme),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
    layout.Max(**layout_theme),
]

widget_defaults = dict(
    font='Ubuntu Mono',
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Image(
                    filename="~/.config/qtile/icons/python.png",
                    mouse_callbacks = {"Button1": lambda qtile: qtile.cmd_spawn("code .config/qtile/config.py")}
                ),
                widget.GroupBox(active=colors.color1, inactive=colors.color4,
                                this_current_screen_border=colors.color3, this_screen_border=colors.color4, hide_unused=True),
                widget.Sep(foreground=colors.color3),
                widget.Prompt(foreground=colors.color1),
                widget.Memory(foreground=colors.color1),
                widget.Sep(foreground=colors.color3),
                widget.Net(foreground=colors.color1, interface="enp2s0"),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Spacer(),
                widget.GenPollText(func=lambda: subprocess.check_output("pacupdate").decode("utf-8"), update_interval=360,
                                   foreground=colors.color1),
                widget.Sep(foreground=colors.color3),
                widget.GenPollText(func=lambda: subprocess.check_output("syspart").decode("utf-8"), update_interval=10,
                                   foreground=colors.color3),
                widget.Sep(foreground=colors.color3),
                widget.Battery(foreground=colors.color1, update_interval=20),
                widget.Sep(foreground=colors.color3),
                widget.GenPollText(func=lambda: subprocess.check_output("kernel").decode("utf-8"), update_interval=10,
                                   foreground=colors.color3),
                widget.Sep(foreground=colors.color3),
                widget.Clock(foreground=colors.color1, format='%Y-%m-%d %a %I:%M %p'),
                widget.Systray(),
            ],
            24,
            background=colors.background,
            opacity=0.8,
        ),
    ),
    Screen(
        top=bar.Bar(
            [
                widget.Image(
                    filename="~/.config/qtile/icons/python.png",
                    mouse_callbacks = {"Button1": lambda qtile: qtile.cmd_spawn("code .config/qtile/config.py")}
                ),
                widget.GroupBox(active=colors.color1, inactive=colors.color4,
                                this_current_screen_border=colors.color3, this_screen_border=colors.color4, hide_unused=True),
                widget.Sep(foreground=colors.color3),
                widget.Prompt(),
                widget.Memory(foreground=colors.color1),
                widget.Sep(foreground=colors.color3),
                widget.Net(foreground=colors.color1, interface="enp2s0"),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Spacer(),
                widget.GenPollText(func=lambda: subprocess.check_output("syspart").decode("utf-8"), update_interval=10,
                                   foreground=colors.color3),
                widget.Sep(foreground=colors.color3),
                widget.GenPollText(func=lambda: subprocess.check_output("kernel").decode("utf-8"), update_interval=10,
                                   foreground=colors.color3),
                widget.Sep(foreground=colors.color3),
                widget.Clock(foreground=colors.color1, format='%Y-%m-%d %a %I:%M %p'),
            ],
            24,
            background=colors.background,
            opacity=0.8,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

@hook.subscribe.startup_once
def start_up():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

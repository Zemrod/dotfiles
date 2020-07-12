#!/usr/sbin/env bash

# Wallpaper
# useing nitrogens restore option to use the wallpapers from the previous session
nitrogen --restore &

# Compositor
# used for the Terminal transparency
picom &

# For Multiscreen
# Replace HDMI1 and eDP1 with your screens, use xrandr to figure out your screen names
# buggy causes trouble with picom and nitrogen only on startup though
# xrandr | grep -q HDMI1 && xrandr --output eDP1 --auto --output HDMI1 --auto --right-of eDP1 &

# pywal colorscheme
wal -R &

# screen timeout
xset s off &
xset dpms 0 0 0 &
xset -dpms &

#!/usr/bin/env bash

# returns the path to the wallpaper on the screen you first set a Wallpaper (i.e Line 2 of the bg-saved.cfg)

# awk -F'=' '{ if(NR==2) print $2 }' $HOME/.config/nitrogen/bg-saved.cfg

# equal to the same above with an own tool available on gitlab
hawk -s '=' -l 2 -f 2 $HOME/.config/nitrogen/bg-saved.cfg

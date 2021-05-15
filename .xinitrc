#!/bin/sh

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

# default X Cursor
xsetroot -cursor_name left_ptr

# Start qtile
#exec qtile

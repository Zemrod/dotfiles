#!/usr/bin/env bash

primary=eDP1
secondary=HDMI1

xrandr --output ${primary} --auto --output ${secondary} --auto --right-of ${primary}

nitrogen --restore 2>/dev/null

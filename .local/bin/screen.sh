#!/usr/bin/env bash

primary=eDP1
secondary=HDMI1

if [[ $1 = "on" ]]
then
	xrandr --output ${primary} --auto --output ${secondary} --auto --right-of ${primary}

	nitrogen --restore 2>/dev/null
elif [[ $1 = "off" ]]
then
	xrandr --output ${secondary} --off
fi

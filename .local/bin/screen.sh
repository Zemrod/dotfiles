#!/usr/bin/env bash

primary=$(xrandr | grep connected | grep -v dis | grep primary | awk '{ print $1 }')
secondary=$(xrandr | grep connected | grep -v dis | grep -v primary | awk '{ print $1 }')

if [[ $1 = "on" ]]
then
	xrandr --output ${primary} --mode 1920x1200 --output ${secondary} --auto --right-of ${primary}

	nitrogen --restore 2>/dev/null
elif [[ $1 = "off" ]]
then
	xrandr --output ${secondary} --off
fi

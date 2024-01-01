#!/usr/bin/env bash

#primary=$(xrandr | grep connected | grep -v dis | grep primary | awk '{ print $1 }')
primary=HDMI1
#secondary=$(xrandr | grep connected | grep -v dis | grep -v primary | awk '{ print $1 }')
secondary=DP3

if [[ $1 = "on" ]]
then
	xrandr --output eDP1 --off --output ${primary} --auto --output ${secondary} --auto --right-of ${primary}

	$HOME/.fehbg
elif [[ $1 = "off" ]]
then
	xrandr --output ${secondary} --off --output ${primary} --off --output eDP1 --mode 1920x1200

	$HOME/.fehbg
fi

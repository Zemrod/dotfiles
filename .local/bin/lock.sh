#!/usr/bin/env bash

image=/tmp/screen.png

xwobf -s 3 $image

i3lock -i $image

rm $image

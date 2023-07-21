#!/usr/bin/env bash

scanimage -d "airscan:e0:Canon TS3400 series" -x 210 -y 297 --resolution 150 --format=pdf --mode color > $1.pdf

#!/usr/bin/env bash

nitrogen --set-zoom-fill --random --head=0 --save
nitrogen --set-zoom-fill --random --head=1 --save

wal -n -i $(bg.sh)

# ST
cd $HOME/.local/src/st
sudo make clean install

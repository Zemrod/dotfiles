#!/usr/bin/env bash

wal -n -i $(bg.sh)

# ST
cd $HOME/.local/src/st
sudo make clean install

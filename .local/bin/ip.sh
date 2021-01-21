#!/usr/bin/env bash

# name of the network device
dev=enp2s0

printf " $(ip a | grep inet | grep $dev | rawk -f 2 | rawk -s '/' -f 1)"

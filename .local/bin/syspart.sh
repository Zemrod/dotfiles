#!/usr/bin/env bash

# prints the used space of the given disk

disk=/dev/sda3

printf " $(df -h -B M | grep $disk | awk '{print $3}')/$(df -h -B M | grep $disk | awk '{print $2}')"

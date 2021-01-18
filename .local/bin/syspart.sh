#!/usr/bin/env bash

# prints the used space of the given disk

disk=/dev/sda3

# printf " $(df -h -B M | grep ${disk} | awk '{print $3}')/$(df -h -B M | grep ${disk} | awk '{print $2}')"

# same as above with own rawk tool
printf " $(df -h -B M | grep ${disk} | rawk -f 3)/$(df -h -B M | grep ${disk} | rawk -f 2)"

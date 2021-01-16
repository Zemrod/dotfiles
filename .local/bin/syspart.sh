#!/usr/bin/env bash

# prints the used space of the given disk

disk=/dev/sda3

# printf " $(df -h -B M | grep ${disk} | awk '{print $3}')/$(df -h -B M | grep ${disk} | awk '{print $2}')"

# same as above with own hawk tool
printf " $(df -h -B M | grep ${disk} | hawk -f 3)/$(df -h -B M | grep ${disk} | hawk -f 2)"

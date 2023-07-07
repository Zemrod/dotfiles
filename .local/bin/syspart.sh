#!/usr/bin/env bash

# prints the used space of the root partition

disk=$(df | grep "/dev/" | grep -v " /[a-z]" | awk '{ print $1 }')

#printf " $(df -h -B M | grep $disk | awk '{ print $3 }')/$(df -h -B M | grep $disk | awk '{ print $2 }')"
printf '%s' " $(df -h -B M | grep $disk | awk '{ print $5 }') used"

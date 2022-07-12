#!/usr/bin/env bash

virt-install --connect qemu:///system --osinfo linux2020 --name $1 --memory 4096 --vcpus=4 --cpu host --cdrom $2 --disk $HOME/.local/libvirt/images/$1.qcow2 --network default --video virtio --soundhw default --graphics spice --virt-type kvm --noautoconsole

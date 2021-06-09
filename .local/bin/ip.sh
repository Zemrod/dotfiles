#!/usr/bin/env bash

# name of the network device
if ip a | grep inet | grep -q enp2s0;
then
	dev=enp2s0
elif ip a | grep inet | grep -q wlan0;
then
	dev=wlan0
else
	dev="none"
fi

if [ $dev = "none" ]
then
	printf " no connection"
else
	printf " $(ip a | grep inet | grep $dev | awk '{ print $2 }' | awk -F'/' '{ print $1 }')"
fi

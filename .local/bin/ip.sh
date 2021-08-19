#!/usr/bin/env bash

# dependency: Systemd-Networkd
# name of the network device
if networkctl | grep -q routable;
then
	dev=$(networkctl | grep routable | awk '{ print $2 }')
else
	dev="none"
fi

if [ $dev = "none" ]
then
	printf " no connection"
else
	# IPv6
	# printf " $(networkctl status $dev | grep -v HW | grep -A 1 Address: | awk '{ print $1 }' | grep -v Address | sed -e 's/^*//')"

	# IPv4
	printf " $(networkctl status $dev | grep -v HW | grep Address: | awk '{ print $2 }')"
fi

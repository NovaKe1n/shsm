#!/usr/bin/bash

#title|netup 
#version|0.1
#author|0ero1ne 
#info|stop monitor mode

if [[ $# -eq 1 && $EUID -eq 0 ]]; then
	interface=$1
	imon=${1}mon

	printf "%s\n" "[*] Stopping monitor mode..."
	ifconfig $imon down
	iwconfig $imon mode manged
	ip link set $imon name $interface
	ifconfig $interface up
	
	printf "%s\n" "[*] Restarting NetworkManager..."
	service NetworkManager restart
	
	printf "%s\n" "[*] DHCP request..."
	dhclient $interface
	

	#printf "\n%s\n" "[*] Restarting NetworkManager..."
	#sudo service NetworkManager restart &>/dev/null
else
	printf "%s\n" "[X] sudo ./netup <interface>"
fi


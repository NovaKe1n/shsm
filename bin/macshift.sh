#!/usr/bin/bash

#title|macshift
#version|1.0
#author|0ero1ne
#info|this script will shift your mac address to a given one

#networksetup -setairportnetwork $INTERFACE $SSID $PASSWORD

if [ "$1" ]; then
	if [ "$1" == "-r" ]; then
		new_mac=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//' | tr a-z A-Z)
	elif [[ "${#1}" -eq 17 ]]; then
		new_mac=$1
	fi
	
	# Setting variables
	host="8.8.8.8"
	timeout=10
	old_mac=$(ifconfig en0 ether | sed -n 2p | cut -d' ' -f 2)	
	network="$(networksetup -getairportnetwork en0 | cut -d':' -f2 | tr -d ' ')"
	
	printf "${Green}Network: ${Yellow}$network\n"
	printf "${Green}Old mac: ${Red}$old_mac\n"
	printf "${Green}Mew mac: ${Blue}$new_mac \n"
	printf "${Green}Shifting...\n"    
	
	sudo ifconfig en0 ether $new_mac # > /dev/null 2>&1    
	sleep 0.5
	
	printf "Network down...\n"
	
	networksetup -setairportpower en0 off	
	
	sleep 1
	
	printf "Network up...\n"
	
	networksetup -setairportpower en0 on	
	#	sleep $timeout
	#
	#	ping -c1 "$host" &> /dev/null
	#	if [ $? -eq 0 ]; then
	#  		printf "Connected to ${Yellow}$network${Green}\n"	
	#	else
	#  		printf "Connecting to ${Yellow}$network${Green}...\n"
	#		networksetup -setairportnetwork en0 "$network" #2>&1 /dev/null
	#	fi

else
	printf "${Green}Give me a valid MAC address!\n"
fi

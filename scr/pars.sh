#!/usr/bin/env bash

# Title: pars
# Version: 0.1
# Author: 0ero1ne
# Description: pars airodump-ng's dump file

#9C:97:26:BD:D0:B3, 2020-02-19 20:05:18, 2020-02-19 20:05:18,  1, 130, WPA2 WPA, CCMP TKIP, PSK, -84,        1,        0,   0.  0.  0.  0,  11, TNCAPBDD0B3, 

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




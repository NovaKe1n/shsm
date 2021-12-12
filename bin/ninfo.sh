#!/usr/bin/bash

#title|ninfo
#version|1.0
#author|0ero1ne
#info|shows all the network informations of the local host

io=$(networksetup -getairportpower en0)
IFS=' ' read -r -a i_o <<< "$io"
io="${i_o[0]} ${i_o[1]} ${i_o[3]}"

check_wifi=$(networksetup -getairportnetwork en0 | head -n 1)

if [[ "$check_wifi" != "You are not associated with an AirPort network." ]]; then
	ip=$(ipconfig getifaddr en0)

	wifi=$(networksetup -getairportnetwork en0)
	wifi=${wifi:23}

    broadcast=$(ifconfig en0 | grep 'broadcast' | awk '{print $6}')
else
	ip='Not connected to a network'
	wifi='Not connected to a network'
  broadcast='Not connected to a network'
fi

imac=$(ifconfig en0 ether | tail -n 1)
IFS=' ' read -r -a mac <<< "$imac"

gateaway=$(netstat -nr | grep default | head -n 1 | cut -f 13 -d ' ')

# Output
printf "\n${Red}%12s\n" "^"
printf "${Green}%10s ${Red}| ${Yellow}%s \n" "I/O" "$io"
printf "${Green}%10s ${Red}| ${Yellow}%s \n" "SSID" "$wifi"
printf "${Green}%10s ${Red}| ${Yellow}%s \n" "IP" "$ip"
printf "${Green}%10s ${Red}| ${Yellow}%s \n" "Mac" "${mac[1]^^}"
printf "${Green}%10s ${Red}| ${Yellow}%s \n" "Broadcast" "$broadcast"
printf "${Green}%10s ${Red}| ${Yellow}%s \n" "Gateaway" "$gateaway"

printf "${Green}%10s ${Red}| ${Yellow}%s \n" "Name" "$(scutil --get ComputerName)"
printf "${Green}%10s ${Red}| ${Yellow}%s \n" "Hostname" "$(scutil --get HostName || echo "None")"
printf "${Green}%10s ${Red}| ${Yellow}%s \n\n" "Localhost" "$(scutil --get LocalHostName)"

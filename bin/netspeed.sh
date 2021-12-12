#!/usr/bin/bash

#title|netspeed
#version|0.9-b2
#author|0ero1ne
#info|return the speed in ms between client and server

# Google server set by default
server="8.8.8.8"

# Check if user set a custom server
[ "$1" ] && server=$1

printf "\n${Red}%12s\n" "^"
printf "${Green}%10s ${Red}| ${Yellow}%s\n" "Server" "$server"

key=''
while [ -z $key ];
do
	# Ping
	ping -c 1 -W 1000 $server > /dev/null 2>&1

	# Check if server is reachable
	if [[ "$?" -eq 0 ]]; then
		# Parse output
		data=$(ping -c 1 -s 20 $server | cut -f 4 -d '=' | head -n 2 | tail -n 1)
		printf "${Green}%10s ${Red}| ${Yellow}%s       \r" "Speed" "$data"
	else
		# Error message
		printf "${Green}%10s ${Red}| ${Yellow}%s       \r" "Speed" "Error"
	fi
	# Read single char input on 0.2 timeout
	read -t 0.2 -N 1 key
done

echo

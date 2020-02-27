#!/usr/bin/env bash

# Title: cc
# Version: 0.1
# Author: 0ero1ne
# Description: change interface's channel

if [ $# -eq 2 ]; then
	printf "[*] Changing channel on interface $1...\n"
	sudo ifconfig $1 down
	sudo iwconfig $1 channel $2
	sudo ifconfig $1 up
	printf "[*] Done\n"
else
	printf "%s\n" "[X] ./cc.sh <imon> <channel>"
fi

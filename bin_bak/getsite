#!/usr/bin/bash

#title|getsite
#version|0.2-a1
#author|0ero1ne
#info|download an entire website using recursive option

if [ "$1" ]; then
	printf "\nDownloading (might take a while)...\t"
	wget -mkEpnp $1 -P /tmp/ 2>/dev/null
	printf "\rDONE\null"
else
    printf "${Red}Give me the website!\n"
fi

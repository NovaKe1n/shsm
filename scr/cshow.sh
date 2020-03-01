#!/usr/bin/env bash

# Title: cshow
# Version: 0.1
# Author: 0ero1ne 
# Description: config file list

files=(/etc/pulse/client.conf \
	/etc/pulse/default.pa \
	/usr/share/alsa/alsa.conf \
	)

for i in ${files[@]}; do
	clear
	cat $i
	printf "\n $i"
	read -p ""
	
done

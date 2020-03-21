#!/usr/bin/env bash

#title|cshow
#version|0.1
#author|0ero1ne 
#info|config file list

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

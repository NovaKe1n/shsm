#!/usr/bin/bash

#title|macgen
#version|1.0
#author|0ero1ne
#info|generate a random MAC address

mac=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//' | tr a-z A-Z)

printf "${Green}Random MAC: ${NC}%s\n" "$mac"

#!/usr/bin/bash

#title|img
#version|1.0
#author|0ero1ne
#info|open an image with preview

if [[ "$1" ]]; then
    printf "${Green}Opening:${NC} $1 ${Green}on preview...\n"
    open -a "preview" "$1"
else
    printf "${Red}Give me the img!\n"
fi

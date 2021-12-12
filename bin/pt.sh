#!/usr/bin/bash

#title|pt
#version|1.0
#author|0ero1ne
#info|return pattern of file/folder and copy it into clipboard

if [[ -f "$1" ]] || [[ -d "$1" ]]; then
	printf "\n${Green}Copied ~ ${Yellow}$PWD/$1${NC}\n\n"; $(printf "$PWD/$1" | pbcopy)
else
	printf "${Red}Give me an input!\n"
fi

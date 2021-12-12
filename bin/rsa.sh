#!/usr/bin/bash

#title|rsa
#version|1.0
#author|0ero1ne
#info|generate a RSA key using openssl at 2048 bit

if [[ "$1" ]]; then
    openssl genrsa -out /tmp/$1 2048
    printf "\n %s" "$(cat /tmp/$1)"
    $(cat /tmp/$1 | pbcopy)
    
    printf "\n\n${Green}Key path ~ ${Yellow}/tmp/$1"
    printf "\n${Green}Copied to the clipboard!\n"
else
    printf "\n${Red}Give me a name for the key!\n\n"
fi

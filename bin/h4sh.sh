#!/usr/bin/bash

#title|h4ash
#version|1.0
#author|0ero1ne
#info|generate MD5, SHA256, SHA512, Whirlpool hashed from a string

if [[ ${#} -gt 0 ]]; then
    printf "\n${Yellow}Generating hashes...\n\n"
    printf " ${Blue}MD5: ${NC}" ; echo $1 | openssl dgst -md5 -r | cut -d ' ' -f 1
    printf " ${Blue}SHA256: ${NC}" ; echo $1 | openssl dgst -sha256 -r | cut -d ' ' -f 1
    printf " ${Blue}SHA512: ${NC}" ; echo $1 | openssl dgst -sha512 -r | cut -d ' ' -f 1
    printf " ${Blue}Whirlpool: ${NC}" ; echo $1 | openssl dgst -whirlpool -r | cut -d ' ' -f 1
    printf "\n"
else
    printf "${Red}Give me a string to encrypt!\n"
fi

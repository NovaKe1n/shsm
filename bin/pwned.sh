#!/usr/bin/bash

#title|pwned
#version|0.1-a1
#author|0ero1ne
#info|check if your account has been compromised

account="test@test.com"
http="https://haveibeenpwned.com/api/v2/breachedaccount/$account"

#curl -A "pwnedornot" $http #-p --socks4 91.106.94.178:80
curl -s -X GET "$http"

echo

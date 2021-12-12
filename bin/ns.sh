#!/bin/env bash

#title|ns
#version|1.0
#author|NovaKe1n
#info|look up name service doing different queries

if [ -z "$1" ]; then
	printf "Usage: ./$(basename $0) <subdomain>\n"
	exit 0
fi


# DNS type
printf "\n--------- Host ---------\n"
nslookup $1

# Type A
printf "\n--------- A ---------\n"
nslookup -type=A $1

# Type CNAME
printf "\n--------- CNAME ---------\n"
nslookup -type=CNAME $1

# Type MX
printf "\n--------- MX ---------\n"
nslookup -type=MX $1

# Type TXT
printf "\n--------- TXT ---------\n"
nslookup -type=TXT $1

# EOF

#!/usr/bin/bash

#title|wk
#version|0.6-b1
#author|0ero1ne
#info|terminal clock with customized time zones

TIME_ZONES="America/Los_Angeles Europe/Rome Europe/London China/Beijing America/Los_Angeles"
OUTPUT=""

for loc in $TIME_ZONES; do
	   CITY=`echo $loc | sed 's/\// /g' | awk '{ print $2 }'`
	   CUR_TIME=`TZ=${loc} date | awk '{ print $1 " " $3 " " $4 " " $5 }'`
	   TEMP=`awk -v l="$CITY" -v t="$CUR_TIME" 'BEGIN { print l "\t" t }'`
	   OUTPUT="${OUTPUT}\n${TEMP}"
done
printf "\n\t   ${Yellow}World Clock${Blue}\n\n"
printf "$OUTPUT\n" | column -t
printf "\n"

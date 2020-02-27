#!/usr/bin/env bash

# Version of the script
version=0.1		# Current version
directory=scr/		# Scripts directory


# Logo
logo () { printf "\n%15s | %s\n\n" "[$0]" "[v$version]"; }


# Usage if any error or if -h
usage () {
	printf "usage: ./shsm <options> [script]\n"
	printf "options:\n"
	printf "  -l		Print all scripts\n"
	printf "  -s <query>	Search a script\n"
	printf "  -i <package> 	Script's info\n"
	printf "  -h		Show this help\n\n"
	exit 0
}


# Output all the scripts installed  
package_list () {
	for file in $directory/*; do
		printf "%15s |%s\n" "$(basename $file .sh)" "$(awk -F: 'NR==6 {print $2}' $file)"
	done
}


# Function that grep parameter into the script folder to look for matches and print
# the name of the script and description to the user
package_search() {
	for file in $directory/*; do
		if sed -n '3,6p' $file | grep -q $1; then
			printf "%s%s\n" "${file%%.*}" "$(awk -F: 'NR==4 {print $2}' $file)" 
			printf "%s\n\n" "$(awk -F: 'NR==6 {print $2}' $file)"
		fi
	done
}

# Retrieve script's info
package_info () {
	awk -F: 'NR==3,NR==6 {printf "%15s |%s\n", substr($1,3), $2}' scr/${1}.sh
}


# Beginning of the actual script
logo
case $1 in
	-l) package_list ;;
	-s) [ ! -z "$2" ] && package_search ${2} || printf "[X] Missing search parameter...\n"  ;;
	-i) [ -f scr/${2}.sh ] && package_info ${2} || printf "[X] Script not found...\n" ;;
	-h) usage ;;
	*) usage ;;
esac

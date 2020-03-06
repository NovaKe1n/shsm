#!/usr/bin/env bash

# Title: 
# Version: 0.1
# Author: 0ero1ne 
# Description: 


# TODO
#   - check for errors
#	- 


# Global variables
version=0.1
directory='scr'

red=\033[


# logo
logo () 
{ 
	printf "\n%15s | %s\n\n" "[$0]" "[v$version]"
}



# version
version ()
{
	printf "$0 $version\n"
}



# usage
usage ()
{
	printf """
$0 <parameter> 

  -l, --list			list all scripts
  -s, --search <keyword>	search script using a keyword
  -i, --info 			view script info
  -h, --help			print this help
  -v, --version			current version

"""
	exit 0
}



# list function to output all script inside scr
script_list ()
{
	for file in $directory/*; do
		
		printf "%15s | " "$(basename $file .sh)" 

		if [ -z "$(awk -F: 'NR==6 {gsub(/^[ \t]+/,"",$2); print $2}' $file)" ]; then
			printf "** No description **\n" 
		else 
			printf "$(awk -F: 'NR==6 {gsub(/^[ \t]+/,"",$2); print $2}' $file)\n"
		fi
	done; echo

	exit 0
}


# search script by keyword
script_search() 
{
	return_code=1

	[ -z "$1" ] && printf "[error] missing search parameter\n" && exit 1

	for file in $directory/*; do
		if sed -n '3,6p' $file | grep -q $1; then	
			printf "%s%s\n" "${file%%.*}" "$(awk -F: 'NR==4 {print $2}' $file)" 
			printf "%s\n\n" "$(awk -F: 'NR==6 {print $2}' $file)"
			
			return_code=0
		fi
	done
	
	[ "$return_code" -eq 1 ] && printf "[error] no script found\n" && exit 1

	exit 0
}



# retrive script info
script_info ()
{
	# check if arg is not empty
	[ -z "$1" ] && printf "[error] missing script name\n" && exit 1

	# check if file is exist and is a regular file
	[ ! -f "$directory/${1}.sh" ] && printf "[error] file not found\n" && exit 1

	# extract the information from the file
	awk -F: 'NR==3,NR==6 {printf "%15s |%s\n", substr($1,3), $2}' $directory/${1}.sh

	exit 0
}



# arg_parser
arg_parser ()
{
	# Check if there is no argument and if true show usage and exit 1
	[ $# -eq 0 ] && usage exit 1

	# Cycle all the arguments 
	for args in $@
	do
		# Parse each argument to its function and set 
		case $args in
			-l | --list) 	logo; 	script_list						;;
			-s | --search)	logo; 	script_search	"$2" ; shift 2	;;
			-i | --info)	logo;	script_info		"$2" ; shift 2	;;
			-h | --help)			usage							;;
			-v | --version) 		version 						;;
			*)						usage							;;
		esac
	done
}



# Init
arg_parser "$@"

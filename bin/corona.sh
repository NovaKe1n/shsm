#!/usr/bin/bash

#title|corona
#version|0.1
#author|0ero1ne
#info|coronavirus updater parser from https://corona-stats.online


# TODO
#   - todo example


# Global variables
version=0.1

#pdf
pdf ()
{
	wkhtmltopdf "https://corona-stats.online/?source=2" ~/Documents/corona_update/corona_status_full.pdf
	nohup qpdfview ~/Documents/corona_update/corona_status_full.pdf &>/dev/null &
}


# send mail
mailcorona () {
	wkhtmltopdf -s B3 "https://corona-stats.online/" ~/Documents/corona_update/corona_status_full.pdf
	wkhtmltopdf -s A4 "https://corona-stats.online?source=1" ~/Documents/corona_update/corona_status_jhu.pdf
	
	python ~/Github/shsm/bin/coronaNews
	
	libreoffice --convert-to pdf:writer_pdf_Export --outdir ~/Documents/corona_update/ ~/Documents/corona_update/news
	
	mutt -s "[$(date)] Covid-19 update" \
		 -b corona \
		 -a ~/Documents/corona_update/corona_status_full.pdf \
		    ~/Documents/corona_update/corona_status_jhu.pdf \
			~/Documents/corona_update/news.pdf -- \
		< ~/Documents/corona_update/message
}


# full status
full ()
{
	curl -s "https://corona-stats.online/?source=2&minimal=true"

	exit 0
}


#location function
location ()
{
	[ -z "$1" ] && usage
	curl -s "https://corona-stats.online/${1}?source=2&minimal=true"

	exit 0
}

# world function
world ()
{
		curl -s "https://corona-stats.online?source=2&minimal=true" | egrep 'World'	
		
		exit 0
}


# usage
usage ()
{
	printf """
$(basename $0) [options] [location]

Options:
  -a --all		display full status
  -l --location		location status
  -m --mail		send a pdf via email to Bcc list
  -p --pdf		download update as pdf and open it
  -w --world		world current status

  -h --help		help and usage
  -v --version		current version of the script

"""
	exit 0
}


# version
version ()
{
	printf "$(basename $0) $version\n"
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
			-a|--all)		full					;;
			-l|--location)	location "$2"; shift 2	;;
			-m|--mail)		mailcorona				;;
			-p|--pdf)		pdf						;;
			-w|--world)		world	 				;;
			-h|--help)      usage					;;
			-v|--version) 	version 				;;
			*)				usage					;;
		esac
	done
}


# Init
arg_parser "$@"

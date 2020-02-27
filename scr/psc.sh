#!/usr/bin/env bash

# Title: psc
# Version: 0.1
# Author: 0ero1ne
# Description: check if a process is running

help() { printf "[X] %s %s\n" "$0" "<process name>"; exit 1; }

[ $# -ne 1 ] && help 

if pgrep $1 &> /dev/null; then
	while read pid; do
		printf "[-] %7s -> %s\n" \
			"$pid" \
			"$(ps aux | grep -m1 $pid | tr -s ' ' | cut -d' ' -f11-)"
	done < <(pgrep $1)
else
	printf "%s\n" "[X] Process not running..."
fi

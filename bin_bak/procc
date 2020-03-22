#!/usr/bin/bash

#title|procc
#version|0.1
#author|0ero1ne
#info|check if a process is running or not

PROCESS=$1

if [ $# -eq 0 ]; then
	echo "Give me a process name..."
	exit 0
fi

if pidof $PROCESS > /dev/null; then
	echo "Running";
else
	echo "Not running"
fi

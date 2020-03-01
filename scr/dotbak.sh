#!/usr/bin/env bash

# Title: dotbak 
# Version: 0.1
# Author: 0ero1ne 
# Description: backup all .dotfiles

gitdir='/home/null/Github/mothership/.dotfiles'

printf "[*] .dotfiles cloud backup\n\n"

printf "[+] Copying files...\n"
cp -r -v -t $gitdir ~/.bashrc ~/.vimrc ~/.dotfiles &> /dev/null

if [ -n "$(git -C $gitdir status -s)" ]; then
	printf "[+] Committing...\n"
	git -C $gitdir commit $gitdir -m ".dotfiles backup" &> /dev/null
fi

if [[ "$(git -C $gitdir commit | awk 'NR==3 {print substr($3,1,4)}')" =~ "push" ]]; then
	printf "[+] Uploading...\n\n"
	git -C $gitdir push &> /dev/null
	
	[ $? -eq 0 ] && printf "\n[*] Done\n" || printf "\n[X] Authentication failed...\n"

else
	printf "\n[*} Everything is up to date.\n"
fi

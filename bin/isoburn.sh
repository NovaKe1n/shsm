#!/usr/bin/bash

#title|isoburn
#version|1.0
#author|0ero1ne
#info|burn a .iso into a USB drive

clear

printf "\n${Yellow}--- [ USB devices ] ---\n\n${NC}"

if [ ! -z "$(diskutil list external)" ]; then	
	diskutil list external
	printf "${Green}Choose one disk: ${NC}"; read disk
else
    printf "${Red}No USB device found, please insert one\n\n"
    exit 1
fi

if [ -b "$disk" ]; then
    #echo "$disk is block device - continuing"
    printf "${Green}New device name: ${NC}"; read name
	
	clear
	printf "\n${Yellow}--- [ ISO ~/ ] ---\n\n${NC}"
	find ~ -type f -maxdepth 2 -iname "*.iso"
	
	printf "\n${Green}Image: ${NC}"; read iso
	
	if [ -f "$iso" ]; then
		clear
		printf "\n${Yellow}--- [ Summary ] ---\n${NC}"
		printf "\n${Green}Write ${NC}$iso ${Green}to ${NC}'$disk'"
		printf "\n${Green}Erase disk ${NC}'$disk' ${Green}and label it ${NC}'$name'\n\n"
		read -n 1 -r -p "${Yellow}Continue ${NC}(Y/n)? " myCont
		case $myCont in
    		Y|y)    # Fall through - expected case
					clear
					printf "\n${Yellow}--- [ Formatting ] ---${NC}\n\n"
					diskutil eraseDisk FAT32 $name MBR $disk
				
					printf "\n${Yellow}--- [ Unmount ] ---${NC}\n\n"
					diskutil unmountDisk $disk
		        
        			printf "\n${Yellow}--- [ Burning ] ---\n\n${NC}"
					sudo dd if=$iso | pv -s $(stat -f ‘%z’ “$iso”) | sudo dd of=$disk bs=1m
				
					printf "\n\n${Green} Operation completed\n"	    
            		;;
    		*)      # Anything else...abort
            		printf "\n${Red}Quitting...\n"
            		exit 1
            		;;
		esac			
	else
		printf "\n${Red}File doesn't exist\n\n"
    	exit 1
    fi
else
	printf "\n$disk ${Red}is NOT a block device - exiting\n\n"
	exit 1
fi



#!/usr/bin/env bash

# Title: reset_usb
# Version: 0.1
# Author: 0ero1ne 
# Description: restart all usb ports

for i in /sys/bus/pci/drivers/[uoex]hci_hcd/*:*; do
  [ -e "$i" ] || continue
  #echo "${i##*/} > ${i%/*}/unbind"
  echo "${i##*/}" > "${i%/*}/unbind"
  echo "${i##*/}" > "${i%/*}/bind"
done

for i in /sys/bus/pci/drivers/ehci-pci/*:*; do
  [ -e "$i" ] || continue
  #echo "${i##*/} > ${i%/*}/unbind"
  echo "${i##*/}" > "${i%/*}/unbind"
  echo "${i##*/}" > "${i%/*}/bind"
done

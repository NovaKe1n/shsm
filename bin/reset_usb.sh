#!/usr/bin/bash

#title|reset_usb
#version|0.1
#author|0ero1ne 
#info|restart all usb ports

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

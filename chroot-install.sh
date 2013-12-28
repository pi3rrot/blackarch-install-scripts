#!/bin/bash

# key problem - will be solved later on
pacman-key --init
pacman -Syyu --noconfirm
pacman-key -r 4345771566D76038C7FEB43863EC0ADBEA87E4E3
pacman-key --lsign-key 4345771566D76038C7FEB43863EC0ADBEA87E4E3
pacman -Syy
 
pacman -S blackarch
pacman -S grub --noconfirm
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

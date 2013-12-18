#!/bin/bash

pacman -S grub --noconfirm
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

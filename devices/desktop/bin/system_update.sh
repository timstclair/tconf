#!/bin/bash

echo "Did you check the new?"
google-chrome "https://www.archlinux.org/news/"

echo "Mounting /boot ..."
sudo mount /boot

echo "Updating ARCH packages..."
sudo pacman -Syu

echo "Updating AUR packages..."
yaourt -Syua

echo "Unmounting boot..."
sudo umount /boot

#!/bin/bash

echo "Did you check the news?"
read -rsp $'Press any key to continue...\n' -n1 key

echo "Mounting /boot ..."
sudo mount /boot

echo "Updating ARCH packages..."
sudo pacman -Syu

echo "Updating AUR packages..."
yaourt -Syua

echo "Unmounting boot..."
sudo umount /boot

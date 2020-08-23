#!/usr/bin/env sh

sudo apt-get update
sudo apt-get install -y linux-headers-$(uname -r) build-essential dkms

sudo mkdir /media/VBoxGuestAdditions
sudo mount -o ro /dev/sr1 /media/VBoxGuestAdditions
sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
sudo umount /media/VBoxGuestAdditions
sudo rmdir /media/VBoxGuestAdditions
sudo rm /home/user/VBoxGuestAdditions.iso

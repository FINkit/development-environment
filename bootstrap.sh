#!/usr/bin/env bash

###############################################################################################
## Update the packages                                                                       ##
###############################################################################################
echo "Performing apt-get update"
sudo apt-get -qq update >/dev/null 2>/dev/null

###############################################################################################
## Check whether this environment has already been provisioned                               ##
###############################################################################################
if [ -f /var/vagrant_provision ]
then
  echo "Environment already provisioned, exiting..."
  exit 0
fi

touch /var/vagrant_provision

###############################################################################################
## Install VirtualBox Guest Additions                                                        ##
###############################################################################################
sudo apt-get -y --force-yes -qq install build-essential linux-headers-`uname -r`
sudo apt-get -y --force-yes -qq install xserver-xorg xserver-xorg-core
wget http://download.virtualbox.org/virtualbox/4.3.30/VBoxGuestAdditions_4.3.30.iso
sudo mkdir /media/VBoxGuestAdditions
sudo mount -o loop,ro VBoxGuestAdditions_4.3.30.iso /media/VBoxGuestAdditions
sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
rm VBoxGuestAdditions_4.3.30.iso
sudo umount /media/VBoxGuestAdditions
sudo rmdir /media/VBoxGuestAdditions

###############################################################################################
## Install upstart for use with ubuntu vivid OS                                              ##
###############################################################################################
echo "Installing upstart for ubuntu vivid"
sudo apt-get -y --force-yes -qq install upstart-sysv >/dev/null 2>/dev/null

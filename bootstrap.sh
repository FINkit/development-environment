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

###############################################################################################
## Install upstart for use with ubuntu vivid OS                                              ##
###############################################################################################
echo "Installing upstart for ubuntu vivid"
sudo apt-get -y --force-yes -qq install upstart-sysv >/dev/null 2>/dev/null

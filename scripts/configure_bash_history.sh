#!/usr/bin/env bash
###############################################################################################
## Check whether this environment has already been provisioned                               ##
###############################################################################################
if grep -q 'HISTFILE' '/etc/environment';
    then
        echo "bash history has already been configured, exiting..."
        exit 0
fi

###############################################################################################
## Configuring bash history                                                                  ##
###############################################################################################

echo "Setting bash history directory ownership"
sudo chown vagrant:vagrant /bash_history

echo "Configuring bash history regular backups"

sudo echo "HISTFILE=/bash_history/.bash_history" >> /etc/environment
sudo echo "PROMPT_COMMAND=history -a" >> /etc/environment


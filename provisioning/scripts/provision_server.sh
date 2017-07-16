#!/bin/bash

echo "Provisioning server"
export GUEST_USER=`whoami`

echo "Server provisioning (using ansible)"
/bin/bash $HOME/myenv/provisioning/scripts/ansible_server.sh

echo "Done server provisioning"

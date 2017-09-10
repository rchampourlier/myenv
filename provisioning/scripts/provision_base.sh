#!/bin/bash

echo "Provisioning myenv"
export GUEST_USER=`whoami`

echo "Cloning myenv repository"
rm -Rf $HOME/myenv
git clone https://github.com/rchampourlier/myenv.git $HOME/myenv
cd $HOME/myenv && git fetch && git checkout $MYENV_BRANCH

echo "Creating a dev directory"
mkdir -p $HOME/dev
cd $HOME/dev

echo "Prepare provisioning"
$HOME/myenv/prepare_provisioning.sh

echo "Common myenv provisioning (using ansible)"
$HOME/myenv/provisioning/scripts/ansible_base.sh

echo "Done provisioning myenv"

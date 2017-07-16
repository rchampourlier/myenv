#!/bin/bash

echo "Installing dependencies"

echo "Updating package list"
sudo apt-get update -y

echo "Installing ansible"
sudo apt-get install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update -y
sudo apt-get install ansible -y

echo "Installing git"
sudo apt-get install git -y

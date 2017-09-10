#!/usr/bin/env bash

echo" Installing dependencies"

echo "Update brew"
brew update

echo "Installing ansible"
brew install ansible
brew upgrade ansible


#!/bin/bash

ansible-playbook --ask-sudo-pass -i "localhost," -c local $HOME/myenv/provisioning/playbook_server.yml


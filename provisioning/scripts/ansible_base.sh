#!/bin/bash

ansible-playbook --ask-become-pass -i "localhost," -c local $HOME/myenv/provisioning/playbook_base.yml

#!/bin/bash

# This script is expected to be executed through the following
# command, executed by the root user, on the server:
#
# ```
# curl https://raw.githubusercontent.com/rchampourlier/myenv/master/start_remote.sh > start_remote.sh && /bin/bash start_remote.sh
# ```
#
# Prerequisites:
#   - GUEST_USER must be set
#   - MYENV_BRANCH must be set

REPO=https://raw.githubusercontent.com/rchampourlier/myenv/$MYENV_BRANCH

# Using $TIME to ensure curl is fetching a new version and not
# using a cached one.
TIME=$(date -Is)

# Install dependencies
curl $REPO/provisioning/scripts/install_deps.sh?$TIME > install_deps.sh
/bin/bash install_deps.sh

# Provision base
curl $REPO/provisioning/scripts/provision_base.sh?$TIME > provision_base.sh
MYENV_BRANCH=$MYENV_BRANCH /bin/bash provision_base.sh

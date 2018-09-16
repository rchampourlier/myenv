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

# Create user
curl $REPO/provisioning/scripts/create_user.sh?$TIME > create_user.sh
/bin/bash create_user.sh

# Install dependencies
curl $REPO/provisioning/scripts/install_deps.sh?$TIME > install_deps.sh
/bin/bash install_deps.sh

# Provision base
echo "export MYENV_BRANCH=$MYENV_BRANCH" > provision_base.sh
curl $REPO/provisioning/scripts/provision_base.sh?$TIME >> provision_base.sh
sudo /bin/bash provision_base.sh

# Provision server
curl $REPO/provisioning/scripts/provision_server.sh?$TIME > provision_server.sh
sudo /bin/bash provision_server.sh

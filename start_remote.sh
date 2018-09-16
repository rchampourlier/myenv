#!/bin/bash

# This script is expected to be executed through the following
# command, executed by the "guest" user (e.g. ubuntu, non-root),
# on the server:
#
# ```
# export MYENV=master
# curl https://raw.githubusercontent.com/rchampourlier/myenv/master/start_remote.sh > start_remote.sh && /bin/bash start_remote.sh
# ```

GUEST_USER=$(whoami)
REPO=https://raw.githubusercontent.com/rchampourlier/myenv/$MYENV_BRANCH

# Using $TIME to ensure curl is fetching a new version and not
# using a cached one.
TIME=$(date -Is)

# Install dependencies
curl $REPO/provisioning/scripts/install_deps.sh?$TIME > install_deps.sh
/bin/bash install_deps.sh

# Provision base
echo "export MYENV_BRANCH=$MYENV_BRANCH" > provision_base.sh
curl $REPO/provisioning/scripts/provision_base.sh?$TIME >> provision_base.sh
sudo -u $GUEST_USER /bin/bash provision_base.sh

if [ $? -eq 0 ]
then
  # Provision server
  curl $REPO/provisioning/scripts/provision_server.sh?$TIME > provision_server.sh
  sudo -u $GUEST_USER /bin/bash provision_server.sh
else
  echo "Base provisioning failed.
fi

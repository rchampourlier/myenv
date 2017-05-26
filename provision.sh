#!/usr/bin/env bash

ROOT=$(pwd)
DIR="$ROOT/myenv"

# Clear roles directory (though it should be)
rm -Rf $DIR/provisioning/roles
mkdir -p $DIR/provisioning/roles

# Fetch external roles
while read role || [[ -n $role ]]; do
  # Reads every line in roles_dep.txt (even if the last line is
  # not newline-terminated)
  echo "Cloning role $role"
  cd $DIR/provisioning/roles && git clone $role
done <$DIR/provisioning/roles_dep.txt
cd $ROOT

# Link local roles
LOCAL_ROLES=$DIR/provisioning/roles_local/*
for role in $LOCAL_ROLES
do
  role_name=$(basename $role)
  echo "Linking local role $role_name"
  cd $DIR/provisioning/roles && ln -s ../roles_local/$role_name $role_name
done
cd $ROOT

# Provisioning the VM
vagrant provision

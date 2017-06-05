DIR="../myenv"

# Install Ansible locally to download role playbooks
# TODO: restore install with a test to ensure it's not already there
# brew install ansible

# Link vagrant-related files
ln -sf $DIR/Vagrantfile ./

# Handle provisioning
$DIR/prepare_provisioning.sh

vagrant up

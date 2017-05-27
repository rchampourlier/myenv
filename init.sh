DIR="./myenv"

# Install Ansible locally to download role playbooks
# brew install ansible

# Link vagrant-related files
ln -sf $DIR/Vagrantfile .
ln -sf $DIR/provisioning $DIR/Vagrant-Provisioning

# Handle provisioning
$DIR/provision.sh

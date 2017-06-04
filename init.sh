DIR="./myenv"

# Install Ansible locally to download role playbooks
# brew install ansible

# Link vagrant-related files
ln -sf $DIR/Vagrantfile .

# Handle provisioning
$DIR/prepare_provisioning.sh

vagrant up

#!/bin/bash

GUEST_USER_GROUPS=adm,dialout,cdrom,floppy,sudo,audio,dip,video,plugdev,netdev

echo "Creating user '$GUEST_USER'"
adduser $GUEST_USER --disabled-password --gecos ""
usermod -G $GUEST_USER_GROUPS $GUEST_USER

echo "Setting password for user '$GUEST_USER'"
passwd $GUEST_USER

echo "Copying the authorized keys for '$GUEST_USER'"
sudo -u $GUEST_USER mkdir /home/$GUEST_USER/.ssh
cp $HOME/.ssh/authorized_keys /home/$GUEST_USER/.ssh/authorized_keys
chown $GUEST_USER:$DEFAULT_GROUP /home/$GUEST_USER/.ssh/authorized_keys

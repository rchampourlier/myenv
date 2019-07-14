# myenv (another development environment setup option)

Build your development environment:

- On your local machine (macOS only) or in Vagrant to contain your environment inside a dedicated machine (local VM, remote server...)
- Provision the environment using Ansible (for programs, libraries, development tools...)
- Load your dotfiles directly from the repo

The environment is provisioned with my personal setup:

- Shell: zsh, prezto and powerlevel9k
- Some Ruby versions (using rbenv)
- Vim (8, installed from the source). With vim-plug and custom settings.

**NB: this environment is provisioned _for me_! Though you could totally use it to build your own environment, I recommend you to fork it and adjust it to your needs.**

## Prerequisites

- You should use iTerm as a terminal application on MacOS X. To have your tmux buffer automatically copied to your macOS' clipboard, simply enable the "Applications in terminal may access clipboard" option in iTerm.
- If you want to develop within Vagrant, it must be installed and working with a default provider.

## Getting started

If you want to have several environment, e.g. one for work, one for personal projects, you can have the following directories:

- `/some/path/myenv`
- `/some/path/work`
- `/some/path/personal`

### On a MacOS host

Prerequisites:

- Working installation of Homebrew.

```
cd ~
git clone https://github.com/rchampourlier/myenv.git
myenv/provisioning/scripts/install_deps_osx.sh
myenv/prepare_provisioning.sh
myenv/provisioning/scripts/ansible_base.sh

```

### On a local VM (using Vagrant and VirtualBox provider)

```
# Init
git clone https://github.com/rchampourlier/myenv.git $HOME/myenv
cd /some/path/work
$HOME/myenv/init_vagrant.sh

# Connect
vagrant ssh

# On the guest, connected as ubuntu ($GUEST_USER)
export GUEST_USER=ubuntu
export MYENV_BRANCH=master
curl https://raw.githubusercontent.com/rchampourlier/myenv/$MYENV_BRANCH/start_vagrant.sh > start_vagrant.sh && /bin/bash start_vagrant.sh
```

### On a remote server

```
# Connected as the guest user (e.g. `ubuntu`)
export MYENV_BRANCH=master
curl https://raw.githubusercontent.com/rchampourlier/myenv/$MYENV_BRANCH/start_remote.sh > start_remote.sh && /bin/bash start_remote.sh
```

To connect easily and forward your SSH keys, edit your `~/.ssh/config` file and add this:

```
Host myenv
  Hostname 123.456.789.012
  User ubuntu
  ForwardAgent yes
```

### Manual finish

#### SSH keys

- Generate SSH keys for Github, Gitlab and Bitbucket with `ssh-keygen -t rsa -b 4096 -C "email@host+service"`
- Add the generated public keys to each service

#### GPG keys

**1. Create a subkey from your master key**

This subkey will be sent to the server so it can be revoked if it leaks.

1. Find your key ID: `gpg --list-keys yourname`.
2. `gpg --edit-key YOURMASTERKEYID`.
3. At the gpg> prompt: `addkey`.
4. This asks for your passphrase, type it in.
5. Choose the "RSA (sign only)" key type.
6. It would be wise to choose 4096 (or 2048) bit key size.
7. Once your done, be sure to type `save`

(NB: tutorial from https://wiki.debian.org/Subkeys)

**2. Find the subkey ID**

1. `gpg --edit-key YOURMASTERKEYID`
2. You should find the new subkey in the list with its ID following `rsa4096`
   if you chose this algo/size.
3. Export the subkeys: `gpg --output $HOME/subkeys.gpg --export-secret-subkeys SUBKEY_ID`
4. Copy the exported subkeys to the server: `scp $HOME/subkeys.gpg $GUEST_USER@$HOST:~/subkeys.gpg`
5. On the remote server, import the subkeys: `gpg --import subkeys.gpg && gpg2 --import subkeys.gpg`
6. Check on the server that `gpg -K` displays `sec#` and not `sec`, meaning the secret key is not
   present for your master key.

#### Password store

- Clone PasswordStore repository into ~/.password-store.
- Test you can correctly decrypt passwords. The GPG subkeys imported earlier should work.

## How to...

### Add a new component using Ansible

If you have an Ansible role (e.g. opensource):

- Add the role's URL to `provisioning/roles_dep.txt`
- Run `prepare_provisioning.sh`
- Reprovision with `myenv/provisioning/scripts/ansible_base.sh`

### Add a vim plugin

- Edit `configuration/runcoms/vimrc` and add the desired `Plug...` in the "Load plugins" section.
- Run `vagrant provision` (on the host)

### Install a new system package

- If it's a system common package, add it to `provisioning/roles_local/system`.
- Otherwise, create the appropriate role and add it to `provisioning/playbook.yml`.

### Update / replay provisioning

This replays the Ansible playbooks:

```
$HOME/myenv/provisioning/scripts/ansible_base.sh
$HOME/myenv/provisioning/scripts/ansible_server.sh
```

### Use Pass

[Pass](https://www.passwordstore.org/) is installed for password management. The storage must be retrieved manually, as well as the GPG secret key.

### Use nvm

_NB: nvm is not provisioned on macOS, Node is installed directly through Homebrew instead._

To use nvm, you must source it first:

    source-nvm

It's not sourced by default to prevent slowing down of the terminal loading.

### Have copy-paste working between a macOS client and your server

Update your host's `~/.ssh/config` file with the following section:

```
Host dev
  HostName <HOSTNAME>
  User ubuntu
  ForwardAgent yes
  ForwardX11 yes
  XAuthLocation /opt/X11/bin/xauth
```

- Install XQuartz
- Replace `<HOSTNAME>` with your server's hostname
- Change the `XAuthLocation` depending on your SSH client's environment

## Troubleshooting

### Ansible setup failing at 1st run

When you run the `start_remote` and `start_vagrant` scripts for the 1st time on a given machine, the Ansible provisioning script may fail before the end. This is due to the fact that some tasks require some prerequisites installed by Ansible to be loaded. For now, the solution is to log out and log in back and replay the provisioning scripts (see "Update / replay provisioning" above).

A more appropriate solution would be to split the provisioning in two phases:

1. bootstrapping,
2. provisioning, and logout/login after bootstrapping.

## Known limitations

Several Ansible roles are really simple and, while they should generally do the job of provisioning some component, they may not be idem-potent, efficient, or be able to perform upgrades. Improving these roles or relying on community-maintained ones is a todo.

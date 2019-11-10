# myenv (another development environment setup option)

Build your development environment on a macOS machine:

- On your local machine to contain your environment inside a dedicated machine (local VM, remote server...)
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

**Prerequisites:**

- Working installation of Homebrew.

```
cd ~
git clone https://github.com/rchampourlier/myenv.git
myenv/provisioning/scripts/install_deps_osx.sh
myenv/prepare_provisioning.sh
myenv/provisioning/scripts/ansible_base.sh

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

You should also regularly update the Ansible recipes depended on. For this,
replay the `prepare_provisioning` script:

```
$HOME/myenv/prepare_provisioning
```

### Use Pass

[Pass](https://www.passwordstore.org/) is installed for password management. The storage must be retrieved manually, as well as the GPG secret key.

## Troubleshooting

## Known limitations

Several Ansible roles are really simple and, while they should generally do the job of provisioning some component, they may not be idem-potent, efficient, or be able to perform upgrades. Improving these roles or relying on community-maintained ones is a todo.

# myenv (another development environment setup option)

Build your development environment:

- Use Vagrant to contain your environment inside a dedicated machine (local VM, remote server...)
- Provision the environment using Ansible (for programs, libraries, development tools...)
- Load your dotfiles directly from the repo

The environment is provisioned with my personal setup:

- Shell: zsh, prezto and powerlevel9k
- Some Ruby versions (using RVM)
- Vim (8, installed from the source). With vim-plug and custom settings.

**NB: this environment is provisioned _for me_! Though you could totally use it to build your own environment, I recommend you to fork it and adjust it to your needs.**

## Prerequisites

- Vagrant must be installed and working with a default provider.
- You should user iTerm as a terminal application on MacOS X. To have your tmux buffer automatically copied to your macOS' clipboard, simply enable the "Applications in terminal may access clipboard" option in iTerm.

## Getting started

If you want to have several environment, e.g. one for work, one for personal projects, you can have the following directories:

/some/path/myenv
/some/path/work
/some/path/personal

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
git clone https://github.com/rchampourlier/myenv.git /some/path/myenv
cd /some/path/work
../myenv/init_vagrant.sh

# Connect
vagrant ssh

# On the guest, connected as ubuntu ($GUEST_USER)
export GUEST_USER=ubuntu
export MYENV_BRANCH=master
curl https://raw.githubusercontent.com/rchampourlier/myenv/$MYENV_BRANCH/start_vagrant.sh > start_vagrant.sh && /bin/bash start_vagrant.sh
```

### On a remote server

```
# Connected as root
export GUEST_USER=ubuntu
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

## How to...

### Add a vim plugin

- Edit `configuration/runcoms/vimrc` and add the desired `Plug...` in the "Load plugins" section.
- Run `vagrant provision` (on the host)

### Install a new Ubuntu package

- If it's a system common package, add it to `provisioning/roles_local/system`.
- Otherwise, create the appropriate role and add it to `provisioning/playbook.yml`.

### Update / replay provisioning

This replays the Ansible playbooks:

```
$HOME/myenv/provisioning/scripts/ansible_base.sh
$HOME/myenv/provisioning/scripts/ansible_server.sh
```

## Troubleshooting

### Ansible setup failing at 1st run

When you run the `start_remote` and `start_vagrant` scripts for the 1st time on a given machine, the Ansible provisioning script may fail before the end. This is due to the fact that some tasks require some prerequisites installed by Ansible to be loaded. For now, the solution is to log out and log in back and replay the provisioning scripts (see "Update / replay provisioning" above).

A more appropriate solution would be to split the provisioning in two phases, 1. bootstrapping, 2. provisioning, and logout/login after bootstrapping.

## Known limitations

Several Ansible roles are really simple and, while they should generally do the job of provisioning some component, they may not be idem-potent, efficient, or be able to perform upgrades. Improving these roles or relying on community-maintained ones is a todo.

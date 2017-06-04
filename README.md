# myenv (another development environment setup option)

Build your development environment:

- Use Vagrant to contain your environment inside a dedicated machine (local VM, remote server...)
- Provision the environment using Ansible (for programs, libraries, development tools...)
- Load your dotfiles directly from the repo

The environment is provisioned with my personal setup:

- Shell: zsh, prezto and powerlevel9k
- Some Ruby versions (using RVM)
- Vim (8, installed from the source). With vim-plug and custom settings.

## Prerequisites

- Vagrant must be installed and working with a default provider

## Getting started

Provision the environment and connect to it:

```
cd some/path
git clone https://github.com/rchampourlier/myenv.git
myenv/init.sh
vagrant ssh
```

## How to...

### Add a vim plugin

- Edit `configuration/runcoms/vimrc` and add the desired `Plug...` in the "Load plugins" section.
- Run `vagrant provision` (on the host)

### Upgrade

- Run `vagrant provision` (on the host)

## On choices

- Why did I chose **zsh**: it seems to be the most used and I love to have options and a big community.

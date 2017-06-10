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

- Vagrant must be installed and working with a default provider

## Getting started

If you want to have several environment, e.g. one for work, one for personal projects, you can have the following directories:

/some/path/myenv
/some/path/work
/some/path/personal

```
cd /some/path
git clone https://github.com/rchampourlier/myenv.git
cd work
../myenv/init.sh
vagrant ssh
```

## How to...

### Add a vim plugin

- Edit `configuration/runcoms/vimrc` and add the desired `Plug...` in the "Load plugins" section.
- Run `vagrant provision` (on the host)

### Install a new Ubuntu package

- If it's a system common package, add it to `prvosioning/roles_local/system`.
- Otherwise, create the appropriate role and add it to `provisioning/playbook.yml`.

### Upgrade

- Run `vagrant provision` (on the host)

## Known limitations

- Several Ansible roles are really simple and, while they should generally do the job of provisioning some component, they may not be idem-potent, efficient, or be able to perform upgrades. Improving these roles or relying on community-maintained ones is a todo.

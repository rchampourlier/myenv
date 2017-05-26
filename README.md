# my-env (another development environment setup option)

## Introduction

I was using a full-fledged setup provided by YADR. However, it was kinda of slow and I didn't know nor understood most of its configuration. Some things were not working perfectly (e.g. ctags), and not having them configured in the first place made it daunting to fix them. Another motivation was to improve my knowledge of the tools.

In order to continue working with the same level of proficiency, in particular for work, I decided to build a new environment contained in a dedicated server, and only migrate my personal projects for now. This would allow me to separate work from personal projects by moving them to this dedicated container. I would start with a local container first (Virtual Machine), but I would then be able to move it to a remote server to enable working from any internet-connected machine with a terminal.

## General principle

- Creates a local environment within a Vagrant-manager Virtual Machine.
- Requires Vagrant and a provider (VirtualBox by default) to be provisioned.
- Provisions the Vagrant box using ansible-local.

## How to

**Prerequisites**

- Install Vagrant

```
cd some/path
git clone https://github.com/rchampourlier/my-env.git
my-env/init.sh
```

## Choices

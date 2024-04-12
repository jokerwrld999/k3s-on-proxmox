# Ansible Template Playbook

This Ansible template provides a base for provisioning Linux systems with
pre-updated distros and necessary tweaks. It streamlines the process of adding
desired software and bootstrapping your servers.

## Pre-commit Commands

```
pre-commit install
pre-commit run -a
```

## Setting SSH Key-Based Authentication

1. Generate an ssh key

```
ssh-keygen -t ed25519 -C "Default key"
```

2. Copy the ssh key to the server(s)

```
ssh-copy-id -i ~/.ssh/id_ed25519.pub <IP Address>
```

3. Generate an ssh key that’s going to be specifically used for Ansible

```
ssh-keygen -t ed25519 -C "ansible"
```

4. Copy the ssh key to the server(s)

```
ssh-copy-id -i ~/.ssh/ansible.pub
```

## Export Env Variables

- Export Environment Variables

```
export CUSTOM_USER=

export REGISTRY_URL=
export CONTAINER_NAME=
export DOCKER_IMAGE=
export PUBLISHED_PORTS=
export DOCKER_USERNAME=
export DOCKER_PASS=
```

- OR Modify the variables in `roles/pre-configure/vars/main.yml`

## Create Vault Pass

- Create `.vault_pass` file with password to decrypt Telegram Bot Tokens to use
  Telegram Alerts

## Run Ansible Playbooks

- Ensure that Ansible is installed on your Linux execute the following commands:

```
ansible-galaxy install -r requirements.yml &&
ansible-playbook local.yml
```

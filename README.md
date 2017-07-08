# Overview

This repo contains resources to help others understand Ansible

# Setup

These tutorials can be run anywhere that Ansible is installed.

To help my life easier there is a docker compose file that pulls in 5 containers to build a lab

```
./setup-docker-lab.sh
```

To make the training a little more relastic the lab contains:

- ansible conatiner
- web1 conatiner
- web2 conatiner
- backend1 conatiner
- backend2 conatiner

You can then access the docker container running ansible with:

```
docker exec -i -t ansibletraining_ansible_1 /bin/bash
```

# Setting up ansible

In the lab we have prepared this in advance but for users not using docker you'll need to:

- Setup SSH keys to access the nodes you want to manage (you can use passwords but this is sloppy)
- Setup an ansible hosts file like the one in ansible_config/ansible_hosts

# Test the installation

Test the install by running an ansible ping to all the nodes:

```
ansible -i /root/ansible_config/ansible_hosts all -m ping
```

# Basic scripting

## Running commands across your nodes

Run a simple echo across all nodes
```
ansible -i /root/ansible_config/ansible_hosts all -a "/bin/echo hello"
```

Or run the same command against just the webservers
```
ansible -i /root/ansible_config/ansible_hosts web_servers -a "/bin/echo hello"
```

## Writing code to action commands

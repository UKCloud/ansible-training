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

## Writing code to action commands (playbooks)

Start by SSHing to one of the nodes:

```
ssh ansibletraining_backend2_1
```

Notice how no message of the day is set

Now execute the message of the day playbook by running:

```
ansible-playbook playbooks/motd.yaml -i ansible_hosts
```

You'll see the playbook is very basic. It is using the copy module and specifies a motd we created under templates. 
It takes this template and copies it up to each server.

Ansible shows us the file is changed. If we re-ran the command nothing would change.

### Persistency

Now change the file on one of the servers by running:

```
ssh ansibletraining_backend2_1 "echo Naughty, we changed the message of the day > /etc/motd"
```

ssh back into the server and we'll see our new banner.

If you re-run the platybook you'll that only that node is arked as being changed.
SSHing back in after running the playbook will show our configuration is back in place.

# Troubleshooting

## dry-run

Taking the example above if we again change the message of the day on a single container:

```
ssh ansibletraining_backend2_1 "echo Naughty, we changed the message of the day > /etc/motd"
```

Then SSH to the server confirm the change. If we now run the playbook in a dry run with:

```
ansible-playbook playbooks/motd.yaml -i ansible_hosts --check
```

You can see in the output it tells us what the proposed changes are. If we SSH back to the server we see it hasn't actually made any changes.

## Versbose

If you get errors running playbooks it can be very useful to run ansible with verbose log output:

```
ansible-playbook playbooks/motd.yaml -i ansible_hosts --check -v
```

Will give us more detail about the proposed changes

you can increase verbosity by adding 'v's:

```
ansible-playbook playbooks/motd.yaml -i ansible_hosts --check -vvv
```

## Debug

It can also be useful to be able to print values from your playbokk itself. Especially as you start doing more advanced scripting using jinja templating.

In the first example we are going to use the command module to simply run an echo on each server:

```
ansible-playbook playbooks/without-debug.yaml -i ansible_hosts
```

This gives us limited information about the status of the command. By adding in a register option to the command and then printing the output with debug we can get far more information:

```
ansible-playbook playbooks/with-debug.yaml -i ansible_hosts
```

To see the difference between the two playbooks run:

```
diff playbooks/with-debug.yaml playbooks/without-debug.yaml
```

# Resources

There are many resources available for ansible. To find modules to interact with systems checkout:

http://docs.ansible.com/ansible/modules_by_category.html

For more details and advanced docs and tutorials checkout:

http://docs.ansible.com/ansible/intro.html


#!/bin/bash

mkdir .ssh
chmod 700 .ssh
yes | ssh-keygen -t rsa -N "" -f .ssh/id_rsa
cat .ssh/id_rsa.pub > .ssh/authorized_keys
docker-compose up -d

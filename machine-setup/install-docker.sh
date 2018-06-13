#!/bin/bash

set -e -u

printf 'This script is meant to be run on Debian/Ubuntuy && will restart the computer at the end\n'

apt-get update
apt-get install -qq -y tig git curl

curl -fsSL get.docker.com | bash -
usermod -a -G docker $USER

# Now to get docker-compose

curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) \
     -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

# Reboot is for the group ID to take affect
reboot

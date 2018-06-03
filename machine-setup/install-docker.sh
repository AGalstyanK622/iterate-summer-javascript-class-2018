#!/bin/bash

set -e -u

printf 'This script will restart the computer at the end\n'

apt-get update
apt-get install -qq -y tig git

curl -fsSL get.docker.com | bash -
usermod -a -G docker $USER
reboot

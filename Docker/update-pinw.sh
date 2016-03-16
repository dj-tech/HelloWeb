#!/bin/bash

cd /home/app
sudo -u app git pull --all
apt-get update
apt-get upgrade -y -o Dpkg::Options::="--force-confold"

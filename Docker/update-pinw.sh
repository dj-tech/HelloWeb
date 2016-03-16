#!/bin/bash

apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold" && apt-get clean
cd /home/app
sudo -u app git pull --all

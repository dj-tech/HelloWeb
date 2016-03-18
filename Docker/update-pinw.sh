#!/bin/bash

cd /home/app
git pull --all
apt-get update
apt-get upgrade -y -o Dpkg::Options::="--force-confold"

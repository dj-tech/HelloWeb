#!/bin/bash

test -f /home/app/.ssh/id_rsa.pub && exit 0
ssh-keygen -q -f /home/app/.ssh/id_rsa -N ""
chown --recursive app:app /data
exit 0

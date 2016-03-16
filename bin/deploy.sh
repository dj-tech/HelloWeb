#!/bin/bash
set -e

cd ~/pinw-deploy/Docker/
v=`date +%FH%H%M`

docker build -t pinw .
for cont in `docker ps -f name=pinw -q`
do
    docker rm -f $cont
done
docker run -d -P -e $PINW_NAME  --name "pinw.${v}" pinw

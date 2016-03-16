#!/bin/bash
set -e

cd ~/pinw-deploy/Docker/
v=`date +%FH%H%M`

docker build -t pinw .
for cont in `docker ps -f name=pinw -q`
do
    docker rm -f $cont
done
echo "Starting container pinw.${v} as $PINW_NAME"
docker run -d -e VIRTUAL_HOST=$PINW_NAME -v /home/pinw/pinw-data:/data --name "pinw.${v}" pinw

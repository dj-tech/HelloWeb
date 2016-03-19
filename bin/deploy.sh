#!/bin/bash
set -e

cd ~/pinw-deploy/Docker/
v=`date +%FH%H%M`

docker build -t algolab/pinw:${v} .
for cont in `docker ps -f name=pinw -q`
do
    docker rm -f $cont
done
echo "Starting container pinw.${v} as $PINW_NAME"
docker run -d -e VIRTUAL_HOST=$PINW_NAME -v ~/pinw-data:/home/app/data --name "pinw" algolab/pinw:${v}

# Cleanup unused images
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")

#!/bin/bash
set -e

test -f ./pinw-devel.conf && source ./pinw-devel.conf

v=`date +%FH%H%M`

test -z "$pinw_dir" && pinw_dir=$(find ~ -name 'pinw-dispatch.rb' | head -n 1 | xargs dirname)/..
test -z "$pinw_data_dir" && pinw_data_dir=~/pinw_main/data

cd ../Docker/
docker build -t pinwdev:${v} .
for cont in `docker ps -f name=pinw-dev -q`
do
    docker rm -f $cont
done
echo "Starting container pinwdev.${v}"
echo "pinw_dir=""$pinw_dir"
echo "pinw_data_dir=""$pinw_data_dir"

docker run -d -P -p 3000:80 -v "$pinw_dir":/pinw -v "$pinw_data_dir":/data --name "pinw-dev" pinwdev:${v}

# Si suppone che il progetto nel host os sia funzionante cioè con il db già inizializzato (rake db:setup)

#!/bin/bash
set -e

cd ../Docker/

docker build -t pinw .
docker run -d -P  --name "pinw1" pinw

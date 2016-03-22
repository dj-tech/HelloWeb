#!/bin/bash
set -e

cd ../Docker/

docker build -t pinwdev .
# docker run -d -P -v path/to/hostdirectory/pinw_main/pinw:/pinw -v path/to/hostdirectory/pinw_main/data:/data pinwdev
docker run -d -P -v ~/pinw_main/pinw:/pinw -v ~/pinw_main/data:/data pinwdev

# eg. docker docker run -d -P -v home/andrea/pinw_main/pinw:/pinw -v home/andrea/pinw_main/data:/data pinwdev

# Si suppone che il progetto nel host os sia funzionante cioè con il db già inizializzato (rake db:setup)

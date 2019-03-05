#!/usr/bin/env bash
sudo docker stop gophish 2>/dev/null
sudo docker rm gophish 2>/dev/null
sudo docker build . --force-rm -t edoz90:gophish

sudo docker run -d -p 3333:3333 -p 80:80 -p 443:443 -v $(pwd)/config_default.json:/app/config.json -v $(pwd)/database:/app/database --name gophish edoz90:gophish

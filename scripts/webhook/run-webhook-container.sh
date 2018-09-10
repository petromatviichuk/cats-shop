#!/usr/bin/env bash
#Description
#Pull latest webhook image from registry and recreate container
DOCKER_REGISTRY=$1
docker pull $DOCKER_REGISTRY/webhook:latest
docker stop webhook
docker rm webhook
docker run --name webhook -p 5001:5000 -d $DOCKER_REGISTRY/webhook:latest
docker exec webhook mkdir -p /root/.aws
docker exec webhook chmod 700 /root/.aws
docker cp .aws/credentials webhook:/root/.aws/credentials
docker cp .aws/config webhook:/root/.aws/config
docker exec webhook chown -R root:root /root/.aws
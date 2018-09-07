#!/usr/bin/env bash
SHA=$1
DOCKER_REGISTRY=$2

echo '{ "insecure-registries" : ["'$DOCKER_REGISTRY'"] }' | sudo tee /etc/docker/daemon.json
docker --version
sudo cat /etc/docker/daemon.json
sudo service docker restart
docker build -t $DOCKER_REGISTRY:$SHA .
docker push $DOCKER_REGISTRY:$SHA
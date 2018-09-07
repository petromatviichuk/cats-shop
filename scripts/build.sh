#!/usr/bin/env bash
#Description:
#There are following input parameters:
# SHA - Pull request hash
# DOCKER_REGISTRY - hostname of private docker registry
# DOCKER_APP - application name 
# The script does following:
# 1. Allow docker to communicate with private docker registry
# 2. Build the application from local Dockerfile
# 3. Push docker image to private registry

SHA=$1
DOCKER_REGISTRY=$2
DOCKER_APP=$3

echo '{ "insecure-registries" : ["'$DOCKER_REGISTRY'"] }' | sudo tee /etc/docker/daemon.json
sudo service docker restart
docker build -t $DOCKER_REGISTRY/$DOCKER_APP:$SHA .
docker push $DOCKER_REGISTRY/$DOCKER_APP:$SHA
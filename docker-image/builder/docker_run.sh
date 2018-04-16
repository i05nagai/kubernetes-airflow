#!/bin/bash

PATH_TO_REPOSITORY=$(cd $(dirname ${0});cd ../../;pwd)
BUILDER_DOCKER_PREFIX=asia.gcr.io/project

if [ -z `docker volume ls --filter name=docker --quiet` ]
then
  docker volume create docker
fi

docker run \
  --rm -it \
  --privileged \
  --name docker \
  --volume docker:/var/lib/docker \
  -d \
  docker:dind \
  --storage-driver=overlay2

docker run \
  --rm -it \
  --volume ${PATH_TO_REPOSITORY}:/opt/local/builder/build/repository \
  --workdir /opt/local/builder/build/repository \
  --link docker \
  --env DOCKER_HOST=tcp://docker:2375 \
  ${BUILDER_DOCKER_PREFIX}/builder:latest \
  /bin/bash -c '/opt/local/builder/build.sh . dev'

docker kill docker

#!/bin/bash


PATH_TO_THIS_DIR=$(cd $(dirname ${0});pwd)
if [[ -e ${PATH_TO_THIS_DIR}/env_me.sh ]]
then
  source ${PATH_TO_THIS_DIR}/env_me.sh
fi

docker run --rm -it \
  --env DEBUG=1 \
  --entrypoint /bin/bash \
  ${DOCKER_REGISTRY_HOST}/${DOCKER_IMAGE_BASE}/workflow-airflow:latest \

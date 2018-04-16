#!/bin/bash

PATH_TO_THIS_DIR=$(cd $(dirname ${0});pwd)
source ${PATH_TO_THIS_DIR}/env.sh

docker run \
  --name home \
  --rm -it \
  --volume $(pwd)/templates/home:/srv/shared/home \
  -p 10022:22 \
  --env HOME_SSHD_EXTRA_ARGS=${HOME_SSHD_EXTRA_ARGS} \
  --env HOME_USERS=${HOME_USERS} \
  --env HOME_SUDOERS=${HOME_SUDOERS} \
  --env DOCKER_HOST=${DOCKER_HOST} \
  --env AWS_IAM_ACCESS_KEY_ID=${AWS_IAM_ACCESS_KEY_ID} \
  --env AWS_IAM_SECRET_KEY=${AWS_IAM_SECRET_KEY} \
  --env GCP_CREDENTIALS="${GCP_IAM_JSON_KEY_DATA}" \
  --env GOOGLE_APPLICATION_CREDENTIALS=${GCP_IAM_JSON_KEY_PATH} \
  ${DOCKER_REGISTRY_HOST}/${DOCKER_IMAGE_BASE}/home:latest \

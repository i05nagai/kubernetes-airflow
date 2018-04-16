#!/bin/bash

set -e

if [ ! -z ${DEBUG+x} ]; then
  set -x
fi

readonly PATH_TO_ENV_DIR=$(cd $(dirname ${0});pwd)
source ${PATH_TO_ENV_DIR}/env.sh

PATH_TO_REPOSITORY=$(cd $(dirname ${0});cd ../..;pwd)
PATH_TO_REPOSITORY_IN_DOCKER=/opt/local/kubectl/repository

docker run \
  --rm -it \
  --volume ${PATH_TO_REPOSITORY}:${PATH_TO_REPOSITORY_IN_DOCKER} \
  --workdir ${PATH_TO_REPOSITORY_IN_DOCKER}/kubernetes \
  --env AWS_IAM_ACCESS_KEY_ID=${AWS_IAM_ACCESS_KEY_ID} \
  --env AWS_IAM_SECRET_KEY=${AWS_IAM_SECRET_KEY} \
  --env AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION} \
  --env GCP_IAM_JSON_KEY_DATA="${GCP_IAM_JSON_KEY_DATA}" \
  --env GCP_IAM_JSON_KEY_PATH=${GCP_IAM_JSON_KEY_PATH} \
  --env GCP_CREDENTIALS="${GCP_IAM_JSON_KEY_DATA}" \
  --env GOOGLE_APPLICATION_CREDENTIALS=${GCP_IAM_JSON_KEY_PATH} \
  asia.gcr.io/project/kubectl:latest \
  /bin/bash -l

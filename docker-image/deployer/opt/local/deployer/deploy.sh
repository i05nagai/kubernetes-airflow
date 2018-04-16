#!/bin/bash

function usage() {
  cat <<EOF
this is a tool for deploy kubernetes manifests.

Usage:
    deploy.sh <path_to_repository>

Environment variable:
  ENVIRONMENT_NAME  required. Valid values are dev/stg/prod.
EOF
}

#
# validate arguments
#
PATH_TO_REPOSITORY=$1
if [ -z ${1+x} ]; then
  echo "Error! Argument is missing."
  usage
  exit 1
fi

#
# validate environment variables
#
if [ ${ENVIRONMENT_NAME} != 'dev' ] \
  && [ ${ENVIRONMENT_NAME} != 'stg' ] \
  && [ ${ENVIRONMENT_NAME} != 'prod' ]; then
  echo "Error! Invalid value ENVIRONMENT_NAME=${ENVIRONMENT_NAME}"
  usage
  exit 1
fi

gcloud container clusters get-credentials ${ENVIRONMENT_NAME}-core-default
make deploy-config-map
make deploy-secret
make deploy-docker-image-to-k8s

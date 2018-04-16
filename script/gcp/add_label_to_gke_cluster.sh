#!/bin/bash

set -e
if [ ! -z ${DEBUG+x} ]; then
  set -x
fi

usage() {
  cat <<EOF
add_label_to_gke_cluster.sh is a tool.

Usage:
    add_label_to_gke_cluster.sh <env>

<env>   Valid values are dev/stg/prod.
EOF
}

#
# validate arguments
#
readonly ENVIRONMENT_NAME=$1
if [ "${ENVIRONMENT_NAME}" != 'dev' ] \
  && [ "${ENVIRONMENT_NAME}" != 'stg' ] \
  && [ "${ENVIRONMENT_NAME}" != 'prod' ]; then
  echo "Invalid argument <env>=${ENVIRONMENT_NAME}"
  usage
  exit 1
fi

# get credential
gcloud container clusters get-credentials ${ENVIRONMENT_NAME}-core-default
# add labels
gcloud beta container clusters update ${ENVIRONMENT_NAME}-core-default --update-labels environment=${ENVIRONMENT_NAME}
gcloud beta container clusters update ${ENVIRONMENT_NAME}-core-default --update-labels service=core
gcloud beta container clusters update ${ENVIRONMENT_NAME}-core-default --update-labels tier=default


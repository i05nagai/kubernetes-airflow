#!/bin/bash

set -e
set -o pipefail

usage() {
  cat <<EOF
This is a tool for building docker images in this repository.
You need to set environment variables
  * ENVIRONMENT_NAME

Usage:
    build.sh <path_to_repository> <env>

<env>       prod/stg/dev
EOF
}

#
# validate arguments
#
PATH_TO_REPOSITORY=$1
if [ -z ${1+x} ]; then
  usage
  exit 1
fi
ENVIRONMENT_NAME=$2
if [ "${ENVIRONMENT_NAME}" = "prod" ]; then
  echo ""
elif [ "${ENVIRONMENT_NAME}" = "stg"  ]; then
  echo ""
elif [ "${ENVIRONMENT_NAME}" = "dev"  ]; then
  echo ""
else
  usage
  exit 1
fi


GIT_SHA1=$(git rev-parse HEAD)
TIMESTAMP=$(date -u +'%Y%m%dT%H%M%S')

export VERSION=${ENVIRONMENT_NAME}-${TIMESTAMP}-${GIT_SHA1}

cd ${PATH_TO_REPOSITORY}
make build

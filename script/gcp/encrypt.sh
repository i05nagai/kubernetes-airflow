#!/bin/bash

set -e
if [ ! -z ${DEBUG+x} ]; then
  set -x
fi

usage() {
  cat <<EOF
encrypt.sh is a tool for encrypting keys.

Usage:
    encrypt.sh <env>

  <env>    required. Valid values are dev/stg/prod.
EOF
}

#
# validate arguments
#
ENVIRONMENT_NAME=$1
if [ "${ENVIRONMENT_NAME}" != 'dev' ] \
  && [ "${ENVIRONMENT_NAME}" != 'stg' ] \
  && [ "${ENVIRONMENT_NAME}" != 'prod' ]; then
  echo "Invalid value <env>=${ENVIRONMENT_NAME}"
  usage
  exit 1
fi

PATH_TO_REPOSITORY=$(cd $(dirname ${0});cd ../..;pwd)

encrypt_from_to() {
  # arguments
  local from=$1
  local to=$2.${ENVIRONMENT_NAME}
  #
  gcloud kms encrypt \
    --location=asia-northeast1 \
    --keyring=${ENVIRONMENT_NAME}-core-asia-northeast1 \
    --key=${ENVIRONMENT_NAME}-core-default \
    --plaintext-file=${PATH_TO_REPOSITORY}/${from} \
    --ciphertext-file=${PATH_TO_REPOSITORY}/${to}
  echo "enrypted $from -> $to"
}

encrypt() {
  local path=$1
  encrypt_from_to ${1} ${1}.encrypted
}

encrypt config/gcp/credential.json
encrypt config/secret/common.sh
encrypt config/secret/${ENVIRONMENT_NAME}.sh

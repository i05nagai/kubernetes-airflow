#!/bin/bash

set -e
if [ ! -z ${DEBUG+x} ]; then
  set -x
fi

usage() {
  cat <<EOF
decrypt.sh is a tool for encrypting keys.

Usage:
    decrypt.sh <env>

  <env>    required. Valid values are dev/stg/prod.
EOF
}

#
# validate arguments
#
readonly ENVIRONMENT_NAME=$1
if [ "${ENVIRONMENT_NAME}" != 'dev' ] \
  && [ "${ENVIRONMENT_NAME}" != 'stg' ] \
  && [ "${ENVIRONMENT_NAME}" != 'prod' ]; then
  echo "Invalid value <env>=${ENVIRONMENT_NAME}"
  usage
  exit 1
fi

PATH_TO_REPOSITORY=$(cd $(dirname ${0});cd ../..;pwd)

decrypt_from_to() {
  local from=$1.${ENVIRONMENT_NAME}
  local to=$2
  gcloud kms decrypt \
    --location=asia-northeast1  \
    --keyring=${ENVIRONMENT_NAME}-core-asia-northeast1 \
    --key=${ENVIRONMENT_NAME}-core-default \
    --ciphertext-file=${PATH_TO_REPOSITORY}/${from} \
    --plaintext-file=${PATH_TO_REPOSITORY}/${to}
  echo "decrypted $from -> $to"
}

decrypt() {
  local path=$1
  decrypt_from_to ${1}.encrypted ${1}
}

decrypt config/gcp/credential.json
decrypt config/secret/common.sh
decrypt config/secret/${ENVIRONMENT_NAME}.sh


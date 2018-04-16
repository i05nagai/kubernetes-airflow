#!/bin/bash

#
# validates environment variables
#
PATH_TO_CONFIG_VAR_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
if [ "${ENVIRONMENT_NAME}" = "prod" ]; then
  source ${PATH_TO_CONFIG_VAR_DIR}/prod.sh
elif [ "${ENVIRONMENT_NAME}" = "stg" ]; then
  source ${PATH_TO_CONFIG_VAR_DIR}/stg.sh
elif [ "${ENVIRONMENT_NAME}" = "dev" ]; then
  source ${PATH_TO_CONFIG_VAR_DIR}/dev.sh
else
  echo "Error!"
  echo "You need to set environment variable ENVIRONMENT_NAME."
  echo "Valid values are 'dev', 'stg' or 'prod'"
  exit 1
fi

source ${PATH_TO_CONFIG_VAR_DIR}/common.sh

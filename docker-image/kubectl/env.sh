#!/bin/bash

set -e
if [ -z ${PATH_TO_CONFIG_DIR+x} ]; then
  readonly PATH_TO_CONFIG_DIR=$(cd $(dirname ${0})/../../config;pwd)
fi

source ${PATH_TO_CONFIG_DIR}/var/env.sh
source ${PATH_TO_CONFIG_DIR}/secret/env.sh

export AWS_IAM_ACCESS_KEY_ID
export AWS_IAM_SECRET_KEY
export AWS_DEFAULT_REGION
export GCP_IAM_JSON_KEY_DATA
export GCP_IAM_JSON_KEY_PATH

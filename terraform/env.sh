#!/bin/bash

################################################################################
# Usage:
#
# 1. copy this files as `env_me.sh` and place it in directory same as `env.sh`.
# 2. delete lines which does not have `export` command,
# 3. Fill the values of variables
#
# or get `env_me.sh` files from another developer.
#
################################################################################

PATH_TO_ENV_DIR=$(cd $(dirname ${0});pwd)
if [[ -e ${PATH_TO_ENV_DIR}/env_me.sh ]]; then
  source ${PATH_TO_ENV_DIR}/env_me.sh
fi

export GCP_KUBERNETES_PASSWORD=${GCP_KUBERNETES_PASSWORD:-""}
export AWS_IAM_ACCESS_KEY_ID=${AWS_IAM_ACCESS_KEY_ID:-""}
export AWS_IAM_SECRET_KEY=${AWS_IAM_SECRET_KEY:-""}
export AWS_NETWORK_VPN_TUNNEL_KEY=${AWS_NETWORK_VPN_TUNNEL_KEY:-""}
export GOOGLE_CREDENTIALS="${GOOGLE_CREDENTIALS:-""}"


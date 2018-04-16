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


: ${PATH_TO_THIS_DIR:=$(cd $(dirname ${0});pwd)}
if [[ -e ${PATH_TO_THIS_DIR}/env_me.sh ]]
then
  source ${PATH_TO_THIS_DIR}/env_me.sh
fi

export DOCKER_REGISTRY_HOST=${DOCKER_REGISTRY_HOST:-""}
export DOCKER_IMAGE_BASE=${DOCKER_IMAGE_BASE:-""}
export HOME_USERS=${HOME_USERS:-""}
export HOME_SUDOERS=${HOME_SUDOERS:-""}
export HOME_SSHD_EXTRA_ARGS=${HOME_SSHD_EXTRA_ARGS:-""}
export AWS_IAM_ACCESS_KEY_ID=${AWS_IAM_ACCESS_KEY_ID:-""}
export AWS_IAM_SECRET_KEY=${AWS_IAM_SECRET_KEY:-""}
export GCP_IAM_JSON_KEY_DATA="${GCP_IAM_JSON_KEY_DATA:-""}"
export GCP_IAM_JSON_KEY_PATH=${GCP_IAM_JSON_KEY_PATH:-""}

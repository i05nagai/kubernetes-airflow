#!/bin/bash

set -x

readonly SUBCOMMAND=$1
readonly API_FILE=$2
shift
shift

# to excape $ from envsubst
export DOLLAR='$'
readonly PATH_TO_THIS_DIR=$(cd $(dirname ${0});pwd)
source ${PATH_TO_THIS_DIR}/env.sh
source ${PATH_TO_THIS_DIR}/var.sh

# encode secrets to base64
export MYSQL_PASSWORD=`printf "%s" ${MYSQL_PASSWORD} | base64`
export MYSQL_ROOT_PASSWORD=`printf "%s" ${MYSQL_ROOT_PASSWORD} | base64`

export AWS_IAM_ACCESS_KEY_ID=`printf "%s" ${AWS_IAM_ACCESS_KEY_ID} | base64`
export AWS_IAM_SECRET_KEY=`printf "%s" ${AWS_IAM_SECRET_KEY} | base64`
export AWS_RDS_PASSWORD=`printf "%s" ${AWS_RDS_PASSWORD} | base64`
export GCP_IAM_JSON_KEY_DATA=`printf "%s" "${GCP_IAM_JSON_KEY_DATA}" | base64`

envsubst < ${API_FILE} | kubectl ${SUBCOMMAND} -f - $@

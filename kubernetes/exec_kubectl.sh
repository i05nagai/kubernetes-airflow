#!/bin/bash

if [ ! -z ${DEBUG+x} ]; then
  set -x
fi

# arguments
readonly SUBCOMMAND=$1
shift
readonly API_FILE=$1
shift

# load variables
readonly PATH_TO_ENV_DIR=$(cd $(dirname ${0});pwd)
source ${PATH_TO_ENV_DIR}/env.sh
source ${PATH_TO_ENV_DIR}/var.sh

# encode secrets to base64
# "%s" is to avoid escaping % in the string which will be showed
export MYSQL_PASSWORD=`printf "%s" ${MYSQL_PASSWORD} | base64 | tr -d '\n'`
export MYSQL_ROOT_PASSWORD=`printf "%s" ${MYSQL_ROOT_PASSWORD} | base64 | tr -d '\n'`
export AWS_IAM_ACCESS_KEY_ID=`printf "%s" ${AWS_IAM_ACCESS_KEY_ID} | base64 | tr -d '\n'`
export AWS_IAM_SECRET_KEY=`printf "%s" ${AWS_IAM_SECRET_KEY} | base64 | tr -d '\n'`
export AWS_RDS_PASSWORD=`printf "%s" ${AWS_RDS_PASSWORD} | base64 | tr -d '\n'`
export GCP_IAM_JSON_KEY_DATA=`printf "%s" "${GCP_IAM_JSON_KEY_DATA}" | base64 | tr -d '\n'`
export WORKFLOW_AIRFLOW_PASSWORD=`printf "%s" "${WORKFLOW_AIRFLOW_PASSWORD}" | base64 | tr -d '\n'`

#
# check if node name does not contain ${ENVIRONMENT_NAME}
#
if ! kubectl get nodes | grep "${ENVIRONMENT_NAME}" --quiet; then
  echo "Error:"
  echo "  Mismatching env and nodes"
  echo "env:"
  echo "  ${ENVIRONMENT_NAME}"
  echo "Nodes: "
  kubectl get nodes | sed -e 's/^/  /'
  exit 1
fi

if [ ! -z ${DEBUG+x} ]; then
  envsubst < ${API_FILE} | cat
fi
envsubst < ${API_FILE} | kubectl ${SUBCOMMAND} -f - $@

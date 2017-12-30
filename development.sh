#!/bin/bash

set -x

api_file=$1

export AIRFLOW_HOME=${AIRFLOW_HOME:-"/opt/local/airflow"}
export MOUNT_AIRFLOW_PATH=${AIRFLOW_HOME:-"$(pwd)/airflow/opt/local/airflow"}
export MYSQL_DATABASE=${MYSQL_DATABASE:-"airflow"}
export MYSQL_PASSWORD=${MYSQL_PASSWORD:-"airflow"}
export MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-"airflow"}
export MYSQL_USER=${MYSQL_USER:-"airflow"}
export REDIS_PASSWORD=${REDIS_PASSWORD:-"airflow"}

envsubst < $api_file | kubectl create -f -

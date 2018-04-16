#!/bin/bash

ENVIRONMENT_NAME=dev
readonly PATH_TO_THIS_DIR=$(cd $(dirname ${0});pwd)
source ${PATH_TO_THIS_DIR}/env.sh

docker-compose "$@"

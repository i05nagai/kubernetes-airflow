#!/bin/bash

if [ ! -z ${DEBUG+x} ]; then
  set -x
fi

usage() {
  cat <<EOF
This is a tool for run tests of google cloud skd script.

Usage:
    run_test_google_cloud_sdk_script.sh [path-to-repository]
EOF
}

#
# validate arguments
#
readonly PATH_TO_REPOSITORY=$1
if [ -z ${PATH_TO_REPOSITORY+x} ]; then
  usage
  exit 1
fi

#
# run tests
#
PATH_TO_THIS_DIR=$(cd $(dirname ${0});pwd)
${PATH_TO_THIS_DIR}/run_test_python.sh ${PATH_TO_REPOSITORY}/service/workflow/job/bq/opt/local/workflow/job/bq


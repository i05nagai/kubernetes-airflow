#!/bin/bash

if [ -z ${DEBUG+x} ]; then
  set -x
fi

function usage() {
  cat <<EOF
This is a tool for ...

Usage:
    run_test_python.sh <path_to_test_dir>
EOF
}

#
# validate arugments
#
PATH_TO_TEST_TARGET=$1
if [ -z ${PATH_TO_TEST_TARGET+x} ]
then
  usage
  exit 1
fi

pytest ${PATH_TO_TEST_TARGET} --cov=. --pep8

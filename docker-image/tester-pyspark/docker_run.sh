#!/bin/bash

set -x

REPOSITORY_DIR=$(cd $(dirname ${0});cd ../..;pwd)
REPOSITORY_NAME=$(basename $REPOSITORY_DIR)

docker run \
  --volume ${REPOSITORY_DIR}:/host/${REPOSITORY_NAME} \
  --workdir /host/${REPOSITORY_NAME} \
  -it \
  --rm \
  asia.gcr.io/project/tester:latest \
  /opt/local/tester-pyspark/run_test_spark.sh /host/${REPOSITORY_NAME}

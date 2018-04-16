#!/bin/bash

set -e
set -o pipefail

if [ ! -z ${DEBUG+x} ]; then
  set -x
fi

readonly PATH_TO_ENV_DIR=$(cd $(dirname ${0});pwd)
source ${PATH_TO_ENV_DIR}/env.sh

#
# check kubectl exists
#
echo "start check gcloud"
docker run \
  --rm -it \
  --env GCP_CREDENTIALS="${GCP_IAM_JSON_KEY_DATA}" \
  --env GOOGLE_APPLICATION_CREDENTIALS=${GCP_IAM_JSON_KEY_PATH} \
  asia.gcr.io/project/kubectl:latest \
  kubectl > /dev/null

#
# check config gcloud is properly set
#
echo "start check gcloud"
docker run \
  --rm -it \
  --env GCP_CREDENTIALS="${GCP_IAM_JSON_KEY_DATA}" \
  --env GOOGLE_APPLICATION_CREDENTIALS=${GCP_IAM_JSON_KEY_PATH} \
  asia.gcr.io/project/kubectl:latest \
  /bin/bash -c '[[ `gcloud config get-value core/project` = "project" ]] \
  && [[ `gcloud config get-value compute/region` = "asia-northeast1" ]] \
  && [[ `gcloud config get-value compute/zone` = "asia-northeast1-a" ]] \
  && exit 127'

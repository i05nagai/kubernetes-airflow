#!/bin/sh

set -e

if [ ! -z ${DEBUG+x} ]
then
  set -x
fi

#
# GKE settings
#
gcloud auth activate-service-account \
  <service-account> \
  --key-file=${GOOGLE_APPLICATION_CREDENTIALS}
gcloud config set core/project project
gcloud config set compute/region asia-northeast1
gcloud config set compute/zone asia-northeast1-a

exec "$@"

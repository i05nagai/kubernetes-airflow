#!/bin/sh

# for terraform backend
export GOOGLE_CREDENTIALS="${GCP_IAM_JSON_KEY_DATA}"
# create GCP json key
export GCP_CREDENTIALS="${GCP_IAM_JSON_KEY_DATA}"
export GOOGLE_APPLICATION_CREDENTIALS="${GCP_IAM_JSON_KEY_PATH}"
# export AWS credentials
export AWS_ACCESS_KEY_ID="${AWS_IAM_ACCESS_KEY_ID}"
export AWS_SECRET_ACCESS_KEY="${AWS_IAM_SECRET_KEY}"

exec "$@"

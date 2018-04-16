#!/bin/bash

# to excape $ from envsubst
export DOLLAR='$'

# Always/IfNotPresent
export _DOCKER_IMAGE_PULL_POLICY=${_DOCKER_IMAGE_PULL_POLICY:-"Always"}
# to establish connection with kubernetes-job
# we use this variable for readability of configurations
export _WORKFLOW_AIRFLOW_GCP_CONN_EXTRA=$(cat << EOS
{
  "extra__google_cloud_platform__key_path": "${GCP_IAM_JSON_KEY_PATH}",
  "extra__google_cloud_platform__project": "${GCP_PROJECT_ID}",
  "extra__google_cloud_platform__scope": [
    "https://www.googleapis.com/auth/pubsub",
    "https://www.googleapis.com/auth/datastore",
    "https://www.googleapis.com/auth/bigquery",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/devstorage.full_control"
  ]
}
EOS
)
export _WORKFLOW_AIRFLOW_GCP_GCR_CONN_EXTRA=$(cat << EOS | tr '\n' ' ' | sed 's/"/\x27/g'
{
  "extra__google_cloud_platform__key_path": "${GCP_IAM_JSON_KEY_PATH}",
  "extra__google_cloud_platform__project": "${GCP_PROJECT_ID}"
}
EOS
)

export _GITHUB_DEPLOY_KEY=$(cat ./github_deploy_key | base64)
export _GCP_EMAIL="<account>@developer.gserviceaccount.com"


#!/bin/bash

export _AIRFLOW_CONN_EXTRA=$(cat << EOS
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

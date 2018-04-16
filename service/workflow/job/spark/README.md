## Overview
Jobs to transfer tables from MySQL to BigQuery in two ways.

## Command

```
docker run \
  --rm \
  -it \
  --env BIGQUERY_PROJECT="" \
  --env BIGQUERY_DATASET="" \
  --env GOOGLE_APPLICATION_CREDENTIALS="" \
  --env MYSQL_USER="" \
  --env MYSQL_DATABASE="" \
  --env MYSQL_PASSWORD="" \
  --env EVENT_DATE="" \
  --volume $(pwd):/opt/local/airflow/jobs/job1 \
  i05nagai/embulk:latest \
  /opt/local/airflow/jobs/job1/embulk1/table_sample_01.yml.liquid
```

## Environment
* BIGQUERY_PROJECT
* BIGQUERY_DATASET
* GOOGLE_APPLICATION_CREDENTIALS
* MYSQL_USER
* MYSQL_DATABASE
* MYSQL_PASSWORD
* EVENT_DATE

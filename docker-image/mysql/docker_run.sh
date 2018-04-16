#!/bin/bash

docker run \
  --rm \
  -it \
  --env MYSQL_ROOT_USER="root" \
  --env MYSQL_ROOT_PASSWORD="root" \
  i05nagai/mysql-sample:latest \

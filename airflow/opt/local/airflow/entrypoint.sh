#!/usr/bin/env bash

set -x

try_loop="20"

queue_host="${REDIS_SERVICE_HOST:-"redis"}"
queue_port="${REDIS_SERVICE_PORT:-"6379"}"
queue_password="${REDIS_PASSWORD:-""}"

db_host="${MYSQL_SERVICE_HOST}"
db_port="${MYSQL_SERVICE_PORT}"
db_user="${MYSQL_USER:-"airflow"}"
db_password="${MYSQL_PASSWORD:-"airflow"}"
db_databse="${MYSQL_DATABSE:-"airflow"}"

web_host="${AIRFLOW_WEB_SERVICE_HOST}"
web_port="${AIRFLOW_WEB_SERVICE_PORT}"

# Defaults
: "${AIRFLOW__CORE__FERNET_KEY:=${FERNET_KEY:=$(python3 -c "from cryptography.fernet import Fernet; FERNET_KEY = Fernet.generate_key().decode(); print(FERNET_KEY)")}}"

# Install custome python package if requirements.txt is present
if [ -e "/requirements.txt" ]; then
    $(which pip3) install --user -r /requirements.txt
fi

# if [ -n "$REDIS_PASSWORD" ]; then
#     REDIS_PREFIX=:${REDIS_PASSWORD}@
# else
#     REDIS_PREFIX=
# fi

wait_for_port() {
  local name="$1" host="$2" port="$3"
  local j=0
  while ! nc -z "$host" "$port" >/dev/null 2>&1 < /dev/null; do
    j=$((j+1))
    if [ $j -ge $try_loop ]; then
      echo >&2 "$(date) - $host:$port still not reachable, giving up"
      exit 1
    fi
    echo "$(date) - waiting for $name... $j/$try_loop"
    sleep 5
  done
}

wait_for_queue() {
  local name="$1" host="$2" port="$3"
  # Wait for Redis iff we are using it
  wait_for_port "$name" "$host" "$port"
}

# AIRFLOW__CORE__SQL_ALCHEMY_CONN="db+mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@${MYSQL_SERVICE_HOST}:${MYSQL_SERVICE_PORT}/${MYSQL_DATABASE}"
# AIRFLOW__CELERY__BROKER_URL="redis://$REDIS_PREFIX$REDIS_HOST:$REDIS_PORT/1"
# AIRFLOW__CELERY__CELERY_RESULT_BACKEND="db+mysql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB"

case "$1" in
  webserver)
    wait_for_port "DB" "$db_host" "$db_port"
    wait_for_queue "QUEUE" "$queue_host" "$queue_port"
    airflow initdb
    exec airflow webserver
    ;;
  worker|scheduler)
    wait_for_port "DB" "$db_host" "$db_port"
    wait_for_queue "QUEUE" "$queue_host" "$queue_port"
    # To give the webserver time to run initdb.
    wait_for_port "web" "$web_host" "$web_port"
    exec airflow "$@"
    ;;
  flower)
    wait_for_queue "QUEUE" "$queue_host" "$queue_port"
    exec airflow "$@"
    ;;
  version)
    exec airflow "$@"
    ;;
  *)
    # The command is something like bash, not an airflow subcommand. Just run it in the right environment.
    exec "$@"
    ;;
esac

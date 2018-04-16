## Overview

## Requirements
* envsubst

```
brew install gettext
brew link --force gettext
```

## Environment variables
* MYSQL_ROOT_PASSWORD
* MYSQL_USER
* MYSQL_PASSWORD
* MYSQL_DATABASE
* AIRFLOW_HOME
* REDIS_PREFIX
* REDIS_PASSWORD
* C_FORCE_ROOT


```
minikube mount ./airflow/opt:/opt
```

## Reference
* [ErezHorev/dockerized_nfs_server: Dockerized NFS server - NFS server as a docker container](https://github.com/ErezHorev/dockerized_nfs_server)

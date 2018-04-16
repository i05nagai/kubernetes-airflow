## Overview

Copy deploy key to `~/.ssh/gtihub_deploy_key`

```
gcloud container clusters get-credentials cluster-name
```

```
gcloud auth activate-service-account <account> --key-file /path/to/key_file.json
```

```sh
make create-namespace
make create-config-map
make create-secret
make deploy-nfs-server
make create-pv-nfs
make create-pvc-nfs-home
make deploy-docker
make deploy-home
```

```sh
make delete-home
make delete-pvc-nfs-home
make delete-pv-nfs
make delete-nfs-server
make delete-secret
make delete-config-map
make delete-docker
make delete-namespace
```


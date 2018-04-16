## Overview
The manifest files for setup sevices (e.g. `workflow` and `home`).

## Setup environment

### (1-a). with docker image for kubectl
Run and attach to docker container by following command.

```
cd docker-image/kubectl
./docker_run.sh
```

### (1-b) without docker image for kubectl
We recommed you to use the docker image for `kubectl`.

Install kubernetes-cli

```
brew install kubectl
```

Install `envsubst`

```
brew install gettext
brew link --force gettext
```

Activate the account and configure it.

```
gcloud auth activate-service-account \
    <service-account> \
    --key-file=config/gcp/credential.json
gcloud config set core/project project
gcloud config set compute/region asia-northeast1
gcloud config set compute/zone asia-northeast1-a
```

### (2) check whether configuration is done correctly

```
$ gcloud container clusters get-credentials dev-core-default
$ kubectl get nodes
```

Confirm that NAME of nodes contain the word `dev`. The name of node could be different because the part of suffix is automatically generated when the cluster is launched.

## Design

### Directory structure

The name of directories should be service names.

* `home/`
* `workspace/`
    * `manifest/`
    * `make/`
        * make files for each type of kubernetes objects
    * `Makefile`
        * make fiels for this service

### URL

* `prod`
    * `<service-name>.hoge.com`.
    * e.g. `workflow.hoge.com`.
* `stg`
    * `<service-name>.stg.hoge.com`.
    * e.g. `workflow.stg.hoge.com`.
* `dev`
    * `<service-name>.dev.hoge.com`.
    * e.g. `workflow.dev.hoge.com`.

## Tips
Shell completion

```
$ source <(kubectl completion bash) # setup autocomplete in bash, bash-completion package should be installed first.
$ source <(kubectl completion zsh)  # setup autocomplete in zsh
```

Show cluster which you are managing

```
$ kubectl config current-context
```

Change cluster

```
$ gcloud container clusters get-credentials <gke-cluster-name>
```

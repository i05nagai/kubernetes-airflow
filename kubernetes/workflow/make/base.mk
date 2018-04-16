# if environment variable is defined
KUBERNETES_NAMESPACE ?= "workflow"

KUBERNETES_OPTIONS = --namespace ${KUBERNETES_NAMESPACE}
CURRENT_DIR = $(shell pwd)
PATH_TO_THIS_FILE = $(realpath $(lastword ${MAKEFILE_LIST}))
PATH_TO_THIS_DIR = $(dir ${PATH_TO_THIS_FILE})
PATH_TO_SCRIPT = $(realpath ${PATH_TO_THIS_DIR}/../..)
PATH_TO_KUBERNETES_EXEC = ${PATH_TO_SCRIPT}/exec_kubernetes.sh
PATH_TO_KUBERNETES = ${PATH_TO_SCRIPT}/workflow/manifest


.PHONY: create-namespace delete-namespace deploy-database

KUBERNETES_NAMESPACE ?= "default"
KUBERNETES_OPTIONS = --namespace ${KUBERNETES_NAMESPACE}
CURRENT_DIR = $(shell pwd)
PATH_TO_THIS_FILE = $(realpath $(lastword ${MAKEFILE_LIST}))
PATH_TO_THIS_DIR = $(dir ${PATH_TO_THIS_FILE})
PATH_TO_SCRIPT = $(realpath ${PATH_TO_THIS_DIR}/..)
PATH_TO_KUBERNETES = ${PATH_TO_SCRIPT}/kubernetes-api


# namespace
create-namespace:
	kubectl create namespace $(KUBERNETES_NAMESPACE)

delete-namespace:
	kubectl delete namespace $(KUBERNETES_NAMESPACE)

# secret
create-secret:
	${PATH_TO_SCRIPT}/exec_kubernetes.sh create ${PATH_TO_KUBERNETES}/secret-docker-gcr-asia.yml
	${PATH_TO_SCRIPT}/exec_kubernetes.sh create ${PATH_TO_KUBERNETES}/secret-mysql-environment-variable.yml
	${PATH_TO_SCRIPT}/exec_kubernetes.sh create ${PATH_TO_KUBERNETES}/secret-airflow-environment-variable.yml

delete-secret:
	${PATH_TO_SCRIPT}/exec_kubernetes.sh delete ${PATH_TO_KUBERNETES}/secret-docker-gcr-asia.yml
	${PATH_TO_SCRIPT}/exec_kubernetes.sh delete ${PATH_TO_KUBERNETES}/secret-mysql-environment-variable.yml
	${PATH_TO_SCRIPT}/exec_kubernetes.sh delete ${PATH_TO_KUBERNETES}/secret-airflow-environment-variable.yml

# config map
create-config-map:
	${PATH_TO_SCRIPT}/exec_kubernetes.sh create ${PATH_TO_KUBERNETES}/config-map-airflow-environment-variable.yml
	${PATH_TO_SCRIPT}/exec_kubernetes.sh create ${PATH_TO_KUBERNETES}/config-map-mysql-environment-variable.yml

delete-config-map:
	${PATH_TO_SCRIPT}/exec_kubernetes.sh delete ${PATH_TO_KUBERNETES}/config-map-airflow-environment-variable.yml
	${PATH_TO_SCRIPT}/exec_kubernetes.sh delete ${PATH_TO_KUBERNETES}/config-map-mysql-environment-variable.yml

# network policy
create-network-policy:
	${PATH_TO_SCRIPT}/exec_kubernetes.sh apply ${PATH_TO_KUBERNETES}/airflow-network-policy.yml

delete-network-policy:
	${PATH_TO_SCRIPT}/exec_kubernetes.sh delete ${PATH_TO_KUBERNETES}/airflow-network-policy.yml

# ingress
create-ingress:
	${PATH_TO_SCRIPT}/exec_kubernetes.sh apply ${PATH_TO_KUBERNETES}/airflow-ingress.yml

delete-ingress:
	${PATH_TO_SCRIPT}/exec_kubernetes.sh delete ${PATH_TO_KUBERNETES}/airflow-ingress.yml

# docker
deploy-docker:
	${PATH_TO_SCRIPT}/exec_kubernetes.sh apply ${PATH_TO_KUBERNETES}/deploy-docker.yml $(KUBERNETES_OPTIONS)

delete-docker:
	kubectl delete -f ${PATH_TO_KUBERNETES}/deploy-docker.yml $(KUBERNETES_OPTIONS)

# database
deploy-database:
	${PATH_TO_SCRIPT}/exec_kubernetes.sh apply ${PATH_TO_KUBERNETES}/deploy-database.yml $(KUBERNETES_OPTIONS)

delete-database:
	kubectl delete -f ${PATH_TO_KUBERNETES}/deploy-database.yml $(KUBERNETES_OPTIONS)

#
setup-airflow:
	${PATH_TO_SCRIPT}/exec_kubernetes.sh apply ${PATH_TO_KUBERNETES}/job-airflow-initdb.yml $(KUBERNETES_OPTIONS)
	${PATH_TO_SCRIPT}/exec_kubernetes.sh apply ${PATH_TO_KUBERNETES}/job-airflow-dag-add-gcp-connection.yml $(KUBERNETES_OPTIONS)

# Deploy
deploy-airflow: create-config-map-airflow-environment-variable
	${PATH_TO_SCRIPT}/exec_kubernetes.sh apply ${PATH_TO_KUBERNETES}/deploy-airflow.yml $(KUBERNETES_OPTIONS)

delete-airflow:
	kubectl delete -f ${PATH_TO_KUBERNETES}/deploy-airflow.yml $(KUBERNETES_OPTIONS)

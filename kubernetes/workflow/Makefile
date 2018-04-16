include make/base.mk
include make/config_map.mk
include make/daemon.mk
include make/deployment.mk
include make/ingress.mk
include make/job.mk
include make/namespace.mk
include make/secret.mk
include make/volume.mk


# utility commands
kill-airflow:
	kubectl get pods ${KUBERNETES_OPTIONS} | grep workflow-airflow | cut -f 1 -d ' ' | xargs kubectl delete pod ${KUBERNETES_OPTIONS}

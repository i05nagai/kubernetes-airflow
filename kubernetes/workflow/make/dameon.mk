# datadog
create-datadog:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/daemon/datadog.yml $(KUBERNETES_OPTIONS)

delete-datadog:
	kubectl delete -f ${PATH_TO_KUBERNETES}/daemon/datadog.yml $(KUBERNETES_OPTIONS)

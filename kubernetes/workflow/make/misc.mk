# network policy
create-network-policy:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/airflow-network-policy.yml $(KUBERNETES_OPTIONS)

delete-network-policy:
	${PATH_TO_KUBERNETES_EXEC} delete ${PATH_TO_KUBERNETES}/airflow-network-policy.yml $(KUBERNETES_OPTIONS)

# service account
patch-service-account:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/patch-service-account.yml \
		$(KUBERNETES_OPTIONS)

#
setup-airflow:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/job/airflow-initdb.yml $(KUBERNETES_OPTIONS)
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/job/airflow-dag-add-gcp-connection.yml $(KUBERNETES_OPTIONS)

rolling-update-airflow:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/airflow-rolling-update.yml $(KUBERNETES_OPTIONS)

patch-airflow-dev:
	kubectl patch -f airflow-dev.yml -p '{"spec":{"containers":[{"name":"airflow-web","image":"airflow:latest"}]}}'
	kubectl patch -f airflow-dev.yml -p '{"spec":{"containers":[{"name":"airflow-worker","image":"airflow:latest"}]}}'

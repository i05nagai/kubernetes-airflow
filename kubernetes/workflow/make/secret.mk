# secret
create-secret: create-secret-docker-asia-gcr
	${PATH_TO_KUBERNETES_EXEC} create ${PATH_TO_KUBERNETES}/secret/mysql-environment-variable.yml ${KUBERNETES_OPTIONS}
	${PATH_TO_KUBERNETES_EXEC} create ${PATH_TO_KUBERNETES}/secret/airflow-environment-variable.yml ${KUBERNETES_OPTIONS}

delete-secret: delete-secret-docker-asia-gcr
	${PATH_TO_KUBERNETES_EXEC} delete ${PATH_TO_KUBERNETES}/secret/mysql-environment-variable.yml ${KUBERNETES_OPTIONS}
	${PATH_TO_KUBERNETES_EXEC} delete ${PATH_TO_KUBERNETES}/secret/airflow-environment-variable.yml ${KUBERNETES_OPTIONS}

create-secret-docker-asia-gcr:
	kubectl create secret docker-registry \
		workflow-docker-asia-gcr --docker-server=https://asia.gcr.io \
		--docker-username=oauth2accesstoken \
		--docker-password=$(shell gcloud auth application-default print-access-token) \
		--docker-email=${GCP_EMAIL} \
		${KUBERNETES_OPTIONS}

delete-secret-docker-asia-gcr:
	kubectl delete secret workflow-docker-asia-gcr ${KUBERNETES_OPTIONS}

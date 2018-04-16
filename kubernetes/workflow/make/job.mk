# initdb
create-job-initdb:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/job/airflow-initdb.yml $(KUBERNETES_OPTIONS)

delete-job-initdb:
	${PATH_TO_KUBERNETES_EXEC} delete ${PATH_TO_KUBERNETES}/job/airflow-initdb.yml $(KUBERNETES_OPTIONS)

# upgradedb
create-job-upgradedb:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/job/airflow-upgradedb.yml $(KUBERNETES_OPTIONS)

delete-job-upgradedb:
	${PATH_TO_KUBERNETES_EXEC} delete ${PATH_TO_KUBERNETES}/job/airflow-upgradedb.yml $(KUBERNETES_OPTIONS)

# reset db
create-job-resetdb:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/job/airflow-resetdb.yml $(KUBERNETES_OPTIONS)

delete-job-resetdb:
	${PATH_TO_KUBERNETES_EXEC} delete ${PATH_TO_KUBERNETES}/job/airflow-resetdb.yml $(KUBERNETES_OPTIONS)

# dag-add-gcp-connection
create-job-dag-add-gcp-connection:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/job/airflow-dag-add-gcp-connection.yml $(KUBERNETES_OPTIONS)

delete-job-dag-add-gcp-connection:
	${PATH_TO_KUBERNETES_EXEC} delete ${PATH_TO_KUBERNETES}/job/airflow-dag-add-gcp-connection.yml $(KUBERNETES_OPTIONS)

# dag-add-docker-connection
create-job-dag-add-docker-connection:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/job/airflow-dag-add-docker-connection.yml $(KUBERNETES_OPTIONS)

delete-job-dag-add-docker-connection:
	${PATH_TO_KUBERNETES_EXEC} delete ${PATH_TO_KUBERNETES}/job/airflow-dag-add-docker-connection.yml $(KUBERNETES_OPTIONS)

# dag-add-docker-connection
create-job-dag-add-airflow-user:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/job/airflow-dag-add-airflow-user.yml $(KUBERNETES_OPTIONS)

delete-job-dag-add-airflow-user:
	${PATH_TO_KUBERNETES_EXEC} delete ${PATH_TO_KUBERNETES}/job/airflow-dag-add-airflow-user.yml $(KUBERNETES_OPTIONS)

create-job-connection-docker-registry:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/job/airflow-connection-docker-registry.yml $(KUBERNETES_OPTIONS)

delete-job-connection-docker-registry:
	${PATH_TO_KUBERNETES_EXEC} delete ${PATH_TO_KUBERNETES}/job/airflow-connection-docker-registry.yml $(KUBERNETES_OPTIONS)


# docker
deploy-docker:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/deployment/docker.yml $(KUBERNETES_OPTIONS)

delete-docker:
	kubectl delete -f ${PATH_TO_KUBERNETES}/deployment/docker.yml $(KUBERNETES_OPTIONS)

# database
deploy-database:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/deployment/database.yml $(KUBERNETES_OPTIONS)

delete-database:
	kubectl delete -f ${PATH_TO_KUBERNETES}/deployment/database.yml $(KUBERNETES_OPTIONS)

# airflow
deploy-airflow: create-config-map-airflow-environment-variable
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/deployment/airflow.yml $(KUBERNETES_OPTIONS)

delete-airflow:
	kubectl delete -f ${PATH_TO_KUBERNETES}/deployment/airflow.yml $(KUBERNETES_OPTIONS)

deploy-airflow-dev:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/deployment/airflow-dev.yml $(KUBERNETES_OPTIONS)

delete-airflow-dev:
	kubectl delete -f ${PATH_TO_KUBERNETES}/deployment/airflow-dev.yml $(KUBERNETES_OPTIONS)


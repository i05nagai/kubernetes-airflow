# config map
create-config-map:
	${PATH_TO_KUBERNETES_EXEC} create ${PATH_TO_KUBERNETES}/config-map/airflow-environment-variable.yml $(KUBERNETES_OPTIONS)
	${PATH_TO_KUBERNETES_EXEC} create ${PATH_TO_KUBERNETES}/config-map/mysql-environment-variable.yml $(KUBERNETES_OPTIONS)

delete-config-map:
	${PATH_TO_KUBERNETES_EXEC} delete ${PATH_TO_KUBERNETES}/config-map/airflow-environment-variable.yml $(KUBERNETES_OPTIONS)
	${PATH_TO_KUBERNETES_EXEC} delete ${PATH_TO_KUBERNETES}/config-map/mysql-environment-variable.yml $(KUBERNETES_OPTIONS)

create-config-map-airflow-environment-variable:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/config-map/airflow-environment-variable.yml $(KUBERNETES_OPTIONS)

delete-config-map-airflow-environment-variable:
	${PATH_TO_KUBERNETES_EXEC} delete ${PATH_TO_KUBERNETES}/config-map/airflow-environment-variable.yml $(KUBERNETES_OPTIONS)

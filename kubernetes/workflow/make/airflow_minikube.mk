show-airflow-web:
	minikube service airflow-web --namespace $(KUBERNETES_OPTIONS)

mount-airflow-dags:
	minikube mount $(CURRENT_DIR)/opt:/opt

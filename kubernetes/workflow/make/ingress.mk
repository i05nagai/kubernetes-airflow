# ingress
create-ingress:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/ingress/airflow-gce.yml $(KUBERNETES_OPTIONS)

delete-ingress:
	${PATH_TO_KUBERNETES_EXEC} delete ${PATH_TO_KUBERNETES}/ingress/airflow-gce.yml $(KUBERNETES_OPTIONS)

create-ingress-nginx:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/ingress/airflow-nginx-ingress-controller.yml
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/ingress/airflow-nginx.yml

delete-ingress-nginx:
	${PATH_TO_KUBERNETES_EXEC} delete ${PATH_TO_KUBERNETES}/ingress/airflow-nginx-ingress-controller.yml
	${PATH_TO_KUBERNETES_EXEC} delete ${PATH_TO_KUBERNETES}/ingress/airflow-nginx.yml

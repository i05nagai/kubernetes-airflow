
.PHONY: airflow build airflow docker dev-airflow

build:
	cd airflow; ./docker_build.sh
	cd embulk; ./docker_build.sh

recreate-airflow:
	kubectl delete -f airflow.yml
	bash ./development.sh airflow.yml
	make delete-airflow-flower

recreate-docker:
	kubectl delete -f docker.yml
	bash ./development.sh docker.yml

airflow:
	bash ./development.sh airflow.yml
	make airflow-flower-delete

dev-airflow:
	bash ./development.sh airflow-dev.yml
	make airflow-flower-delete

dev-airflow-delete:
	kubectl delete -f airflow-dev.yml

airflow-flower-delete:
	kubectl delete service airflow-flower
	kubectl delete deployment airflow-flower

sample-db:
	kubectl create -f sample-db.yml

backend:
	bash ./development.sh backend.yml

docker:
	bash ./development.sh docker.yml

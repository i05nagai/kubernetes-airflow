"""
Execute SQL in bigquery
"""
import airflow.operators.docker_operator as docker_operator


def _generate_bigquery_operator(
        dag,
        command,
        task_id,
        priority_weight,
        environment={}):
    return docker_operator.DockerOperator(
        api_version=settings.docker_api_version,
        docker_url=settings.DOCKER_URL,
        command=command,
        volumes=[],
        image='i05nagai/embulk:latest',
        network_mode='bridge',
        taks_id=task_id,
        environment=environment,
        dag=dag)


def generate_bigquery_operator(
        dag,
        path_to_sql,
        priority_weight,
        options_vm='',
        options='',
        environment={}):
    return docker_operator.DockerOperator(
        api_version=settings.docker_api_version,
        docker_url=settings.DOCKER_URL,
        command=command,
        volumes=[],
        image='i05nagai/embulk:latest',
        network_mode='bridge',
        taks_id=task_id,
        environment=environment,
        dag=dag)

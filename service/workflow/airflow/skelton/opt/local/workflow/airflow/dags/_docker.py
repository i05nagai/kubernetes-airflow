"""
Environment variables
=====================
* DOCKER_REGISTRY_HOST
* DOCKER_IMAGE_BASE
* DOCKER_REGISTRY_TAG
"""
from __future__ import unicode_literals

import operators.custom_docker_operator as custom_docker_operator
import settings


def gen_docker_operator(
        dag,
        command,
        task_id,
        priority_weight,
        image_name,
        environment=None,
        xcom_push=False,
        xcom_all=False):
    image = '{0}/{1}/{2}:{3}'.format(
        settings.DOCKER_REGISTRY_HOST,
        settings.DOCKER_IMAGE_BASE,
        image_name,
        settings.DOCKER_IMAGE_TAG)
    return custom_docker_operator.CustomDockerOperator(
        api_version='1.35',
        docker_url=settings.WORKFLOW_DOCKER_URL,
        force_pull=True,
        command=command,
        volumes=[],
        image=image,
        network_mode='bridge',
        task_id=task_id,
        environment=environment,
        xcom_push=xcom_push,
        xcom_all=xcom_all,
        docker_conn_id='docker',
        priority_weight=priority_weight,
        dag=dag)

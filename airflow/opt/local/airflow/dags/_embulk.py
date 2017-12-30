"""
Embulk operator
"""
import airflow.operators.docker_operator as docker_operator
import os
import re

import settings


def _generate_embulk_operator(
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
        task_id=task_id,
        environment=environment,
        dag=dag)


def _generate_embulk_commad(path, options_vm='', options=''):
    return 'embulk {0} run {1} {2}'.format(options_vm, options, path)


def _generate_task_id_from_filename(
        filenames,
        pattern=r'^([^_].+)\.yml\.liquid'):
    valid_filenames = []
    task_ids = []
    for filename in filenames:
        match = re.match(pattern, filename)
        if match:
            task_ids.append(match.group(1))
            valid_filenames.append(filename)
    return task_ids, valid_filenames


def generate_operators(
        dag,
        path_to_config_dir,
        priority_weight,
        options_vm='',
        options='',
        environment={}):
    filenames = os.listdir(path_to_config_dir)
    task_ids, filenames = _generate_task_id_from_filename(filenames)
    paths = [os.path.join(path_to_config_dir, fname) for fname in filenames]

    operators = []
    for path, task_id in zip(paths, task_ids):
        command = _generate_embulk_commad(path, options_vm, options)
        operator = _generate_embulk_operator(
            dag, command, task_id, priority_weight, environment)
        operators.append(operator)
    return operators

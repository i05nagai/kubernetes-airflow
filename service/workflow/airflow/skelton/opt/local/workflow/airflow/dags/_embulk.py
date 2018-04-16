from __future__ import unicode_literals

import os
import re

import settings
import _docker


VALID_CONFIG_REGEXP = r'config_(.*).yml.liquid'


def _gen_embulk_operator(
        dag,
        command,
        task_id,
        priority_weight,
        image_name,
        environment=None):
    return _docker.gen_docker_operator(
        dag,
        command,
        task_id,
        priority_weight,
        image_name,
        environment)


def _gen_embulk_command(path_to_config, options_vm, options, precommand):
    """_gen_embulk_command

    :param path_to_config:
    :param options_vm:
    :type options_vm: list
    :param options:
    :type options: list
    :param precommand: precommand is useful
        to export environent variables with macros since DockerOperator only
        supports macros in command arugment.
        TODO: environments arguments should supports macros of Airflow.
    :type precommand: list
    """
    options_vm_str = ' '.join(options_vm)
    options_str = ' '.join(options)
    embulk_command = 'embulk {0} run {1} {2}'.format(
        options_vm_str, options_str, path_to_config)
    if len(precommand) > 0:
        precommand_str = ' '.join(precommand)
        return 'bash -c "{0} {1}"'.format(precommand_str, embulk_command)
    else:
        return embulk_command


def _validate_config(config):
    match = re.match(VALID_CONFIG_REGEXP, config)
    if match:
        return match.group(1)
    return None


def _is_valid_config(config):
    match = re.match(VALID_CONFIG_REGEXP, config)
    if match:
        return True
    return False


def _gen_task_ids(configs):
    task_ids = []
    for config in configs:
        task_id = _validate_config(config)
        if task_id is not None:
            task_ids.append(task_id)
    return task_ids


def _get_filenames(path_to_config_dir):
    files = os.listdir(path_to_config_dir)
    return list(filter(_is_valid_config, files))


def _get_filenames_from_paths(paths):
    return [os.path.basename(path) for path in paths]


def gen_embulk_operators_from_paths(
        dag,
        paths_to_config,
        priority_weight,
        options_vm=[],
        options=[],
        image_name='embulk',
        environment={},
        precommand=[]):
    """gen_embulk_operators_from_paths

    :param dag:
    :param paths_to_config:
    :param priority_weight:
    :param options_vm:
    :type options_vm: list
    :param options:
    :type options: list
    :param image_name:
    :param environment:
    """
    if settings.DEBUG:
        options.append('--log-level trace')

    configs = _get_filenames_from_paths(paths_to_config)
    task_ids = _gen_task_ids(configs)

    operators = []
    for path_to_config, task_id in zip(paths_to_config, task_ids):
        command = _gen_embulk_command(
            path_to_config, options_vm, options, precommand)
        operator = _gen_embulk_operator(
            dag, command, task_id, priority_weight, image_name, environment)
        operators.append(operator)
    return operators


def gen_embulk_operators(
        dag,
        path_to_config_dir,
        priority_weight,
        options_vm=[],
        options=[],
        image_name='embulk',
        environment={},
        precommand=[]):
    """gen_embulk_operators
    Generate embulk operators from config files matches VALID_CONFIG_REGEXP.

    :param dag:
    :param path_to_config_dir:
    :param priority_weight:
    :param options_vm:
    :type options_vm: list
    :param options:
    :type options: list
    :param image_name:
    :param environment:
    """
    if settings.DEBUG:
        options.append('--log-level trace')
    configs = _get_filenames(path_to_config_dir)
    task_ids = _gen_task_ids(configs)

    # path
    path_to_configs = [os.path.join(path_to_config_dir, c) for c in configs]

    operators = []
    for path_to_config, task_id in zip(path_to_configs, task_ids):
        command = _gen_embulk_command(
            path_to_config, options_vm, options, precommand)
        operator = _gen_embulk_operator(
            dag, command, task_id, priority_weight, image_name, environment)
        operators.append(operator)
    return operators

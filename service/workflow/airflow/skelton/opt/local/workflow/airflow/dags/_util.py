import os
import re

import settings


def set_sequential_dependency(operators):
    for i, o in enumerate(operators[1:]):
        o.set_upstream(operators[i])


def get_filename_in(path, filename_pattern=None):
    filenames = os.listdir(path)
    if filename_pattern is not None:
        pattern = re.compile(filename_pattern)
        filenames = filter(pattern.search, filenames)
    return [os.path.join(path, filename) for filename in filenames]


def path_from_job(path_relative):
    path = os.path.join(
        settings.AIRFLOW_HOME,
        '..',
        'job',
        path_relative)
    return os.path.abspath(path)


def path_from_airflow_home(path_relative):
    return os.path.join(settings.AIRFLOW_HOME, path_relative)


def path_join(path_base, paths_relative):
    return [os.path.join(path_base, p) for p in paths_relative]


def get_dag_id(filepath):
    """get_dag_id
    Get dag_id from path as basename of dag file.
    :param filepath:
    Example
    =======
    >>> filepath = '/opt/local/airflow/job1.py'
    >>> get_dag_id(filepath)
    'job1'
    >>> filepath = 'job1.py'
    >>> get_dag_id(filepath)
    'job1'
    """
    filename = os.path.splitext(os.path.basename(filepath))[0]
    return filename

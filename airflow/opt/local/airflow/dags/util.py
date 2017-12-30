import os


def set_sequential_dependency(operators):
    for i, o in enumerate(operators[1:]):
        o.set_upstream(operators[i])


def set_parallel_dependency(parent_operator, child_operators):
    for o in child_operators:
        o.set_upstream(parent_operator)


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

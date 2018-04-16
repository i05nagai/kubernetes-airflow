import airflow
import airflow.operators.subdag_operator as subdag_operator

import util
import settings
import _embulk


def _generate_operators1(dag, environment):
    path_to_config_dir = '/opt/local/airflow/jobs/job1/embulk1'
    options_vm = ''
    options = ''
    priority_weight = 3

    return _embulk.generate_operators(
        dag,
        path_to_config_dir,
        priority_weight,
        options_vm,
        options,
        environment)


def _generate_operators2(dag, environment):
    path_to_config_dir = '/opt/local/airflow/jobs/job1/embulk2'
    options_vm = ''
    options = ''
    priority_weight = 5

    return _embulk.generate_operators(
        dag,
        path_to_config_dir,
        priority_weight,
        options_vm,
        options,
        environment)


def set_operators(dag):
    today = '{{ ds }}'
    environment = {
        'EVENT_DATE': today,
        'BIGQUERY_PROJECT': settings.BIGQUERY_PROJECT,
        'BIGQUERY_DATASET': settings.BIGQUERY_PROJECT,
        'GOOGLE_APPLICATION_CREDENTIALS': settings.GOOGLE_APPLICATION_CREDENTIALS,
        'MYSQL_USER': settings.MYSQL_USER,
        'MYSQL_DATABASE': settings.MYSQL_DATABASE,
        'MYSQL_PASSWORD': settings.MYSQL_PASSWORD,
    }
    operators1 = _generate_operators1(dag, environment)
    util.set_sequential_dependency(operators1)
    operators2 = _generate_operators2(dag, environment)
    util.set_sequential_dependency(operators2)


#
# Followings are templated format for DAG
#
def sub_dag_operator(
        dag,
        args,
        sub_dag_id=util.get_dag_id(__file__),
        schedule_interval='@daily'):
    dag_id = '{0}.{1}'.format(dag.dag_id, sub_dag_id)
    sub_dag = _dag(
        dag_id=dag_id,
        schedule_interval=schedule_interval)

    sub_dag_operator = subdag_operator.SubDagOperaotr(
        task_id=sub_dag_id,
        subdag=sub_dag,
        default_args=args,
        dag=dag)
    return sub_dag_operator


def _dag(dag_id=util.get_dag_id(__file__), schedule_interval='@daily'):
    default_args = settings.airflow_default_args

    dag = airflow.DAG(
        dag_id,
        default_args=default_args,
        schedule_interval=schedule_interval)
    set_operators(dag)
    return dag


dag = _dag()

"""
Add airflow user
"""
from __future__ import unicode_literals
import airflow
import airflow.contrib.auth.backends.password_auth as password_auth
import airflow.operators.python_operator as python_operator
import airflow.operators.subdag_operator as subdag_operator

import _util
import _notification
import settings_airflow


def add_airflow_user(ds, **kwargs):
    user = password_auth.PasswordUser(airflow.models.User())
    user.username = 'a'
    user.email = 'a'
    user._set_password = 'a'
    session = airflow.settings.Session()
    session.add(user)
    session.commit()
    session.close()


def set_operators(dag):
    # Task to add a connection
    t1 = python_operator.PythonOperator(
        dag=dag,
        task_id='add_airflow_user',
        python_callable=add_airflow_user,
        provide_context=True)


#
# Followings are templated for dags
#
def sub_dag_operator(
        dag,
        args,
        sub_dag_id=_util.get_dag_id(__file__),
        schedule_interval='@once'):
    dag_id = '{0}.{1}'.format(dag.dag_id, sub_dag_id)
    dag_subdag = _dag(
        dag_id=dag_id,
        schedule_interval=schedule_interval)

    sub_dag_operator = subdag_operator.SubDagOperator(
        task_id=sub_dag_id,
        subdag=dag_subdag,
        default_args=args,
        dag=dag)
    return sub_dag_operator


def _dag(
        dag_id=_util.get_dag_id(__file__),
        schedule_interval='@once'):
    # variables
    default_args = settings_airflow.airflow_default_args
    default_args['on_failure_callback'] = _notification.notify_error

    dag = airflow.DAG(
        dag_id,
        default_args=default_args,
        schedule_interval=schedule_interval)
    set_operators(dag)
    return dag


dag = _dag()

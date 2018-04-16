"""
Generate conn_id to GCS.
This dag should only be executed in CLI.

Environment variables
=======================
"""
from __future__ import unicode_literals
import airflow
import airflow.models as models
import airflow.operators.python_operator as python_operator
import airflow.operators.subdag_operator as subdag_operator

import _util
import _notification
import json
import settings
import settings_airflow


def add_gcp_connection(ds, **kwargs):
    """"Add a airflow connection for GCP"""
    GCP_PROJECT_ID = settings.GCP_PROJECT_ID
    PATH_TO_CREDENTIALS = settings.GCP_IAM_JSON_KEY_PATH

    new_conn = models.Connection(
        conn_id='google',
        conn_type='google_cloud_platform')
    scopes = [
        "https://www.googleapis.com/auth/pubsub",
        "https://www.googleapis.com/auth/datastore",
        "https://www.googleapis.com/auth/bigquery",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/cloud-platform",
        "https://www.googleapis.com/auth/devstorage.full_control",
    ]
    conn_extra = {
        "extra__google_cloud_platform__scope": ",".join(scopes),
        "extra__google_cloud_platform__project": GCP_PROJECT_ID,
        "extra__google_cloud_platform__key_path": PATH_TO_CREDENTIALS
    }
    conn_extra_json = json.dumps(conn_extra)
    new_conn.set_extra(conn_extra_json)

    session = airflow.settings.Session()
    if not (session
            .query(models.Connection)
            .filter(models.Connection.conn_id == new_conn.conn_id)
            .first()):
        session.add(new_conn)
        session.commit()
    else:
        msg = '\n\tA connection with `conn_id`={conn_id} already exists\n'
        msg = msg.format(conn_id=new_conn.conn_id)
        print(msg)


def set_operators(dag):
    # Task to add a connection
    t1 = python_operator.PythonOperator(
        dag=dag,
        task_id='add_gcp_connection',
        python_callable=add_gcp_connection,
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

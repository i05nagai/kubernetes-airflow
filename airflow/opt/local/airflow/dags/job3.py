import airflow
import airflow.operators.subdag_operator as subdag_operator
import airflow.operators.dummy_operator as dummy_operator

import util
import settings


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
    dummy_operator.DummyOperator(dag=dag, task_id='hoge')
    return dag


dag = _dag()

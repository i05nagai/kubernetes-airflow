import airflow
import datetime
import os


BIGQUERY_PROJECT = os.environ['BIGQUERY_PROJECT']
BIGQUERY_DATASET = os.environ['BIGQUERY_DATASET']
GOOGLE_APPLICATION_CREDENTIALS = os.environ['GOOGLE_APPLICATION_CREDENTIALS']
GCP_CREDENTIALS = os.environ['GCP_CREDENTIALS']
MYSQL_USER = os.environ['MYSQL_USER']
MYSQL_DATABASE = os.environ['MYSQL_DATABASE']
MYSQL_PASSWORD = os.environ['MYSQL_PASSWORD']

docker_api_version = '1.27'
DOCKER_URL = 'tcp://{0}:{1}'.format(
    os.environ['DOCKER_SERVICE_HOST'], os.environ['DOCKER_SERVICE_PORT'])
airflow_default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': airflow.utils.dates.days_ago(2),
    'email': ['airflow@airflow.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': datetime.timedelta(minutes=5),
    # 'queue': 'bash_queue',
    # 'pool': 'backfill',
    # 'priority_weight': 10,
    # 'end_date': datetime(2016, 1, 1),
}

import airflow
import datetime


airflow_default_args = {
    "owner": "Airflow",
    "depends_on_past": True,
    "start_date": airflow.utils.dates.days_ago(2),
    "email": None,
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 1,
    "wait_for_downstream": False,
    "retry_delay": datetime.timedelta(minutes=5),
    "sla": None,
    # "sla": datetime.timedelta(hours=100),
}

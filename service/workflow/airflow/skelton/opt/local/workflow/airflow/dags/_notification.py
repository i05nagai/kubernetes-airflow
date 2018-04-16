"""
"""
import slackweb
import airflow.operators.dummy_operator as dummy_operator

import settings


def notify_base(attachments):
    slack = slackweb.Slack(url=settings.SLACK_WEBHOOK_URL)
    slack.notify(attachments=attachments)


def notify_error(context):
    """notify_error
    Notification of failure of the task.
    Pass this function through the argument,
    `on_success_callback` or `on_failure_callback`, to an operator.

    :param context:

    :return: none
    """
    attachments = [
        {
            "fallback": "{0} error".format(context['task']),
            "color": "#b8312f",
            "title": "{0} {1}".format(context['dag'], context['task']),
            "title_link": settings.AIRFLOW_SERVER_URL,
            "text": "<!channel>"
        }
    ]
    notify_base(attachments)


def notify_success(context):
    """notify_success
    Notification of success of the task.
    Pass this function through the argument,
    `on_success_callback` to an operator.

    :param context:

    :return: None
    """
    attachments = [
        {
            "fallback": "{0} success".format(context['task']),
            "color": "#36a64f",
            "title": "{0} successfully end!".format(context['dag'], context['task']),
            "title_link": settings.AIRFLOW_SERVER_URL,
            "text": ":ok_woman:"
        }
    ]
    notify_base(attachments)


def notify_starting_dag(context):
    """notify_starting_dag
    Pass this function through the argument,
    `on_success_callback` or `on_failure_callback`, to an operator.

    :param context:

    :return: None

    :Example:

    .. code-block:: python

        import airflow.operators.sensors as sensors
        sensors.TimeSensor(
            task_id="time_sensor",
            target_time=datetime.time(hour=0, minute=0, second=0),
            dag=dag,
            on_success_callback=notify_starting_dag)
    """
    attachments = [
        {
            "fallback": "{0} starting".format(context['dag']),
            "color": "#36a64f",
            "title": "{0} start running!".format(context['dag']),
            "title_link": settings.AIRFLOW_SERVER_URL,
            "text": ":running:"
        }
    ]
    notify_base(attachments)


def notify_ending_dag(context):
    """notify_starting_dag
    Pass this function through the argument,
    `on_success_callback` or `on_failure_callback`, to an operator.

    :param context:

    :return: None
    """
    attachments = [
        {
            "fallback": "{0} success".format(context['dag']),
            "color": "#36a64f",
            "title": "{0} successfully end!".format(context['dag']),
            "title_link": settings.AIRFLOW_SERVER_URL,
            "text": ":ok_woman:"
        }
    ]
    notify_base(attachments)


def gen_starting_dag_op(dag, task_id='start_dag'):
    return dummy_operator.DummyOperator(
        task_id=task_id,
        dag=dag,
        on_success_callback=notify_starting_dag)


def gen_ending_dag_op(dag, task_id='end_dag'):
    return dummy_operator.DummyOperator(
        task_id=task_id,
        dag=dag,
        on_success_callback=notify_ending_dag)


def gen_notification_success(dag, task_id='notify_success'):
    return dummy_operator.DummyOperator(
        task_id=task_id,
        dag=dag,
        on_success_callback=notify_success)


def gen_notification_error(dag, task_id='notify_error'):
    return dummy_operator.DummyOperator(
        task_id=task_id,
        dag=dag,
        on_success_callback=notify_error)

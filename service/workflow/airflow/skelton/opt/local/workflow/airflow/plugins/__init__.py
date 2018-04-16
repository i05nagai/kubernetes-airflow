from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

from airflow.plugins_manager import AirflowPlugin

from operators import CustomDockerOperator
from hooks import CustomDockerHook


# Defining the plugin class
class WorkflowPlugin(AirflowPlugin):
    name = "workflow_plugin"
    operators = [
        CustomDockerOperator,
    ]
    hooks = [
        CustomDockerHook,
    ]

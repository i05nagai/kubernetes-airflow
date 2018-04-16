# -*- coding: utf-8 -*-
"""
This file copied from
https://raw.githubusercontent.com/apache/incubator-airflow/v1-9-stable/airflow/hooks/docker_hook.py
with slight modifications.
"""

from docker import Client
from docker.errors import APIError
import json

from airflow.exceptions import AirflowException
from airflow.hooks.base_hook import BaseHook
from airflow.utils.log.logging_mixin import LoggingMixin


class CustomDockerHook(BaseHook, LoggingMixin):
    """
    Interact with a private Docker registry.

    :param docker_conn_id: ID of the Airflow connection where
        credentials and extra configuration are stored
    :type docker_conn_id: str
    """

    def __init__(self,
                 docker_conn_id='docker_default',
                 base_url=None,
                 version=None,
                 tls=None
                 ):
        if not base_url:
            raise AirflowException('No Docker base URL provided')
        if not version:
            raise AirflowException('No Docker API version provided')

        conn = self.get_connection(docker_conn_id)
        if not conn.host:
            raise AirflowException('No Docker registry URL provided')
        if not conn.login:
            raise AirflowException('No username provided')
        extra_options = conn.extra_dejson

        self.__base_url = base_url
        self.__version = version
        self.__tls = tls
        self.__registry = conn.host
        self.__username = conn.login
        self.__password = conn.password
        self.__email = extra_options.get('email')
        self.__reauth = False if extra_options.get('reauth') == 'no' else True
        self.__dockercfg_path = extra_options.get('dockercfg_path')
        # if json_key
        if 'gcr.io' in conn.host and conn.login == '_json_key':
            json_key_path = extra_options.get('extra__google_cloud_platform__key_path')
            self.log.info('Loading json key from %s', json_key_path)
            self.__password = self._read_json(json_key_path)

    def _read_json(self, json_key_path):
        with open(json_key_path, 'r') as f:
            return f.read()

    def get_conn(self):
        client = Client(
            base_url=self.__base_url,
            version=self.__version,
            tls=self.__tls
        )
        self.__login(client)
        return client

    def __login(self, client):
        self.log.debug('Logging into Docker registry')
        try:
            client.login(
                username=self.__username,
                password=self.__password,
                registry=self.__registry,
                email=self.__email,
                reauth=self.__reauth,
                # dockercfg_path=self.__dockercfg_path,
            )
            self.log.debug('Login successful')
        except APIError as docker_error:
            self.log.error('Docker registry login failed: %s', str(docker_error))
            raise AirflowException('Docker registry login failed: %s', str(docker_error))

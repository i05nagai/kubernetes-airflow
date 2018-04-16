# -*- coding: utf-8 -*-
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

from google.cloud import bigquery
import io


def get_client(project_id):
    client = bigquery.Client(project=project_id)
    return client


def get_dataset(client, dataset_id):
    dataset_ref = client.dataset(dataset_id)
    dataset = bigquery.Dataset(dataset_ref)
    return dataset


def get_table(client, dataset_id, table_id, schema=None):
    dataset = get_dataset(client, dataset_id)
    table_ref = dataset.table(table_id)
    table = bigquery.Table(table_ref, schema=schema)
    return table


class Project(object):

    def __init__(self, client):
        self.client = client

    def _get_dataset(self, dataset_id):
        return get_dataset(self.client, dataset_id)

    def create_dataset(self, dataset_id, description=''):
        dataset = self._get_dataset(dataset_id)
        dataset.description = description
        dataset = self.client.create_dataset(dataset)
        return dataset

    def update_dataset(self, dataset_id, description):
        dataset = self._get_dataset(dataset_id)
        dataset.description = description
        dataset = self.client.update_dataset(dataset, ['description'])
        return dataset

    def delete_dataset(self, dataset_id):
        dataset = self._get_dataset(dataset_id)
        dataset = self.client.delete_dataset(dataset)
        return dataset


class Dataset(object):

    def __init__(self, client, dataset_id):
        self.client = client
        self.dataset = get_dataset(client, dataset_id)

    def get_tables(self):
        return list(self.client.list_dataset_tables(self.dataset))

    def _table(self, table_id, schema=None):
        table_ref = self.dataset.table(table_id)
        if schema is not None:
            table = bigquery.Table(table_ref, schema=schema)
        else:
            table = bigquery.Table(table_ref)
        return table

    def get_table(self, table_id):
        table = self._table(table_id)
        table = self.client.get_table(table)
        return table

    def exist_table(self, table_id):
        tables = self.get_tables()
        for table in tables:
            if table.table_id == table_id:
                return True

        return False

    def update_table(self, table_id, description):
        table = self._table(table_id)
        table.description = description
        table = self.client.update_table(table, ['description'])
        return table

    def create_table(self, table_id, schema_json):
        schema = json_to_schema(schema_json)
        table = self._table(table_id, schema)
        return self.client.create_table(table)


class QueryRunner(object):

    def __init__(self, client, timeout_sec=180):
        self.client = client
        self.timeout_sec = timeout_sec

    def run_from_file(self, filename, parameters=[]):
        query = ''
        try:
            with open(filename, 'r') as f:
                query = f.read()
        except IOError as e:
            print(e)
        return self.run_sync(query, parameters)

    def run_sync(self, query, parameters=[]):
        parameters = json_to_query_parameter(parameters)
        job_config = bigquery.QueryJobConfig()
        job_config.query_parameters = parameters
        query_job = self.client.query(
            query, job_config=job_config)

        iterator = query_job.result(timeout=self.timeout_sec)
        return list(iterator)

    def insert_rows_json(self, dataset_id, table_id, json_rows):
        """insert_rows_json
        Streaming insert.
        If you want to upload rows synchronically, use upload_data_into_table()

        :param dataset_id:
        :param table_id:
        :param json_rows:
        """
        table = get_table(self.client, dataset_id, table_id)
        errors = self.client.create_rows_json(table, json_rows)
        return errors


def row_to_dict(row):
    row_dict = {}
    for field, index in row._xxx_field_to_index.items():
        row_dict[field] = row[index]
    return row_dict


def json_to_schema(json_schema):
    """json_to_schema

    json_schema = [
        {
            "mode": "NULLABLE",
            "name": "log_date",
            "type": "DATE"
        },
    ]

    :param json_array:
    """
    valid_mode = [
        'NULLABLE',
        'REQUIRED',
        'REPEATED',
    ]
    valid_field_type = [
        'STRING',
        'INTEGER',
        'FLOAT',
        'BOOLEAN',
        'TIMESTAMP',
        'RECORD',
    ]
    schemas = []
    for col in json_schema:
        mode = col['mode'].upper()
        name = col['name']
        field_type = col['type'].upper()
        if 'description' in col:
            description = col['description']
        else:
            description = ''
        # recursively
        if field_type == 'RECORD':
            field_type = json_to_schema(field_type)
        schema = bigquery.SchemaField(
            name=name,
            mode=mode,
            field_type=field_type,
            description=description)
        schemas.append(schema)
    return schemas


def json_to_query_parameter(json_array):
    """json_to_query_parameter

    json_array = [
        {
            'name': 'corpus',
            'type': 'STRING',
            'value': corpus
        },
        {
            'name': 'min_word_count',
            'type': 'INT64',
            'value': [
            ]
        },
        {
            'name': 'min_word_count',
            'value': [
                {
                    'name': 'struct_param',
                    'type': 'INT64',
                    'value': 1
                }
            ]
        }
    ]
    parameters = json_to_query_parameter(json_array)
    print(parameters)
    [
        bigquery.ScalarQueryParameter('corpus', 'STRING', corpus),
        bigquery.ScalarQueryParameter(
            'min_word_count', 'INT64', min_word_count)
    ]

    :param json_array:
    """
    valid_type = [
        'STRING',
        'INT64',
        'FLOAT64',
        'BOOL',
        'TIMESTAMP',
        'DATETIME',
        'DATE',
    ]
    parameters = []
    for param in json_array:
        name = param['name']
        value = param['value']
        # array
        if isinstance(value, list):
            param_type = param['type'].upper()
            p = bigquery.ArrayQueryParameter(name, param_type, value)
        # struct
        elif isinstance(value, dict):
            sub_parameters = json_to_query_parameter(value)
            p = bigquery.StructQueryParameter(name, sub_parameters)
        # scalar
        else:
            param_type = param['type'].upper()
            p = bigquery.ScalarQueryParameter(name, param_type, value)
        parameters.append(p)
    return parameters


def json_row_to_str(json_row):
    return str({str(k): v for k, v in json_row.items()})


def upload_jsons_into_table(
        client, dataset_id, table_id, json_rows):
    jsons = ',\n'.join([json_row_to_str(json_row) for json_row in json_rows])
    json_file = io.BytesIO(b'{0}'.format(jsons))
    dataset = get_dataset(client, dataset_id)
    table_ref = dataset.table(table_id)

    job_config = bigquery.LoadJobConfig()
    job_config.source_format = 'NEWLINE_DELIMITED_JSON'
    job = client.load_table_from_file(
        json_file, table_ref, job_config=job_config)
    # Waits for table load to complete.
    return job.result()


import bigquery
import settings


def main():
    client = bigquery.get_client(settings.BIGQUERY_PROJECT)
    query_runner = bigquery.QueryRunner(client)
    result = query_runner.run_from_file('./query.sql')
    print(result)


if __name__ == '__main__':
    main()

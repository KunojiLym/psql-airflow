from datetime import datetime, timedelta
from airflow import DAG
from airflow.hooks.postgres_hook import PostgresHook
from airflow.operators.python import PythonOperator

default_args = {
 'owner': 'airflow',
 'depends_on_past': False,
 'start_date': datetime(2020, 10, 13),
 'email': ['kunojilym@gmail.com'],
 'email_on_failure': False,
 'email_on_retry': False,
 'retries': 1,
 'retry_delay': timedelta(minutes=10),
}

def init_table():
    ## set up the connection and cursor for destination db
    dest = PostgresHook(postgres_conn_id='psql_dest')
    dest_conn = dest.get_conn()
    dest_cursor = dest_conn.cursor()

    ## create table if none exists, then clear table just in case
    dest_cursor.execute("""
        CREATE TABLE IF NOT EXISTS sales (
            id              NUMERIC PRIMARY KEY NOT NULL,
            creation_date   DATE NOT NULL,
            sale_value      NUMERIC NOT NULL
        );"""
        )
    dest_conn.commit()
    
    dest_cursor.execute("DELETE FROM sales;")
    dest_conn.commit()
    dest_conn.close()
    
def transfer_psql():
    ## set up the connections and cursors for source and destination db
    src = PostgresHook(postgres_conn_id='psql_origin')
    dest = PostgresHook(postgres_conn_id='psql_dest')
    src_conn = src.get_conn()
    src_cursor = src_conn.cursor()
    dest_conn = dest.get_conn()
    dest_cursor = dest_conn.cursor()

    ## takes all records from source and insert into destination
    src_cursor.execute("SELECT * FROM sales;")
    dest.insert_rows(table="sales", rows=src_cursor)

    ## close all connections
    dest_conn.close()
    src_conn.close()

with DAG(
    dag_id = 'psql_copy',
    default_args = default_args,
    start_date = datetime(2021, 5, 22),
    schedule_interval = "@once"
) as dag:
    init = PythonOperator(
        task_id = 'psql_init',
        python_callable = init_table
    )

    transfer = PythonOperator(
        task_id = 'psql_transfer',
        python_callable = transfer_psql
    )

    init >> transfer
# psql-airflow
 Demo of transferring PSQL database between Docker containers. Assumes that user is running Linux and has Docker 20.04 or above installed

# Setup

## 1. Properties for source Postgres DB:
- Location: psql-origin
- Username: postgres-user
- Password: postgres-passwd
- Database (source): sales_db
- Port: 7654

## 2. Properties for destination Postgres DB:
- Location: psql-dest
- Username: other-postgres-user
- Password: other-postgres-passwd
- Database (destination): other-postgres-db
- Port: 6543

## 3. Properties for Airflow:
- Username: airflow
- Password: airflow

Table to be transferred:
- sales
# Instructions

## 1. Build and deploy Postgres DBs and Airflow

Run deploy.sh *OR* do the following:

- In psql-origin/, run "docker build -t psqlairflow-db-origin:latest" 
- In psql-dest/, run "docker build -t psqlairflow-db-dest:latest" 
- In root folder, run "docker compose up"
- In airflow/, run "docker-compose up airflow-init", followed by "docker compose up --add-host=host.docker.internal:host-gateway"
    - host.docker.internal is needed to communicate with the host machine for the Docker container

### To verify that the initial DB setup is sucessful:
- Connect to sales_db at postgres://localhost:7654 and run "SELECT * FROM sales;"
    - 2 records with IDs 0 and 1 should be displayed
- Connect to other-postgres-db at postgres://localhost:6543 and run "/dt;"
    - No table named sales should exist

## 2. Set up Airflow connections to Postgres DBs

Run connections.sh *OR* do the following:

- Connect and login to Airflow at http://localhost:5884
    - User: airflow, Password: airflow
- Navigate to Admin -> Connections
- Create 2 connections as follows:
    - {Conn Id: psql_origin, Conn Type: postgres, Host: host.docker.internal, Port: 7654, Login: postgres-user, Password: postgres-passwd, dbname: sales_db}
    - {Conn Id: psql_dest, Conn Type: postgres, Host: host.docker.internal, Port: 6543, Login: other-postgres-user, Password: other-postgres-passwd, dbname: other-postgres-db}
- Reload Airflow by running "docker compose down" followed by "docker compose up --add-host=host.docker.internal:host-gateway" in airflow/
    - This is to ensure that psql-copy-dag.py loads properly

## 3. Run the Airflow data pipeline

Run trigger-airflow.sh *OR* do the following

- Run psql-copy in Airflow, no additional parameters required

### To verify that the pipeline is sucessful:
- Connect to sales_db at postgres://localhost:7654 and run "SELECT * FROM sales;"
    - 2 records with IDs 0 and 1 should be displayed
- Connect to other-postgres-db at postgres://localhost:6543 and run "SELECT * FROM sales;"
    - 2 records with IDs 0 and 1 should be displayed, and they should be identical to the records in sales_db


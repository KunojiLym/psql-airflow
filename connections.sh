#!/usr/bin/env bash

# 2.1 Create Airflow connections
curl --user airflow:airflow -d @psql-origin.json -H "Content-Type: application/json" -X POST http://localhost:5884/api/v1/connections
curl --user airflow:airflow -d @psql-dest.json -H "Content-Type: application/json" -X POST http://localhost:5884/api/v1/connections

# 2.2 Reload Airflow
sudo docker compose -f airflow/docker-compose.yaml down
sudo docker compose -f airflow/docker-compose.yaml up --add-host=host.docker.internal:host-gateway --detach
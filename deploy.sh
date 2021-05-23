#!/usr/bin/env bash

# 1. Deploy Postgres DBs as a Docker stack
sudo docker compose up --detach

# 2. Build and deploy Airflow
sudo docker compose -f airflow/docker-compose.yaml up airflow-init
sudo docker compose -f airflow/docker-compose.yaml up --detach
#!/usr/bin/env bash

# 1. Deploy Postgres DBs as a Docker stack
docker compose up --detach

# 2. Build and deploy Airflow
docker compose -f airflow/docker-compose.yaml up airflow-init
docker compose -f airflow/docker-compose.yaml up --add-host=host.docker.internal:host-gateway --detach
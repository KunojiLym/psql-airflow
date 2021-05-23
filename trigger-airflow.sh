#!/usr/bin/env bash

curl --user airflow:airflow -X POST "http://localhost:5884/api/v1/dags/psql_copy/dagRuns" -H  "accept: application/json" -H  "Content-Type: application/json" -d "{\"conf\":{}}"
#!/usr/bin/env bash

# Build Postgres DBs
docker build -t yzouyang/psqlairflow-db-origin:latest ./psql-origin
docker build -t yzouyang/psqlairflow-db-dest:latest ./psql-dest
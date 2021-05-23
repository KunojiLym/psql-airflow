#!/usr/bin/env bash

# Build Postgres DBs
sudo docker build -t yzouyang/psqlairflow-db-origin:latest ./psql-origin
sudo docker build -t yzouyang/psqlairflow-db-dest:latest ./psql-dest
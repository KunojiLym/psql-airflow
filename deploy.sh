# 1. Build and deploy Postgres DBs as a Docker stack
docker build -f psql-origin/Dockerfile -t psqlairflow-db-origin:latest
docker build -f psql-dest/Dockerfile -t psqlairflow-db-dest:latest
docker compose up --detach

# 2. Build and deploy Airflow
docker compose -f airflow/docker-compose.yaml up airflow-init
docker compose -f airflow/docker-compose.yaml up --add-host=host.docker.internal:host-gateway --detach
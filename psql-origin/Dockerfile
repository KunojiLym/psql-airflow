FROM postgres:alpine

LABEL MAINTAINER Yingzhao Ouyang <KunojiLym@gmail.com>

ENV POSTGRES_USER           postgres-user
ENV POSTGRES_PASSWORD       postgres-passwd
ENV POSTGRES_DB             postgres-db

COPY setup.sql /docker-entrypoint-initdb.d/
ADD setup.sql /docker-entrypoint-initdb.d
RUN chmod a+r /docker-entrypoint-initdb.d/*

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql", "/usr/lib/postgresql/"]
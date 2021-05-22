FROM postgres:alpine

LABEL MAINTAINER Yingzhao Ouyang <KunojiLym@gmail.com>

ENV POSTGRES_USER           other-postgres-user
ENV POSTGRES_PASSWORD       other-postgres-passwd
ENV POSTGRES_DB             other-postgres-db

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql", "/usr/lib/postgresql/"]
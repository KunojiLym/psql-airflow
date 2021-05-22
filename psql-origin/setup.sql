CREATE DATABASE sales_db;

\connect sales_db

CREATE TABLE IF NOT EXISTS sales (
    id              NUMERIC PRIMARY KEY NOT NULL,
    creation_date   DATE NOT NULL,
    sale_value      NUMERIC NOT NULL
);

INSERT INTO sales(id, creation_date, sale_value)
VALUES (0, '2021-12-12', 1000), (1, '2021-12-13', 2000);
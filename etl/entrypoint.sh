#!/usr/bin/env bash
set -euo pipefail

: "${DB_HOST:?Missing DB_HOST}"
: "${DB_PORT:?Missing DB_PORT}"
: "${DB_USER:?Missing DB_USER}"
: "${DB_PASS:?Missing DB_PASS}"
: "${DB_NAME:?Missing DB_NAME}"

echo "Waiting for MySQL at ${DB_HOST}:${DB_PORT}..."
for i in {1..60}; do
  if mysqladmin ping -h "${DB_HOST}" -P "${DB_PORT}" -u "${DB_USER}" -p"${DB_PASS}" --silent; then
    echo "MySQL is up!"
    break
  fi
  echo "Waiting... ($i)"
  sleep 1
done

echo "Starting ETL..."
python etl.py

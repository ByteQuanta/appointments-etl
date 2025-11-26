FROM python:3.10-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        default-mysql-client \
        build-essential \
        git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# etl klasöründeki dosyaları aplikasyona kopyala
COPY etl/etl.py /app/etl.py
COPY etl/02_transform.sql /app/02_transform.sql
COPY etl/03_tests.sql /app/03_tests.sql
COPY etl/entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh

CMD ["/app/entrypoint.sh"]



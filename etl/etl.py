import os
import pandas as pd
from sqlalchemy import create_engine, text
import kagglehub
import logging

logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(message)s")
log = logging.getLogger()


# -----------------------------
# 1) RAW DATA
# -----------------------------
log.info("Downloading Kaggle dataset...")

path = kagglehub.dataset_download("joniarroba/noshowappointments")
df = pd.read_csv(f"{path}/KaggleV2-May-2016.csv")

log.info("Dataset downloaded successfully.")


# -----------------------------
# 2) CLEANING
# -----------------------------
log.info("Cleaning dataset...")

df = df.rename(columns={'No-show': 'No_Show'})
df['ScheduledDay'] = pd.to_datetime(df['ScheduledDay'], utc=True, errors='coerce')
df['AppointmentDay'] = pd.to_datetime(df['AppointmentDay'], utc=True, errors='coerce')

df['ScheduledDayTS'] = (df['ScheduledDay'].dt.floor('d').astype('int64') // 10**9).astype(int)
df['AppointmentDayTS'] = (df['AppointmentDay'].dt.floor('d').astype('int64') // 10**9).astype(int)
df['WaitDays'] = (df['AppointmentDayTS'] - df['ScheduledDayTS']) / 86400

log.info("Cleaning completed.")


# -----------------------------
# 3) EXPORT TO MYSQL
# -----------------------------
engine = create_engine(
    f"mysql+pymysql://{os.environ['DB_USER']}:{os.environ['DB_PASS']}@"
    f"{os.environ['DB_HOST']}:{os.environ['DB_PORT']}/{os.environ['DB_NAME']}",
    isolation_level="AUTOCOMMIT"
)

log.info("Uploading raw_appointments table...")
df.to_sql("raw_appointments", con=engine, if_exists="replace", index=False)
log.info("Upload finished.")


# -----------------------------
# 4) RUN TRANSFORM SQL
# -----------------------------
log.info("Running transform SQL...")

with engine.connect().execution_options(autocommit=True) as conn:
    sql_script = open("02_transform.sql", "r", encoding="utf-8").read()
    for stmt in filter(None, [s.strip() for s in sql_script.split(";")]):
        conn.execute(text(stmt))

log.info("Transform completed.")


# -----------------------------
# 5) RUN TEST SQL
# -----------------------------
log.info("Running test SQL...")

with engine.connect().execution_options(autocommit=True) as conn:
    test_script = open("03_tests.sql", "r", encoding="utf-8").read()
    for stmt in filter(None, [s.strip() for s in test_script.split(";")]):
        res = conn.execute(text(stmt))
        try:
            print(res.fetchall())
        except:
            pass

log.info("ETL pipeline completed successfully!")




DROP TABLE IF EXISTS cleaned_appointments;

CREATE TABLE cleaned_appointments AS
SELECT
    PatientId,
    AppointmentID,
    UPPER(Gender) AS Gender,
    FLOOR(ScheduledDayTS/86400)*86400 AS ScheduledDayTS,
    FLOOR(AppointmentDayTS/86400)*86400 AS AppointmentDayTS,
    Age,
    Neighbourhood,
    Scholarship,
    Hipertension,
    Diabetes,
    Alcoholism,
    Handcap,
    SMS_received,
    CASE WHEN LOWER(No_Show) IN ('yes','y') THEN 1 ELSE 0 END AS No_show,
    (FLOOR(AppointmentDayTS/86400)*86400 - FLOOR(ScheduledDayTS/86400)*86400) / 86400 AS WaitDays
FROM raw_appointments;



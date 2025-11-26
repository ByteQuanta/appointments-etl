SELECT COUNT(*) AS total_rows FROM cleaned_appointments;

SELECT COUNT(*) AS negative_waitdays
FROM cleaned_appointments
WHERE WaitDays < 0;

SELECT COUNT(*) AS null_values
FROM cleaned_appointments
WHERE
    PatientId IS NULL OR
    AppointmentID IS NULL OR
    ScheduledDayTS IS NULL OR
    AppointmentDayTS IS NULL;




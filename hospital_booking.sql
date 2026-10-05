-- HOSPITAL APPOINTMENT SLOT BOOKING SYSTEM

DROP DATABASE IF EXISTS hospital_booking;
CREATE DATABASE hospital_booking;
USE hospital_booking;


-- 1. DOCTORS TABLE
CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(15)
);

INSERT INTO doctors VALUES
(1, 'Dr. Ananya Sharma', 'Cardiologist', '9876543210'),
(2, 'Dr. Rahul Mehta', 'Dermatologist', '9876543211'),
(3, 'Dr. Priya Nair', 'Pediatrician', '9876543212'),
(4, 'Dr. Arjun Rao', 'Orthopedic', '9876543213');


-- 2. PATIENTS TABLE
CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(10),
    phone VARCHAR(15)
);

INSERT INTO patients VALUES
(1, 'Nandini', 19, 'Female', '9000000001'),
(2, 'Aarav', 20, 'Male', '9000000002'),
(3, 'Meera', 21, 'Female', '9000000003'),
(4, 'Rohan', 22, 'Male', '9000000004');


-- 3. APPOINTMENT SLOTS TABLE
CREATE TABLE slots (
    slot_id INT PRIMARY KEY,
    doctor_id INT,
    appointment_date DATE,
    appointment_time TIME,
    status VARCHAR(20) DEFAULT 'Available',

    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

INSERT INTO slots VALUES
(1, 1, '2026-10-10', '10:00:00', 'Available'),
(2, 1, '2026-10-10', '11:00:00', 'Available'),
(3, 2, '2026-10-10', '10:00:00', 'Available'),
(4, 2, '2026-10-10', '11:00:00', 'Available'),
(5, 3, '2026-10-10', '12:00:00', 'Available'),
(6, 4, '2026-10-10', '02:00:00', 'Available');


-- 4. APPOINTMENTS TABLE
CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    slot_id INT UNIQUE,
    reason VARCHAR(200),

    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (slot_id) REFERENCES slots(slot_id)
);


-- 5. BOOK APPOINTMENTS

INSERT INTO appointments VALUES
(1, 1, 1, 'Regular checkup'),
(2, 2, 3, 'Skin allergy'),
(3, 3, 5, 'Child health consultation'),
(4, 4, 6, 'Knee pain');


-- 6. UPDATE BOOKED SLOTS

UPDATE slots
SET status = 'Booked'
WHERE slot_id IN (1, 3, 5, 6);


-- 7. DISPLAY ALL DOCTORS
SELECT * FROM doctors;


-- 8. DISPLAY ALL PATIENTS
SELECT * FROM patients;


-- 9. DISPLAY AVAILABLE SLOTS
SELECT 
    s.slot_id,
    d.doctor_name,
    d.specialization,
    s.appointment_date,
    s.appointment_time
FROM slots s
JOIN doctors d ON s.doctor_id = d.doctor_id
WHERE s.status = 'Available';


-- 10. DISPLAY BOOKED APPOINTMENTS
SELECT 
    a.appointment_id,
    p.patient_name,
    d.doctor_name,
    d.specialization,
    s.appointment_date,
    s.appointment_time,
    a.reason
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN slots s ON a.slot_id = s.slot_id
JOIN doctors d ON s.doctor_id = d.doctor_id;


-- 11. CANCEL AN APPOINTMENT

DELETE FROM appointments
WHERE appointment_id = 4;

UPDATE slots
SET status = 'Available'
WHERE slot_id = 6;


-- 12. CHECK AVAILABLE SLOTS FOR A PARTICULAR DOCTOR

SELECT 
    d.doctor_name,
    s.appointment_date,
    s.appointment_time,
    s.status
FROM doctors d
JOIN slots s ON d.doctor_id = s.doctor_id
WHERE d.doctor_id = 1;

CREATE DATABASE HOSPITALS_db;
USE HOSPITALS_db;
SHOW DATABASES;
SHOW TABLES;
CREATE TABLE Patients(patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,age INT,
    gender VARCHAR(10),city VARCHAR(50));
INSERT INTO Patients
(patient_id, patient_name, age, gender, city)
VALUES
(1, 'Anu', 25, 'Female', 'Kollam'),
(2, 'Manu', 35, 'Male', 'Kochi'),
(3, 'Riya', 42, 'Female', 'Trivandrum'),
(4, 'Arun', 30, 'Male', 'Kottayam'),
(5, 'Meera', 28, 'Female', 'Alappuzha');
SELECT * FROM patients;
CREATE TABLE Doctors(doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    consultation_fee DECIMAL(10,2));
INSERT INTO Doctors
(doctor_id, doctor_name, specialization, consultation_fee)
VALUES
(101, 'Dr. Anil', 'Cardiology', 800.00),
(102, 'Dr. Meera', 'Neurology', 1000.00),
(103, 'Dr. Rahul', 'Dermatology', 600.00),
(104, 'Dr. Priya', 'Pediatrics', 500.00),
(105, 'Dr. Arun', 'Orthopedics', 750.00);

select *from Doctors;
CREATE TABLE Appointmentz(appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    status VARCHAR(30),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id));
INSERT INTO Appointmentz
(appointment_id, patient_id, doctor_id, appointment_date, 
status)
VALUES
(1, 3, 101, '2026-10-15', 'Completed'),
(2, 3, 102, '2026-10-16', 'Scheduled'),
(3, 1, 103, '2026-10-17', 'Pending'),
(4, 2, 104, '2026-10-18', 'Scheduled'),
(5, 3, 105, '2026-10-19', 'Cancelled');
SELECT * FROM Appointmentz;
SELECT * FROM Doctors;
SELECT * FROM patients;
SELECT * FROM patients WHERE age > 40;
SELECT * FROM patients WHERE city ="Kollam";
SELECT* FROM Doctors WHERE specialization="Cardiology"; 
SELECT * FROM Doctors WHERE consultation_fee >500;
SELECT * FROM Appointmentz WHERE appointment_date ="2026-10-16";
SELECT * FROM Appointmentz WHERE status ="Completed";
SELECT COUNT(*) FROM Appointmentz;
UPDATE Appointmentz SET status = "Completed" 
WHERE appointment_id =1;
UPDATE Doctors SET consultation_fee =1200.00
WHERE doctor_id=102;
DELETE FROM Appointmentz WHERE appointment_id=10
AND status ="Cancelled";
SELECT * FROM Appointmentz WHERE status ="Completed";
SELECT * FROM Appointmentz;
SELECT
    Appointmentz.appointment_id,
    Patients.patient_name,
    Doctors.doctor_name,
    Appointmentz.appointment_date
FROM Appointmentz
INNER JOIN Patients
ON Appointmentz.patient_id = Patients.patient_id
INNER JOIN Doctors
ON Appointmentz.doctor_id = Doctors.doctor_id;

DESC Appointmentz;
DESC Patients;
DESC Doctors;

SELECT
    Patients.patient_id,
    Patients.patient_name,
    Appointmentz.appointment_id,
    Appointmentz.appointment_date
FROM Patients
LEFT JOIN Appointmentz
ON Patients.patient_id = Appointmentz.patient_id;

SELECT
    Doctors.doctor_id,
    Doctors.doctor_name,
    Appointmentz.appointment_id,
    Appointmentz.appointment_date
FROM Doctors
LEFT JOIN Appointmentz
ON Doctors.doctor_id = Appointmentz.doctor_id;

SELECT
    Patients.patient_name,
    Doctors.doctor_name
FROM Appointmentz
INNER JOIN Patients
ON Appointmentz.patient_id = Patients.patient_id
INNER JOIN Doctors
ON Appointmentz.doctor_id = Doctors.doctor_id;

SELECT
    Appointmentz.appointment_id,
    Patients.patient_name,
    Doctors.doctor_name,
    Appointmentz.appointment_date,
    Appointmentz.status
FROM Appointmentz
INNER JOIN Patients
ON Appointmentz.patient_id = Patients.patient_id
INNER JOIN Doctors
ON Appointmentz.doctor_id = Doctors.doctor_id
WHERE Doctors.doctor_name = 'Dr. Anil';

SELECT
    Patients.patient_name,
    Doctors.doctor_name,
    Doctors.specialization
FROM Appointmentz
INNER JOIN Patients
ON Appointmentz.patient_id = Patients.patient_id
INNER JOIN Doctors
ON Appointmentz.doctor_id = Doctors.doctor_id
WHERE Doctors.specialization = 'Neurology';

SELECT COUNT(*) AS Total_appointment
FROM Appointmentz;
SELECT doctor_id, COUNT(*) AS Total_appointment
FROM Appointmentz GROUP BY doctor_id;
SELECT AVG(consultation_fee)AS Average_fee FROM Doctors;

SELECT Doctors.doctor_id, Doctors.doctor_name,
       COUNT(Appointmentz.appointment_id) AS Total_Appointments
FROM Doctors
INNER JOIN Appointmentz
ON Doctors.doctor_id = Appointmentz.doctor_id
GROUP BY Doctors.doctor_id, Doctors.doctor_name
HAVING COUNT(Appointmentz.appointment_id) > 2;

SELECT *FROM Doctors
WHERE consultation_fee>
    (SELECT AVG(consultation_fee)FROM Doctors);
    
SELECT * FROM Patients WHERE patient_id IN(
       SELECT patient_id FROM Appointmentz);

SELECT * FROM Patients WHERE patient_id NOT IN(
       SELECT patient_id FROM Appointmentz);

SELECT *
FROM Patients p
WHERE NOT EXISTS(
    SELECT 1
    FROM Appointmentz a
    WHERE a.patient_id = p.patient_id);

ALTER TABLE Patients ADD phone VARCHAR(15);
ALTER TABLE Doctors ADD department VARCHAR(50);
ALTER TABLE Doctors MODIFY doctor_name VARCHAR(150);
ALTER TABLE Doctors ADD CONSTRAINT chk_consultation_fee
CHECK (consultation_fee >=0);

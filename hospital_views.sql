USE hospital;
DROP VIEW IF EXISTS full_patients_info;
DROP VIEW IF EXISTS full_physician_info;
DROP VIEW IF EXISTS full_nurse_info;
DROP VIEW IF EXISTS room_occupancy;
DROP VIEW IF EXISTS patient_payment;

CREATE VIEW full_patients_info AS
SELECT p.id AS 'Patient ID', CONCAT(p.f_name, ' ', p.m_name, ' ', p.l_name) AS 'Name', p.address AS 'Address', p.phone_number AS 'Phone Number', pa.room_id AS 'Room'
FROM person p, patient pa
WHERE p.id=pa.patient_id;

CREATE VIEW full_physician_info AS
SELECT p.id AS 'Physician ID', CONCAT(p.f_name, ' ', p.m_name, ' ', p.l_name) AS 'Name', p.address AS 'Address', p.phone_number AS 'Phone Number', p.certification_num AS 'Certification Number', ph.expertise_field AS 'Expertise'
FROM person p, physician ph
WHERE p.id=ph.id;

CREATE VIEW full_nurse_info AS
SELECT p.id AS 'Nurse ID', CONCAT(p.f_name, ' ', p.m_name, ' ', p.l_name) AS 'Name', p.address AS 'Address', p.phone_number AS 'Phone Number', p.certification_num AS 'Certification Number'
FROM person p, nurse n
WHERE p.id=n.id;

CREATE VIEW room_occupancy AS
SELECT r.room_id AS 'Room ID', r.capacity AS 'Capacity', COUNT(p.patient_id) AS 'Current Occupancy'
FROM room r
LEFT JOIN patient p ON r.room_id = p.room_id
GROUP BY r.room_id, r.capacity;

CREATE VIEW patient_payment AS
SELECT p.id AS 'Patient ID', CONCAT(p.f_name, ' ', p.m_name, ' ', p.l_name) AS 'Name', pp.bill_id AS 'BILL ID', pp.total_amount AS 'Payment Due'
FROM person p, pays_invoice pp
WHERE p.id = pp.patient_id;


SELECT * FROM full_patients_info;
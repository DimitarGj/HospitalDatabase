USE hospital;

START TRANSACTION;

INSERT INTO person (id, f_name, m_name, l_name, address, phone_number, certification_num)VALUES
(45, 'Debra', 'M', 'Collins', '234 Burr Ridge', '123456', NULL);

INSERT INTO patient (patient_id, room_id, nights_hospitalized)
VALUES (45, 3, 3);

INSERT INTO health_records (records_id, disease, date, status, description)
VALUES (123, 'COVID-19', '2023-07-28', 'Active', 'Patient was diagnosed with COVID-19.');

INSERT INTO instructions (code, description, fee)VALUES
(1001, 'Put on ventilator', '50');

INSERT INTO orders (physician_id, patient_id, inst_code)
VALUES (1, 45, 1001);

INSERT INTO executes (nurse_id, patient_id, inst_code)
VALUES (2, 45, 1001);

COMMIT;

START TRANSACTION;

SELECT bill_id, instructions_fee, total_amount
FROM pays_invoice
WHERE patient_id = 4;

UPDATE pays_invoice
SET total_amount = total_amount + 100
WHERE patient_id = 4;

COMMIT;
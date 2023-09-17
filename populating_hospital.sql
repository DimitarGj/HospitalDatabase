INSERT INTO person (f_name, m_name, l_name, address, phone_number, certification_num)VALUES
('James', 'M', 'Alex', '234 Chicago', '123456', 123),
('Andrew', 'A', 'Ben', '124 Chicago', '436746', 122),
('Doe', 'M', 'Jane', '453 Chicago', '78986', NULL),
('Johnson', 'S', 'John', '789 Chicago', '87098', NULL),
('Phillips', 'C', 'Bruce', '555 Chicago', '787435', 135),
('Ahmad', 'B', 'Kazm', '678 Chicago', '372819', NULL),
('Ali', 'R', 'Borhan', '432 Chicago', '789267', 144);


INSERT INTO physician (id, expertise_field)VALUES 
(1, 'Cardiology'),
(5, 'Neurology');

INSERT INTO nurse (id)VALUES 
(2),
(7);

INSERT INTO monitors (physician_id, patient_id, duration)VALUES
(1, 3, 7),
(5, 4, 3),
(5, 6, 10);

INSERT INTO room (capacity, fee)VALUES 
(2, '150'),
(1, '200'),
(3, '100');

INSERT INTO health_records (disease, date, status, description)VALUES
('Fever', '2023-07-10', 'Positive', 'High fever.'),
('Fracture', '2023-07-11', 'Recovered', 'fractured arm.'),
('Headache', '2023-07-12', 'Recovered', 'severe headache.'),
('Cancer', '2023-07-12', 'Positive', 'Second Stage');

INSERT INTO has_records (patient_id, records_id)VALUES
(3, 1),
(6, 2),
(6, 3),
(4, 4);

INSERT INTO instructions (description, fee)VALUES
('Give IV', '50'),
('Physical therapy', '70'),
('Chemotherapy', '100'),
('Bed rest', '40');

INSERT INTO orders (physician_id, patient_id, inst_code)VALUES
(1, 3, 1),
(1, 3, 4),
(5, 4, 3),
(5, 4, 4),
(5, 6, 2),
(5, 6, 4);

INSERT INTO executes (nurse_id, patient_id, inst_code)VALUES
(2, 3, 1),
(2, 3, 4),
(2, 4, 3),
(2, 4, 4),
(7, 6, 2),
(7, 6, 4);

INSERT INTO med_supply (medication_id, nurse_id, patient_id, amount, cost, pharmacy)VALUES
(1, 2, 3, 5, '50', 'Walgreens Pharmacy'),
(2, 7, 6, 3, '30', 'CVS Pharmacy'),
(3, 2, 6, 3, '20', 'CVS Pharmacy'),
(4, 2, 4, 3, '80', 'CVS Pharmacy'),
(5, 7, 4, 3, '30', 'CVS Pharmacy'),
(6, 7, 3, 2, '20', 'Walgreens Pharmacy');

INSERT INTO patient (patient_id, room_id, nights_hospitalized)VALUES
(3, 1, 5),
(4, 2, 50),
(6, 1, 15);

INSERT INTO bill (instructions_fee)VALUES 
(90),
(140),
(110);

INSERT INTO pays_invoice (patient_id, bill_id, room_id, nights_hospitalized, instructions_fee, total_amount, date)VALUES 
(3, 1, 1, 5, 90, 840, '2023-09-22'),
(4, 2, 2, 50, 140, 10140, '2024-01-31'),
(6, 3, 1, 15, 110, 2360, '2023-11-08');

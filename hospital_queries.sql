-- JOIN QUERIES START HERE-- 

-- print which patient requires which instructions or medicine
SELECT CONCAT(pe.f_name, ' ', pe.m_name, ' ', pe.l_name) patient_name, i.description AS instructions,m.medication_id,m.cost AS medication_cost FROM patient p 
JOIN executes e ON p.patient_id = e.patient_id JOIN instructions i ON e.inst_code = i.code JOIN med_supply m ON e.nurse_id = m.nurse_id AND p.patient_id = m.patient_id
JOIN person pe ON p.patient_id = pe.id;    


-- printing name of physician with its name of patient 
SELECT CONCAT(phy.f_name, ' ', phy.m_name, ' ', phy.l_name) AS physician_name,
       CONCAT(pat.f_name, ' ', pat.m_name, ' ', pat.l_name) AS patient_name
FROM monitors m JOIN person phy ON m.physician_id = phy.id JOIN person pat ON m.patient_id = pat.id;

-- -- printing all the bill with patient name
SELECT CONCAT(p.f_name, ' ', p.m_name, ' ', p.l_name) AS patient_name,b.bill_id,b.instructions_fee,(b.instructions_fee + 
(SELECT SUM(i.fee) FROM executes e JOIN instructions i ON e.inst_code = i.code WHERE e.patient_id = p.id)) AS total_amount,
pi.date FROM pays_invoice pi JOIN person p ON pi.patient_id = p.id JOIN bill b ON pi.bill_id = b.bill_id;


-- -- printing the pharmacy the patient will get the medicine from including the description of instruction
SELECT CONCAT(p.f_name, ' ', p.m_name, ' ', p.l_name) AS patient_name,i.description AS instruction_description,ms.pharmacy FROM patient pat
JOIN person p ON pat.patient_id = p.id JOIN pays_invoice b ON pat.patient_id = b.patient_id JOIN instructions i ON b.bill_id = i.code
JOIN room r ON b.room_id = r.room_id JOIN med_supply ms ON pat.patient_id = ms.patient_id;


-- -- printing all patient's health records
SELECT CONCAT(p.f_name, ' ', p.m_name, ' ', p.l_name) AS patient_name,hr.disease,hr.date,hr.status,hr.description
FROM health_records hr JOIN has_records hrp ON hr.records_id = hrp.records_id JOIN person p ON hrp.patient_id = p.id;


-- -- Aggregation QUERIES START HERE-- 

-- -- Finding the biggest room
SELECT MAX(capacity) AS max_room_capacity FROM room;

-- -- finding Total number of patients
SELECT COUNT(*) AS total_patients FROM patient;

-- -- finding the patient with highest bill
SELECT CONCAT(p.f_name, ' ', p.m_name, ' ', p.l_name) AS patient_name,MAX(b.instructions_fee) AS highest_bill FROM pays_invoice pi JOIN person p ON pi.patient_id = p.id
JOIN bill b ON pi.bill_id = b.bill_id GROUP BY p.id, p.f_name, p.m_name, p.l_name ORDER BY highest_bill DESC LIMIT 1;

-- -- printing how many orders for a patient
SELECT CONCAT(p.f_name, ' ', p.m_name, ' ', p.l_name) AS patient_name,COUNT(o.patient_id) AS num_orders
FROM patient pat JOIN person p ON pat.patient_id = p.id JOIN orders o ON pat.patient_id = o.patient_id 
GROUP BY patient_name;

-- -- Printing the count of executed instructions by each nurse for each patient
SELECT CONCAT(n.f_name, ' ', n.m_name, ' ', n.l_name) AS nurse_name,
CONCAT(p.f_name, ' ', p.m_name, ' ', p.l_name) AS patient_name,COUNT(*) AS num_of_executed_instructions FROM executes e
JOIN person n ON e.nurse_id = n.id JOIN person p ON e.patient_id = p.id GROUP BY n.f_name, n.m_name, n.l_name, p.f_name, p.m_name, p.l_name;


-- -- Nested QUERIES START HERE-- 

-- --  Printing all physician name , nurse name and patient name  
SELECT DISTINCT (SELECT CONCAT(f_name, ' ', m_name, ' ', l_name) FROM person WHERE id = monitors.physician_id) AS physician_name,
(SELECT CONCAT(f_name, ' ', m_name, ' ', l_name) FROM person WHERE id = executes.nurse_id) AS nurse_name,
(SELECT CONCAT(f_name, ' ', m_name, ' ', l_name) FROM person WHERE id = executes.patient_id) AS patient_name
FROM monitors JOIN executes ON monitors.patient_id = executes.patient_id;

-- -- Finding physician expertise and printing with its name 
SELECT (SELECT CONCAT(f_name, ' ', m_name, ' ', l_name) FROM person WHERE id = physician.id) AS physician_name,
expertise_field FROM physician;

-- -- Printing which physician prescribed the instructions for which patient
SELECT (SELECT CONCAT(f_name, ' ', m_name, ' ', l_name) FROM person WHERE id = o.physician_id) AS physician_name,
(SELECT CONCAT(f_name, ' ', m_name, ' ', l_name) FROM person WHERE id = o.patient_id) AS patient_name,
(SELECT description FROM instructions WHERE code = o.inst_code) AS instruction_description
FROM orders o;


-- -- Printing which room assigned to which patient with its room capacity
SELECT (SELECT CONCAT(f_name, ' ', m_name, ' ', l_name) FROM person WHERE id = p.patient_id) AS patient_name,
(SELECT room_id FROM room WHERE room_id IN (SELECT room_id FROM patient WHERE patient_id = p.patient_id)) AS assigned_room_id,
(SELECT capacity FROM room WHERE room_id IN (SELECT room_id FROM patient WHERE patient_id = p.patient_id)) AS capacity,
(SELECT fee FROM room WHERE room_id IN (SELECT room_id FROM patient WHERE patient_id = p.patient_id)) AS room_fee FROM patient p;


-- -- printing phone of physician and nurse
SELECT CONCAT(f_name, ' ', m_name, ' ', l_name) AS name,phone_number FROM person WHERE id IN (SELECT id FROM nurse) OR id IN (SELECT id FROM physician);

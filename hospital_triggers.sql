USE hospital;
DROP TRIGGER IF EXISTS insert_nurse;
DROP TRIGGER IF EXISTS insert_physician;
DROP TRIGGER IF EXISTS insert_patient;
DROP TRIGGER IF EXISTS update_bill_and_invoice;

DELIMITER //
CREATE TRIGGER insert_nurse
AFTER INSERT ON person
FOR EACH ROW
BEGIN
    DECLARE certification_num INT;
    SET certification_num = NEW.certification_num % 2;

    IF certification_num = 1 THEN
        INSERT INTO nurse (id) VALUES (NEW.id);
    END IF;
END;
//
DELIMITER ;

INSERT INTO person (f_name, m_name, l_name, address, phone_number, certification_num)VALUES
('Amanda', 'C', 'Lewis', '838 Brookfield', '81558256', '233');

DELIMITER //
CREATE TRIGGER insert_physician
AFTER INSERT ON person
FOR EACH ROW
BEGIN
    DECLARE certification_num INT;
    SET certification_num = NEW.certification_num % 2;

    IF certification_num = 0 THEN
        INSERT INTO physician (id, expertise_field) VALUES (NEW.id, 'General Physician');
    END IF;
END;
//
DELIMITER ;

INSERT INTO person (f_name, m_name, l_name, address, phone_number, certification_num)VALUES
('Leonard', 'D', 'Smith', '111 Joliet', '6307304', '232');

SELECT * FROM full_physician_info;

DELIMITER //
CREATE TRIGGER insert_patient
AFTER INSERT ON person
FOR EACH ROW
BEGIN
    IF NEW.certification_num IS NULL THEN
        INSERT INTO patient (patient_id) VALUES (NEW.id);
    END IF;
END;
//
DELIMITER ;

INSERT INTO person (f_name, m_name, l_name, address, phone_number, certification_num)VALUES
('John', 'A', 'West', '111 Peoria', '75066698', NULL);

DELIMITER //
CREATE TRIGGER update_invoice
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    DECLARE instr_fee INT;
    DECLARE b_id INT;

    SELECT fee INTO instr_fee
    FROM instructions
    WHERE code = NEW.inst_code;
	
    UPDATE pays_invoice
    SET instructions_fee = instructions_fee + instr_fee,
        total_amount = total_amount + instr_fee
    WHERE patient_id = NEW.patient_id;

	SELECT bill_id INTO b_id
    FROM pays_invoice
	WHERE patient_id = NEW.patient_id;
    
    UPDATE bill
    SET instructions_fee = instructions_fee + instr_fee
    WHERE b_id = bill_id;
END;
//
DELIMITER ;

INSERT INTO orders (physician_id, patient_id, inst_code)VALUES (5, 3, 1);

SELECT * FROM patient_payment;
DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital;
USE hospital;

CREATE TABLE person (
	id INT AUTO_INCREMENT PRIMARY KEY,
	f_name VARCHAR(10) NOT NULL,
	m_name VARCHAR(10) NOT NULL,
	l_name VARCHAR(10) NOT NULL,
	address VARCHAR(50) NOT NULL,
	phone_number VARCHAR(12) NOT NULL,
    certification_num VARCHAR(10)
);

CREATE TABLE nurse (
	id INT PRIMARY KEY,
    FOREIGN KEY(id) REFERENCES person(id)
);

CREATE TABLE physician (
	id INT PRIMARY KEY,
    expertise_field VARCHAR(100),
    FOREIGN KEY(id) REFERENCES person(id)
);

CREATE TABLE monitors (
    physician_id INT NOT NULL,
    patient_id INT NOT NULL,
    duration INT,
    PRIMARY KEY (physician_id, patient_id),
    FOREIGN KEY (physician_id) REFERENCES person(id),
    FOREIGN KEY (patient_id) REFERENCES person(id)
);


CREATE TABLE room (
	room_id INT AUTO_INCREMENT PRIMARY KEY,
    capacity INT,
    fee VARCHAR(7) NOT NULL
);

CREATE TABLE health_records (
	records_id INT AUTO_INCREMENT PRIMARY KEY,
    disease VARCHAR(20),
    date DATE,
    status VARCHAR(20) NOT NULL,
    description VARCHAR(100)
);

CREATE TABLE has_records (
	records_id INT NOT NULL,
    patient_id INT NOT NULL,
    PRIMARY KEY(records_id, patient_id),
    FOREIGN KEY(patient_id) REFERENCES person(id),
    FOREIGN KEY(records_id) REFERENCES health_records(records_id)
);

CREATE TABLE instructions (
	code INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(100),
    fee VARCHAR(7) NOT NULL
);

CREATE TABLE orders (
	physician_id INT NOT NULL,
    patient_id INT NOT NULL,
    inst_code INT NOT NULL,
    PRIMARY KEY(physician_id, patient_id, inst_code),
    FOREIGN KEY(physician_id) REFERENCES person(id),
    FOREIGN KEY(patient_id) REFERENCES person(id),
    FOREIGN KEY(inst_code) REFERENCES instructions(code)
);


CREATE TABLE executes (
	nurse_id INT,
    patient_id INT,
    inst_code INT NOT NULL,
    PRIMARY KEY(nurse_id, patient_id, inst_code),
    FOREIGN KEY(nurse_id) REFERENCES person(id),
    FOREIGN KEY(patient_id) REFERENCES person(id),
    FOREIGN KEY(inst_code) REFERENCES instructions(code)
);

CREATE TABLE med_supply (
	medication_id INT NOT NULL,
	nurse_id INT NOT NULL,
    patient_id INT NOT NULL,
    amount INT NOT NULL,
    cost VARCHAR(7) NOT NULL,
    pharmacy VARCHAR(20) NOT NULL,
	PRIMARY KEY(nurse_id, patient_id),
    FOREIGN KEY(nurse_id) REFERENCES person(id),
    FOREIGN KEY(patient_id) REFERENCES person(id)
);

CREATE TABLE patient (
	patient_id INT PRIMARY KEY,
    room_id INT,
    nights_hospitalized INT,
    FOREIGN KEY(patient_id) REFERENCES person(id),
    FOREIGN KEY(room_id) REFERENCES room(room_id)
);

CREATE TABLE bill (
	bill_id INT AUTO_INCREMENT PRIMARY KEY,
    instructions_fee VARCHAR(7) NOT NULL
);

CREATE TABLE pays_invoice(
	patient_id INT,
    bill_id INT,
    room_id INT,
    nights_hospitalized INT,
    instructions_fee VARCHAR(7) NOT NULL,
    total_amount INT,
    date DATE,
    PRIMARY KEY(patient_id, bill_id),
    FOREIGN KEY(patient_id) REFERENCES person(id),
    FOREIGN KEY(bill_id) REFERENCES bill(bill_id),
    FOREIGN KEY(room_id) REFERENCES room(room_id)
);
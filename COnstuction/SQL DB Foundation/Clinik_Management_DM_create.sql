-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:02:26.55

-- tables
-- Table: appointment
CREATE TABLE appointment (
    id int NOT NULL AUTO_INCREMENT,
    patient_case_id int NOT NULL,
    in_department_id int NOT NULL,
    time_created timestamp NOT NULL,
    appointment_start_time timestamp NOT NULL,
    appointment_end_time timestamp NULL,
    appointment_status_id int NOT NULL,
    UNIQUE INDEX appointment_ak_1 (patient_case_id,appointment_start_time),
    UNIQUE INDEX appointment_ak_2 (appointment_start_time),
    CONSTRAINT appointment_pk PRIMARY KEY (id)
);

-- Table: appointment_status
CREATE TABLE appointment_status (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(64) NOT NULL,
    UNIQUE INDEX appointment_status_ak_1 (status_name),
    CONSTRAINT appointment_status_pk PRIMARY KEY (id)
) COMMENT 'e.g. scheduled, canceled, postponed, held';

-- Table: clinic
CREATE TABLE clinic (
    id int NOT NULL AUTO_INCREMENT,
    clinic_name varchar(255) NOT NULL,
    address varchar(255) NOT NULL,
    details text NULL,
    UNIQUE INDEX clinic_ak_1 (clinic_name),
    CONSTRAINT clinic_pk PRIMARY KEY (id)
);

-- Table: department
CREATE TABLE department (
    id int NOT NULL AUTO_INCREMENT,
    department_name varchar(255) NOT NULL,
    clinic_id int NOT NULL,
    UNIQUE INDEX department_ak_1 (department_name,clinic_id),
    CONSTRAINT department_pk PRIMARY KEY (id)
);

-- Table: document
CREATE TABLE document (
    id int NOT NULL AUTO_INCREMENT,
    document_internal_id varchar(64) NOT NULL,
    document_name varchar(255) NOT NULL,
    document_type_id int NOT NULL,
    time_created timestamp NOT NULL,
    document_url text NOT NULL,
    details text NULL,
    patient_id int NULL,
    patient_case_id int NULL,
    appointment_id int NULL,
    in_department_Id int NULL,
    UNIQUE INDEX document_ak_1 (document_internal_id),
    CONSTRAINT document_pk PRIMARY KEY (id)
);

-- Table: document_type
CREATE TABLE document_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(64) NOT NULL,
    UNIQUE INDEX document_type_ak_1 (type_name),
    CONSTRAINT document_type_pk PRIMARY KEY (id)
);

-- Table: employee
CREATE TABLE employee (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    user_name varchar(64) NOT NULL,
    password varchar(64) NOT NULL,
    email varchar(255) NULL,
    mobile varchar(255) NULL,
    phone varchar(255) NULL,
    is_active bool NOT NULL,
    UNIQUE INDEX employee_ak_1 (user_name),
    CONSTRAINT employee_pk PRIMARY KEY (id)
);

-- Table: has_role
CREATE TABLE has_role (
    id int NOT NULL AUTO_INCREMENT,
    employee_id int NOT NULL,
    role_id int NOT NULL,
    time_from timestamp NOT NULL,
    time_to timestamp NULL,
    is_active bool NOT NULL,
    UNIQUE INDEX has_role_ak_1 (employee_id,role_id,time_from),
    CONSTRAINT has_role_pk PRIMARY KEY (id)
);

-- Table: in_department
CREATE TABLE in_department (
    id int NOT NULL AUTO_INCREMENT,
    employee_id int NOT NULL,
    department_id int NOT NULL,
    time_from timestamp NOT NULL,
    time_to timestamp NULL,
    is_active bool NOT NULL,
    UNIQUE INDEX in_department_ak_1 (employee_id,department_id,time_from),
    CONSTRAINT in_department_pk PRIMARY KEY (id)
);

-- Table: patient
CREATE TABLE patient (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    CONSTRAINT patient_pk PRIMARY KEY (id)
);

-- Table: patient_case
CREATE TABLE patient_case (
    id int NOT NULL AUTO_INCREMENT,
    patient_id int NOT NULL,
    start_time timestamp NOT NULL,
    end_time timestamp NULL,
    in_progress bool NOT NULL,
    total_cost decimal(10,2) NULL,
    amount_paid decimal(10,2) NULL,
    CONSTRAINT patient_case_pk PRIMARY KEY (id)
);

-- Table: role
CREATE TABLE role (
    id int NOT NULL AUTO_INCREMENT,
    role_name varchar(64) NOT NULL,
    UNIQUE INDEX role_ak_1 (role_name),
    CONSTRAINT role_pk PRIMARY KEY (id)
);

-- Table: schedule
CREATE TABLE schedule (
    id int NOT NULL AUTO_INCREMENT,
    in_department_id int NOT NULL,
    date date NOT NULL,
    time_start timestamp NOT NULL,
    time_end timestamp NOT NULL,
    UNIQUE INDEX schedule_ak_1 (in_department_id,date,time_start),
    CONSTRAINT schedule_pk PRIMARY KEY (id)
);

-- Table: status_history
CREATE TABLE status_history (
    id int NOT NULL AUTO_INCREMENT,
    appointment_id int NOT NULL,
    appointment_status_id int NOT NULL,
    status_time timestamp NOT NULL,
    details text NOT NULL,
    CONSTRAINT status_history_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: appointment_appointment_status (table: appointment)
ALTER TABLE appointment ADD CONSTRAINT appointment_appointment_status FOREIGN KEY appointment_appointment_status (appointment_status_id)
    REFERENCES appointment_status (id);

-- Reference: appointment_in_department (table: appointment)
ALTER TABLE appointment ADD CONSTRAINT appointment_in_department FOREIGN KEY appointment_in_department (in_department_id)
    REFERENCES in_department (id);

-- Reference: appointment_patient_case (table: appointment)
ALTER TABLE appointment ADD CONSTRAINT appointment_patient_case FOREIGN KEY appointment_patient_case (patient_case_id)
    REFERENCES patient_case (id);

-- Reference: department_hospital (table: department)
ALTER TABLE department ADD CONSTRAINT department_hospital FOREIGN KEY department_hospital (clinic_id)
    REFERENCES clinic (id);

-- Reference: document_appointment (table: document)
ALTER TABLE document ADD CONSTRAINT document_appointment FOREIGN KEY document_appointment (appointment_id)
    REFERENCES appointment (id);

-- Reference: document_document_type (table: document)
ALTER TABLE document ADD CONSTRAINT document_document_type FOREIGN KEY document_document_type (document_type_id)
    REFERENCES document_type (id);

-- Reference: document_in_department (table: document)
ALTER TABLE document ADD CONSTRAINT document_in_department FOREIGN KEY document_in_department (in_department_Id)
    REFERENCES in_department (id);

-- Reference: document_patient (table: document)
ALTER TABLE document ADD CONSTRAINT document_patient FOREIGN KEY document_patient (patient_id)
    REFERENCES patient (id);

-- Reference: document_patient_case (table: document)
ALTER TABLE document ADD CONSTRAINT document_patient_case FOREIGN KEY document_patient_case (patient_case_id)
    REFERENCES patient_case (id);

-- Reference: has_role_employee (table: has_role)
ALTER TABLE has_role ADD CONSTRAINT has_role_employee FOREIGN KEY has_role_employee (employee_id)
    REFERENCES employee (id);

-- Reference: has_role_role (table: has_role)
ALTER TABLE has_role ADD CONSTRAINT has_role_role FOREIGN KEY has_role_role (role_id)
    REFERENCES role (id);

-- Reference: in_department_department (table: in_department)
ALTER TABLE in_department ADD CONSTRAINT in_department_department FOREIGN KEY in_department_department (department_id)
    REFERENCES department (id);

-- Reference: in_department_employee (table: in_department)
ALTER TABLE in_department ADD CONSTRAINT in_department_employee FOREIGN KEY in_department_employee (employee_id)
    REFERENCES employee (id);

-- Reference: patient_case_patient (table: patient_case)
ALTER TABLE patient_case ADD CONSTRAINT patient_case_patient FOREIGN KEY patient_case_patient (patient_id)
    REFERENCES patient (id);

-- Reference: schedule_in_department (table: schedule)
ALTER TABLE schedule ADD CONSTRAINT schedule_in_department FOREIGN KEY schedule_in_department (in_department_id)
    REFERENCES in_department (id);

-- Reference: status_history_appointment (table: status_history)
ALTER TABLE status_history ADD CONSTRAINT status_history_appointment FOREIGN KEY status_history_appointment (appointment_id)
    REFERENCES appointment (id);

-- Reference: status_history_appointment_status (table: status_history)
ALTER TABLE status_history ADD CONSTRAINT status_history_appointment_status FOREIGN KEY status_history_appointment_status (appointment_status_id)
    REFERENCES appointment_status (id);

-- End of file.


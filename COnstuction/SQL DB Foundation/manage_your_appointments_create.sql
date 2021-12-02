-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:16:37.247

-- tables
-- Table: appointment
CREATE TABLE appointment (
    id int NOT NULL AUTO_INCREMENT,
    date_created timestamp NOT NULL,
    employee_created int NOT NULL,
    client_id int NULL,
    employee_id int NULL,
    client_name varchar(128) NOT NULL,
    client_contact varchar(128) NOT NULL,
    start_time timestamp NOT NULL,
    end_time_expected timestamp NOT NULL,
    end_time timestamp NULL,
    price_expected decimal(10,2) NOT NULL,
    price_full decimal(10,2) NULL,
    discount decimal(10,2) NULL,
    price_final decimal(10,2) NULL,
    canceled bool NOT NULL,
    cancellation_reson text NULL,
    CONSTRAINT appointment_pk PRIMARY KEY (id)
);

-- Table: client
CREATE TABLE client (
    id int NOT NULL AUTO_INCREMENT,
    client_name varchar(128) NOT NULL,
    contact_mobile varchar(128) NULL,
    contact_mail varchar(128) NULL,
    CONSTRAINT client_pk PRIMARY KEY (id)
);

-- Table: employee
CREATE TABLE employee (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    CONSTRAINT employee_pk PRIMARY KEY (id)
);

-- Table: schedule
CREATE TABLE schedule (
    id int NOT NULL AUTO_INCREMENT,
    employee_id int NOT NULL,
    `from` timestamp NOT NULL,
    `to` timestamp NOT NULL,
    CONSTRAINT schedule_pk PRIMARY KEY (id)
);

-- Table: service
CREATE TABLE service (
    id int NOT NULL AUTO_INCREMENT,
    service_name varchar(128) NOT NULL,
    duration int NOT NULL,
    price decimal(10,2) NOT NULL,
    UNIQUE INDEX services_ak_1 (service_name),
    CONSTRAINT service_pk PRIMARY KEY (id)
);

-- Table: service_booked
CREATE TABLE service_booked (
    id int NOT NULL AUTO_INCREMENT,
    appointment_id int NOT NULL,
    service_id int NOT NULL,
    price decimal(10,2) NOT NULL,
    CONSTRAINT service_booked_pk PRIMARY KEY (id)
);

-- Table: service_provided
CREATE TABLE service_provided (
    id int NOT NULL AUTO_INCREMENT,
    appointment_id int NOT NULL,
    service_id int NOT NULL,
    price decimal(10,2) NOT NULL,
    CONSTRAINT service_provided_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: appointment_client (table: appointment)
ALTER TABLE appointment ADD CONSTRAINT appointment_client FOREIGN KEY appointment_client (client_id)
    REFERENCES client (id);

-- Reference: appointment_hairdresser1 (table: appointment)
ALTER TABLE appointment ADD CONSTRAINT appointment_hairdresser1 FOREIGN KEY appointment_hairdresser1 (employee_id)
    REFERENCES employee (id);

-- Reference: appointment_hairdresser2 (table: appointment)
ALTER TABLE appointment ADD CONSTRAINT appointment_hairdresser2 FOREIGN KEY appointment_hairdresser2 (employee_created)
    REFERENCES employee (id);

-- Reference: schedule_hairdresser (table: schedule)
ALTER TABLE schedule ADD CONSTRAINT schedule_hairdresser FOREIGN KEY schedule_hairdresser (employee_id)
    REFERENCES employee (id);

-- Reference: service_booked_appointment (table: service_booked)
ALTER TABLE service_booked ADD CONSTRAINT service_booked_appointment FOREIGN KEY service_booked_appointment (appointment_id)
    REFERENCES appointment (id);

-- Reference: service_booked_service (table: service_booked)
ALTER TABLE service_booked ADD CONSTRAINT service_booked_service FOREIGN KEY service_booked_service (service_id)
    REFERENCES service (id);

-- Reference: service_provided_appointment (table: service_provided)
ALTER TABLE service_provided ADD CONSTRAINT service_provided_appointment FOREIGN KEY service_provided_appointment (appointment_id)
    REFERENCES appointment (id);

-- Reference: service_provided_service (table: service_provided)
ALTER TABLE service_provided ADD CONSTRAINT service_provided_service FOREIGN KEY service_provided_service (service_id)
    REFERENCES service (id);

-- End of file.


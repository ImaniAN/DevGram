-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:18:00.749

-- tables
-- Table: cab
CREATE TABLE cab (
    id int NOT NULL AUTO_INCREMENT,
    license_plate varchar(32) NOT NULL,
    car_model_id int NOT NULL,
    manufacture_year int NOT NULL,
    owner_id int NULL,
    active bool NOT NULL DEFAULT 1 COMMENT 'default -> Yes',
    UNIQUE INDEX cab_ak_1 (license_plate),
    CONSTRAINT cab_pk PRIMARY KEY (id)
);

-- Table: cab_ride
CREATE TABLE cab_ride (
    id int NOT NULL AUTO_INCREMENT,
    shift_id int NULL,
    ride_start_time timestamp NULL,
    ride_end_time timestamp NULL,
    address_starting_point text NULL,
    GPS_starting_point text NULL,
    address_destination text NULL,
    GPS_destination text NULL,
    canceled bool NOT NULL DEFAULT 0 COMMENT 'default -> No',
    payment_type_id int NULL,
    price decimal(10,2) NULL,
    CONSTRAINT cab_ride_pk PRIMARY KEY (id)
);

-- Table: cab_ride_status
CREATE TABLE cab_ride_status (
    id int NOT NULL AUTO_INCREMENT,
    cab_ride_id int NOT NULL,
    status_id int NOT NULL,
    status_time timestamp NOT NULL,
    cc_agent_id int NULL,
    shift_id int NULL,
    status_details text NULL,
    CONSTRAINT cab_ride_status_pk PRIMARY KEY (id)
);

-- Table: car_model
CREATE TABLE car_model (
    id int NOT NULL AUTO_INCREMENT,
    model_name varchar(64) NOT NULL,
    model_descritpion text NOT NULL,
    UNIQUE INDEX car_model_ak_1 (model_name),
    CONSTRAINT car_model_pk PRIMARY KEY (id)
);

-- Table: cc_agent
CREATE TABLE cc_agent (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(128) NOT NULL,
    last_name varchar(128) NOT NULL,
    CONSTRAINT cc_agent_pk PRIMARY KEY (id)
);

-- Table: driver
CREATE TABLE driver (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(128) NOT NULL,
    last_name varchar(128) NOT NULL,
    birth_date date NOT NULL,
    driving_licence_number varchar(128) NOT NULL,
    expiry_date date NOT NULL,
    working bool NOT NULL DEFAULT 1 COMMENT 'default -> Yes',
    UNIQUE INDEX driver_ak_1 (driving_licence_number),
    CONSTRAINT driver_pk PRIMARY KEY (id)
);

-- Table: payment_type
CREATE TABLE payment_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(128) NOT NULL,
    UNIQUE INDEX payment_type_ak_1 (type_name),
    CONSTRAINT payment_type_pk PRIMARY KEY (id)
);

-- Table: shift
CREATE TABLE shift (
    id int NOT NULL AUTO_INCREMENT,
    driver_id int NOT NULL,
    cab_id int NOT NULL,
    shift_start_time timestamp NULL,
    shift_end_time timestamp NULL,
    login_time timestamp NULL,
    logout_time timestamp NULL,
    CONSTRAINT shift_pk PRIMARY KEY (id)
);

-- Table: status
CREATE TABLE status (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(128) NOT NULL,
    UNIQUE INDEX status_ak_1 (status_name),
    CONSTRAINT status_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: cab_car_model (table: cab)
ALTER TABLE cab ADD CONSTRAINT cab_car_model FOREIGN KEY cab_car_model (car_model_id)
    REFERENCES car_model (id);

-- Reference: cab_driver (table: cab)
ALTER TABLE cab ADD CONSTRAINT cab_driver FOREIGN KEY cab_driver (owner_id)
    REFERENCES driver (id);

-- Reference: cab_ride_payment_type (table: cab_ride)
ALTER TABLE cab_ride ADD CONSTRAINT cab_ride_payment_type FOREIGN KEY cab_ride_payment_type (payment_type_id)
    REFERENCES payment_type (id);

-- Reference: cab_ride_shift (table: cab_ride)
ALTER TABLE cab_ride ADD CONSTRAINT cab_ride_shift FOREIGN KEY cab_ride_shift (shift_id)
    REFERENCES shift (id);

-- Reference: cab_ride_status_cab_ride (table: cab_ride_status)
ALTER TABLE cab_ride_status ADD CONSTRAINT cab_ride_status_cab_ride FOREIGN KEY cab_ride_status_cab_ride (cab_ride_id)
    REFERENCES cab_ride (id);

-- Reference: cab_ride_status_cc_agent (table: cab_ride_status)
ALTER TABLE cab_ride_status ADD CONSTRAINT cab_ride_status_cc_agent FOREIGN KEY cab_ride_status_cc_agent (cc_agent_id)
    REFERENCES cc_agent (id);

-- Reference: cab_ride_status_shift (table: cab_ride_status)
ALTER TABLE cab_ride_status ADD CONSTRAINT cab_ride_status_shift FOREIGN KEY cab_ride_status_shift (shift_id)
    REFERENCES shift (id);

-- Reference: cab_ride_status_status (table: cab_ride_status)
ALTER TABLE cab_ride_status ADD CONSTRAINT cab_ride_status_status FOREIGN KEY cab_ride_status_status (status_id)
    REFERENCES status (id);

-- Reference: drives_cab (table: shift)
ALTER TABLE shift ADD CONSTRAINT drives_cab FOREIGN KEY drives_cab (cab_id)
    REFERENCES cab (id);

-- Reference: drives_driver (table: shift)
ALTER TABLE shift ADD CONSTRAINT drives_driver FOREIGN KEY drives_driver (driver_id)
    REFERENCES driver (id);

-- End of file.


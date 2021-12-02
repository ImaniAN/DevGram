-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:55:55.083

-- tables
-- Table: city
CREATE TABLE city (
    id int NOT NULL,
    postal_code varchar(16) NOT NULL,
    city_name varchar(128) NOT NULL,
    UNIQUE INDEX city_ak_1 (postal_code,city_name),
    CONSTRAINT city_pk PRIMARY KEY (id)
);

-- Table: contact
CREATE TABLE contact (
    id int NOT NULL AUTO_INCREMENT,
    contact_type_id int NOT NULL,
    customer_id int NULL,
    schedule_id int NOT NULL,
    contact_details text NULL,
    insert_ts timestamp NOT NULL,
    CONSTRAINT contact_pk PRIMARY KEY (id)
) COMMENT 'call, email, ...';

-- Table: contact_type
CREATE TABLE contact_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(64) NOT NULL,
    UNIQUE INDEX contact_type_ak_1 (type_name),
    CONSTRAINT contact_type_pk PRIMARY KEY (id)
);

-- Table: customer
CREATE TABLE customer (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(128) NULL,
    last_name varchar(128) NULL,
    company_name varchar(255) NULL,
    address varchar(255) NULL,
    mobile varchar(64) NULL,
    email varchar(128) NULL,
    details text NULL,
    insert_ts timestamp NOT NULL,
    CONSTRAINT customer_pk PRIMARY KEY (id)
);

-- Table: employee
CREATE TABLE employee (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(128) NOT NULL,
    last_name varchar(128) NOT NULL,
    employment_start_date date NOT NULL,
    employment_end_date date NULL,
    position_id int NOT NULL,
    city_id int NOT NULL,
    is_active bool NOT NULL,
    CONSTRAINT employee_pk PRIMARY KEY (id)
);

-- Table: make
CREATE TABLE make (
    id int NOT NULL,
    make_name varchar(128) NOT NULL,
    UNIQUE INDEX make_ak_1 (make_name),
    CONSTRAINT make_pk PRIMARY KEY (id)
);

-- Table: model
CREATE TABLE model (
    id int NOT NULL AUTO_INCREMENT,
    model_name varchar(128) NOT NULL,
    make_id int NOT NULL,
    vehicle_type_id int NOT NULL,
    UNIQUE INDEX model_ak_1 (model_name,make_id,vehicle_type_id),
    CONSTRAINT model_pk PRIMARY KEY (id)
);

-- Table: offer
CREATE TABLE offer (
    id int NOT NULL AUTO_INCREMENT,
    customer_id int NOT NULL,
    contact_id int NULL,
    offer_description text NULL,
    service_catalog_id int NULL,
    service_discount decimal(5,2) NULL,
    offer_price decimal(8,2) NOT NULL,
    insert_ts timestamp NOT NULL,
    CONSTRAINT offer_pk PRIMARY KEY (id)
);

-- Table: offer_task
CREATE TABLE offer_task (
    id int NOT NULL AUTO_INCREMENT,
    offer_id int NOT NULL,
    task_catalog_id int NOT NULL,
    task_price decimal(8,2) NOT NULL,
    insert_ts timestamp NOT NULL,
    UNIQUE INDEX offer_task_ak_1 (offer_id,task_catalog_id),
    CONSTRAINT offer_task_pk PRIMARY KEY (id)
) COMMENT 'list of all tasks included in offer';

-- Table: position
CREATE TABLE position (
    id int NOT NULL AUTO_INCREMENT,
    position_name varchar(128) NOT NULL,
    UNIQUE INDEX position_ak_1 (position_name),
    CONSTRAINT position_pk PRIMARY KEY (id)
);

-- Table: repair_shop
CREATE TABLE repair_shop (
    id int NOT NULL AUTO_INCREMENT,
    shop_name varchar(128) NOT NULL,
    address varchar(255) NOT NULL,
    details text NULL,
    city_id int NOT NULL,
    UNIQUE INDEX repair_shop_ak_1 (shop_name,city_id),
    CONSTRAINT repair_shop_pk PRIMARY KEY (id)
);

-- Table: schedule
CREATE TABLE schedule (
    id int NOT NULL,
    repair_shop_id int NOT NULL,
    employee_id int NOT NULL,
    position_id int NOT NULL,
    schedule_date date NOT NULL,
    time_from time NOT NULL,
    time_to time NOT NULL,
    plan bool NOT NULL,
    actual bool NOT NULL,
    insert_ts timestamp NOT NULL,
    UNIQUE INDEX schedule_ak_1 (repair_shop_id,employee_id,schedule_date,time_from),
    CONSTRAINT schedule_pk PRIMARY KEY (id)
);

-- Table: service_catalog
CREATE TABLE service_catalog (
    id int NOT NULL AUTO_INCREMENT,
    service_name varchar(255) NOT NULL,
    description text NULL,
    service_discount decimal(5,2) NOT NULL COMMENT 'discount percentage',
    is_active bool NOT NULL,
    UNIQUE INDEX service_catalog_ak_1 (service_name),
    CONSTRAINT service_catalog_pk PRIMARY KEY (id)
);

-- Table: task_catalog
CREATE TABLE task_catalog (
    id int NOT NULL AUTO_INCREMENT,
    task_name varchar(255) NOT NULL,
    service_catalog_id int NOT NULL,
    description text NULL,
    ref_interval bool NOT NULL COMMENT 'if we should measure a value',
    ref_interval_min decimal(10,4) NULL,
    ref_interval_max decimal(10,4) NULL,
    `describe` bool NOT NULL COMMENT 'if we should describe the outcome',
    task_price decimal(8,2) NOT NULL,
    is_active bool NOT NULL,
    UNIQUE INDEX task_catalog_ak_1 (task_name,service_catalog_id),
    CONSTRAINT task_catalog_pk PRIMARY KEY (id)
);

-- Table: vehicle
CREATE TABLE vehicle (
    id int NOT NULL AUTO_INCREMENT,
    vin varchar(255) NOT NULL,
    license_plate varchar(64) NOT NULL,
    customer_id int NOT NULL,
    model_id int NOT NULL,
    manufactured_year int NOT NULL,
    manufactured_month int NOT NULL,
    details text NULL,
    insert_ts timestamp NOT NULL,
    UNIQUE INDEX vehicle_ak_1 (vin),
    CONSTRAINT vehicle_pk PRIMARY KEY (id)
);

-- Table: vehicle_type
CREATE TABLE vehicle_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(64) NOT NULL,
    UNIQUE INDEX vehicle_type_ak_1 (type_name),
    CONSTRAINT vehicle_type_pk PRIMARY KEY (id)
);

-- Table: visit
CREATE TABLE visit (
    id int NOT NULL AUTO_INCREMENT,
    repair_shop_id int NOT NULL,
    customer_id int NOT NULL,
    vehicle_id int NOT NULL,
    visit_start_date date NOT NULL,
    visit_start_time time NOT NULL,
    visit_end_date date NULL,
    visit_end_time time NULL,
    license_plate varchar(64) NOT NULL,
    offer_id int NULL,
    service_catalog_id int NULL,
    service_discount decimal(5,2) NULL,
    visit_price decimal(8,2) NOT NULL,
    invoice_created timestamp NULL,
    invoice_due timestamp NULL,
    invoice_charged timestamp NULL,
    insert_ts int NOT NULL,
    CONSTRAINT visit_pk PRIMARY KEY (id)
);

-- Table: visit_task
CREATE TABLE visit_task (
    id int NOT NULL AUTO_INCREMENT,
    visit_id int NOT NULL,
    task_catalog_id int NOT NULL,
    value_measured decimal(10,4) NULL,
    task_description text NULL,
    pass bool NOT NULL COMMENT 'test passed - Yes or No',
    task_price decimal(8,2) NOT NULL,
    insert_ts timestamp NOT NULL,
    CONSTRAINT visit_task_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: car_customer (table: vehicle)
ALTER TABLE vehicle ADD CONSTRAINT car_customer FOREIGN KEY car_customer (customer_id)
    REFERENCES customer (id);

-- Reference: car_model (table: vehicle)
ALTER TABLE vehicle ADD CONSTRAINT car_model FOREIGN KEY car_model (model_id)
    REFERENCES model (id);

-- Reference: contact_contact_type (table: contact)
ALTER TABLE contact ADD CONSTRAINT contact_contact_type FOREIGN KEY contact_contact_type (contact_type_id)
    REFERENCES contact_type (id);

-- Reference: contact_customer (table: contact)
ALTER TABLE contact ADD CONSTRAINT contact_customer FOREIGN KEY contact_customer (customer_id)
    REFERENCES customer (id);

-- Reference: contact_schedule (table: contact)
ALTER TABLE contact ADD CONSTRAINT contact_schedule FOREIGN KEY contact_schedule (schedule_id)
    REFERENCES schedule (id);

-- Reference: employee_city (table: employee)
ALTER TABLE employee ADD CONSTRAINT employee_city FOREIGN KEY employee_city (city_id)
    REFERENCES city (id);

-- Reference: employee_position (table: employee)
ALTER TABLE employee ADD CONSTRAINT employee_position FOREIGN KEY employee_position (position_id)
    REFERENCES position (id);

-- Reference: model_manufacturer (table: model)
ALTER TABLE model ADD CONSTRAINT model_manufacturer FOREIGN KEY model_manufacturer (make_id)
    REFERENCES make (id);

-- Reference: model_vehicle_type (table: model)
ALTER TABLE model ADD CONSTRAINT model_vehicle_type FOREIGN KEY model_vehicle_type (vehicle_type_id)
    REFERENCES vehicle_type (id);

-- Reference: offer_contact (table: offer)
ALTER TABLE offer ADD CONSTRAINT offer_contact FOREIGN KEY offer_contact (contact_id)
    REFERENCES contact (id);

-- Reference: offer_customer (table: offer)
ALTER TABLE offer ADD CONSTRAINT offer_customer FOREIGN KEY offer_customer (customer_id)
    REFERENCES customer (id);

-- Reference: offer_service_catalog (table: offer)
ALTER TABLE offer ADD CONSTRAINT offer_service_catalog FOREIGN KEY offer_service_catalog (service_catalog_id)
    REFERENCES service_catalog (id);

-- Reference: offer_task_offer (table: offer_task)
ALTER TABLE offer_task ADD CONSTRAINT offer_task_offer FOREIGN KEY offer_task_offer (offer_id)
    REFERENCES offer (id);

-- Reference: offer_task_task_catalog (table: offer_task)
ALTER TABLE offer_task ADD CONSTRAINT offer_task_task_catalog FOREIGN KEY offer_task_task_catalog (task_catalog_id)
    REFERENCES task_catalog (id);

-- Reference: repair_shop_city (table: repair_shop)
ALTER TABLE repair_shop ADD CONSTRAINT repair_shop_city FOREIGN KEY repair_shop_city (city_id)
    REFERENCES city (id);

-- Reference: task_catalog_service_catalog (table: task_catalog)
ALTER TABLE task_catalog ADD CONSTRAINT task_catalog_service_catalog FOREIGN KEY task_catalog_service_catalog (service_catalog_id)
    REFERENCES service_catalog (id);

-- Reference: visit_customer (table: visit)
ALTER TABLE visit ADD CONSTRAINT visit_customer FOREIGN KEY visit_customer (customer_id)
    REFERENCES customer (id);

-- Reference: visit_offer (table: visit)
ALTER TABLE visit ADD CONSTRAINT visit_offer FOREIGN KEY visit_offer (offer_id)
    REFERENCES offer (id);

-- Reference: visit_repair_shop (table: visit)
ALTER TABLE visit ADD CONSTRAINT visit_repair_shop FOREIGN KEY visit_repair_shop (repair_shop_id)
    REFERENCES repair_shop (id);

-- Reference: visit_service_catalog (table: visit)
ALTER TABLE visit ADD CONSTRAINT visit_service_catalog FOREIGN KEY visit_service_catalog (service_catalog_id)
    REFERENCES service_catalog (id);

-- Reference: visit_task_task_catalog (table: visit_task)
ALTER TABLE visit_task ADD CONSTRAINT visit_task_task_catalog FOREIGN KEY visit_task_task_catalog (task_catalog_id)
    REFERENCES task_catalog (id);

-- Reference: visit_task_visit (table: visit_task)
ALTER TABLE visit_task ADD CONSTRAINT visit_task_visit FOREIGN KEY visit_task_visit (visit_id)
    REFERENCES visit (id);

-- Reference: visit_vehicle (table: visit)
ALTER TABLE visit ADD CONSTRAINT visit_vehicle FOREIGN KEY visit_vehicle (vehicle_id)
    REFERENCES vehicle (id);

-- Reference: work_employee (table: schedule)
ALTER TABLE schedule ADD CONSTRAINT work_employee FOREIGN KEY work_employee (employee_id)
    REFERENCES employee (id);

-- Reference: work_position (table: schedule)
ALTER TABLE schedule ADD CONSTRAINT work_position FOREIGN KEY work_position (position_id)
    REFERENCES position (id);

-- Reference: work_repair_shop (table: schedule)
ALTER TABLE schedule ADD CONSTRAINT work_repair_shop FOREIGN KEY work_repair_shop (repair_shop_id)
    REFERENCES repair_shop (id);

-- End of file.


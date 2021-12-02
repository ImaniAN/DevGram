-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:56:40.23

-- tables
-- Table: box
CREATE TABLE box (
    id int NOT NULL AUTO_INCREMENT,
    box_code varchar(32) NOT NULL,
    delivery_id int NOT NULL,
    employee_id int NOT NULL,
    UNIQUE INDEX box_ak_1 (box_code),
    CONSTRAINT box_pk PRIMARY KEY (id)
);

-- Table: city
CREATE TABLE city (
    id int NOT NULL AUTO_INCREMENT,
    city_name varchar(128) NOT NULL,
    postal_code varchar(16) NOT NULL,
    UNIQUE INDEX city_ak_1 (city_name,postal_code),
    CONSTRAINT city_pk PRIMARY KEY (id)
);

-- Table: customer
CREATE TABLE customer (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    user_name varchar(64) NOT NULL,
    password varchar(64) NOT NULL,
    time_inserted timestamp NOT NULL,
    confirmation_code varchar(255) NOT NULL,
    time_confirmed timestamp NULL,
    contact_email varchar(128) NOT NULL,
    contact_phone varchar(128) NULL,
    city_id int NULL,
    address varchar(255) NULL,
    delivery_city_id int NULL,
    delivery_address varchar(255) NULL,
    UNIQUE INDEX customer_ak_1 (user_name),
    CONSTRAINT customer_pk PRIMARY KEY (id)
);

-- Table: delivery
CREATE TABLE delivery (
    id int NOT NULL AUTO_INCREMENT,
    delivery_time_planned timestamp NOT NULL,
    delivery_time_actual timestamp NULL,
    notes text NULL,
    placed_order_id int NOT NULL,
    employee_id int NULL,
    CONSTRAINT delivery_pk PRIMARY KEY (id)
) COMMENT 'we could have more than one delivery for placed order';

-- Table: employee
CREATE TABLE employee (
    id int NOT NULL,
    employee_code varchar(32) NOT NULL,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    UNIQUE INDEX employee_ak_1 (employee_code),
    CONSTRAINT employee_pk PRIMARY KEY (id)
);

-- Table: item
CREATE TABLE item (
    id int NOT NULL AUTO_INCREMENT,
    item_name varchar(255) NOT NULL,
    price decimal(10,2) NOT NULL,
    item_photo text NULL,
    description text NULL,
    unit_id int NOT NULL,
    UNIQUE INDEX item_ak_1 (item_name),
    CONSTRAINT item_pk PRIMARY KEY (id)
);

-- Table: item_in_box
CREATE TABLE item_in_box (
    id int NOT NULL AUTO_INCREMENT,
    box_id int NOT NULL,
    item_id int NOT NULL,
    qunatity decimal(10,3) NOT NULL,
    is_replacement bool NOT NULL,
    CONSTRAINT item_in_box_pk PRIMARY KEY (id)
);

-- Table: notes
CREATE TABLE notes (
    id int NOT NULL AUTO_INCREMENT,
    placed_order_id int NOT NULL,
    employee_id int NULL,
    customer_id int NULL,
    note_time timestamp NOT NULL,
    note_text text NOT NULL,
    CONSTRAINT notes_pk PRIMARY KEY (id)
);

-- Table: order_item
CREATE TABLE order_item (
    id int NOT NULL AUTO_INCREMENT,
    placed_order_id int NOT NULL,
    item_id int NOT NULL,
    quantity decimal(10,3) NOT NULL,
    price decimal(10,2) NOT NULL,
    CONSTRAINT order_item_pk PRIMARY KEY (id)
);

-- Table: order_status
CREATE TABLE order_status (
    id int NOT NULL AUTO_INCREMENT,
    placed_order_id int NOT NULL,
    status_catalog_id int NOT NULL,
    status_time timestamp NOT NULL,
    details text NULL,
    CONSTRAINT order_status_pk PRIMARY KEY (id)
);

-- Table: placed_order
CREATE TABLE placed_order (
    id int NOT NULL AUTO_INCREMENT,
    customer_id int NOT NULL,
    time_placed timestamp NOT NULL,
    details text NULL,
    delivery_city_id int NOT NULL,
    delivery_address varchar(255) NOT NULL,
    grade_customer int NULL,
    grade_employee int NULL,
    CONSTRAINT placed_order_pk PRIMARY KEY (id)
);

-- Table: status_catalog
CREATE TABLE status_catalog (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(128) NOT NULL,
    UNIQUE INDEX status_catalog_ak_1 (status_name),
    CONSTRAINT status_catalog_pk PRIMARY KEY (id)
);

-- Table: unit
CREATE TABLE unit (
    id int NOT NULL AUTO_INCREMENT,
    unit_name varchar(64) NOT NULL,
    unit_short varchar(8) NULL,
    UNIQUE INDEX unit_ak_1 (unit_name),
    UNIQUE INDEX unit_ak_2 (unit_short),
    CONSTRAINT unit_pk PRIMARY KEY (id)
) COMMENT 'list of all units we could assign to items';

-- foreign keys
-- Reference: box_delivery (table: box)
ALTER TABLE box ADD CONSTRAINT box_delivery FOREIGN KEY box_delivery (delivery_id)
    REFERENCES delivery (id);

-- Reference: box_employee (table: box)
ALTER TABLE box ADD CONSTRAINT box_employee FOREIGN KEY box_employee (employee_id)
    REFERENCES employee (id);

-- Reference: customer_city_1 (table: customer)
ALTER TABLE customer ADD CONSTRAINT customer_city_1 FOREIGN KEY customer_city_1 (city_id)
    REFERENCES city (id);

-- Reference: customer_city_2 (table: customer)
ALTER TABLE customer ADD CONSTRAINT customer_city_2 FOREIGN KEY customer_city_2 (delivery_city_id)
    REFERENCES city (id);

-- Reference: delivery_employee (table: delivery)
ALTER TABLE delivery ADD CONSTRAINT delivery_employee FOREIGN KEY delivery_employee (employee_id)
    REFERENCES employee (id);

-- Reference: delivery_placed_order (table: delivery)
ALTER TABLE delivery ADD CONSTRAINT delivery_placed_order FOREIGN KEY delivery_placed_order (placed_order_id)
    REFERENCES placed_order (id);

-- Reference: item_in_box_box (table: item_in_box)
ALTER TABLE item_in_box ADD CONSTRAINT item_in_box_box FOREIGN KEY item_in_box_box (box_id)
    REFERENCES box (id);

-- Reference: item_in_box_item (table: item_in_box)
ALTER TABLE item_in_box ADD CONSTRAINT item_in_box_item FOREIGN KEY item_in_box_item (item_id)
    REFERENCES item (id);

-- Reference: item_unit (table: item)
ALTER TABLE item ADD CONSTRAINT item_unit FOREIGN KEY item_unit (unit_id)
    REFERENCES unit (id);

-- Reference: notes_customer (table: notes)
ALTER TABLE notes ADD CONSTRAINT notes_customer FOREIGN KEY notes_customer (customer_id)
    REFERENCES customer (id);

-- Reference: notes_employee (table: notes)
ALTER TABLE notes ADD CONSTRAINT notes_employee FOREIGN KEY notes_employee (employee_id)
    REFERENCES employee (id);

-- Reference: notes_placed_order (table: notes)
ALTER TABLE notes ADD CONSTRAINT notes_placed_order FOREIGN KEY notes_placed_order (placed_order_id)
    REFERENCES placed_order (id);

-- Reference: order_item_item (table: order_item)
ALTER TABLE order_item ADD CONSTRAINT order_item_item FOREIGN KEY order_item_item (item_id)
    REFERENCES item (id);

-- Reference: order_item_placed_order (table: order_item)
ALTER TABLE order_item ADD CONSTRAINT order_item_placed_order FOREIGN KEY order_item_placed_order (placed_order_id)
    REFERENCES placed_order (id);

-- Reference: order_status_placed_order (table: order_status)
ALTER TABLE order_status ADD CONSTRAINT order_status_placed_order FOREIGN KEY order_status_placed_order (placed_order_id)
    REFERENCES placed_order (id);

-- Reference: order_status_status_catalog (table: order_status)
ALTER TABLE order_status ADD CONSTRAINT order_status_status_catalog FOREIGN KEY order_status_status_catalog (status_catalog_id)
    REFERENCES status_catalog (id);

-- Reference: placed_order_city (table: placed_order)
ALTER TABLE placed_order ADD CONSTRAINT placed_order_city FOREIGN KEY placed_order_city (delivery_city_id)
    REFERENCES city (id);

-- Reference: placed_order_customer (table: placed_order)
ALTER TABLE placed_order ADD CONSTRAINT placed_order_customer FOREIGN KEY placed_order_customer (customer_id)
    REFERENCES customer (id);

-- End of file.


-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:53:11.216

-- tables
-- Table: bottle
CREATE TABLE bottle (
    id int NOT NULL AUTO_INCREMENT,
    full_name varchar(255) NOT NULL,
    category_id int NOT NULL,
    label text NULL COMMENT 'complete label text',
    volume decimal(5,2) NOT NULL COMMENT 'volume in liters',
    producer_id int NOT NULL,
    year_produced int NOT NULL,
    picture text NULL,
    alcohol_percentage decimal(5,2) NOT NULL,
    current_price decimal(8,2) NOT NULL,
    UNIQUE INDEX bottle_ak_1 (full_name,producer_id,volume),
    CONSTRAINT bottle_pk PRIMARY KEY (id)
);

-- Table: category
CREATE TABLE category (
    id int NOT NULL AUTO_INCREMENT,
    category_name varchar(255) NOT NULL,
    UNIQUE INDEX category_ak_1 (category_name),
    CONSTRAINT category_pk PRIMARY KEY (id)
);

-- Table: city
CREATE TABLE city (
    id int NOT NULL AUTO_INCREMENT,
    postal_code varchar(16) NOT NULL,
    city_name varchar(255) NOT NULL,
    country_id int NOT NULL,
    UNIQUE INDEX city_ak_1 (postal_code,city_name,country_id),
    CONSTRAINT city_pk PRIMARY KEY (id)
);

-- Table: country
CREATE TABLE country (
    id int NOT NULL AUTO_INCREMENT,
    country_name varchar(255) NOT NULL,
    UNIQUE INDEX country_ak_1 (country_name),
    CONSTRAINT country_pk PRIMARY KEY (id)
);

-- Table: customer
CREATE TABLE customer (
    id int NOT NULL AUTO_INCREMENT,
    username varchar(255) NOT NULL,
    password varchar(255) NOT NULL,
    customer_name varchar(255) NOT NULL,
    address varchar(255) NOT NULL,
    phone varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    details text NULL,
    confirmation_code text NOT NULL,
    confirmation_time timestamp NULL,
    insert_ts timestamp NOT NULL,
    UNIQUE INDEX customer_ak_1 (username),
    UNIQUE INDEX customer_ak_2 (email),
    CONSTRAINT customer_pk PRIMARY KEY (id)
);

-- Table: customer_order
CREATE TABLE customer_order (
    id int NOT NULL AUTO_INCREMENT,
    order_number int NOT NULL,
    customer_id int NOT NULL,
    store_id int NULL,
    expected_delivery_date date NOT NULL,
    time_placed timestamp NOT NULL,
    time_canceled timestamp NULL,
    time_delivered timestamp NULL,
    order_price decimal(8,2) NOT NULL,
    UNIQUE INDEX customer_order_ak_1 (order_number),
    CONSTRAINT customer_order_pk PRIMARY KEY (id)
);

-- Table: customer_order_items
CREATE TABLE customer_order_items (
    id int NOT NULL AUTO_INCREMENT,
    customer_order_id int NOT NULL,
    bottle_id int NOT NULL,
    quantity int NOT NULL,
    order_price decimal(8,2) NOT NULL,
    UNIQUE INDEX customer_order_items_ak_1 (customer_order_id,bottle_id),
    CONSTRAINT customer_order_items_pk PRIMARY KEY (id)
);

-- Table: employee
CREATE TABLE employee (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    username varchar(255) NOT NULL,
    password varchar(255) NOT NULL,
    phone varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    insert_ts timestamp NOT NULL,
    is_active bool NOT NULL,
    UNIQUE INDEX employee_ak_1 (username),
    CONSTRAINT employee_pk PRIMARY KEY (id)
);

-- Table: inventory
CREATE TABLE inventory (
    id int NOT NULL,
    store_id int NOT NULL,
    bottle_id int NOT NULL,
    quantity int NOT NULL,
    UNIQUE INDEX inventory_ak_1 (store_id,bottle_id),
    CONSTRAINT inventory_pk PRIMARY KEY (id)
);

-- Table: invoice
CREATE TABLE invoice (
    id int NOT NULL AUTO_INCREMENT,
    invoice_number varchar(64) NOT NULL,
    store_id int NOT NULL,
    customer_order_id int NULL,
    customer_id int NULL,
    employee_id int NOT NULL,
    invoice_total decimal(8,2) NOT NULL,
    time_created timestamp NOT NULL,
    time_due timestamp NOT NULL,
    time_paid timestamp NOT NULL,
    insert_ts timestamp NOT NULL,
    UNIQUE INDEX invoice_ak_1 (invoice_number),
    CONSTRAINT invoice_pk PRIMARY KEY (id)
);

-- Table: invoice_item
CREATE TABLE invoice_item (
    id int NOT NULL AUTO_INCREMENT,
    invoice_id int NOT NULL,
    bottle_id int NOT NULL,
    quantity int NOT NULL,
    item_price decimal(8,2) NOT NULL,
    UNIQUE INDEX invoice_item_ak_1 (invoice_id,bottle_id),
    CONSTRAINT invoice_item_pk PRIMARY KEY (id)
);

-- Table: order
CREATE TABLE `order` (
    id int NOT NULL AUTO_INCREMENT,
    order_number varchar(64) NOT NULL,
    expected_delivery_date date NOT NULL,
    time_placed timestamp NOT NULL,
    time_canceled timestamp NULL,
    time_delivered timestamp NULL,
    supplier_id int NOT NULL,
    store_id int NOT NULL,
    employee_id int NOT NULL,
    order_price decimal(8,2) NULL COMMENT 'price could be NULL initially and updated by supplier',
    UNIQUE INDEX order_ak_1 (order_number),
    CONSTRAINT order_pk PRIMARY KEY (id)
);

-- Table: order_item
CREATE TABLE order_item (
    id int NOT NULL AUTO_INCREMENT,
    order_id int NOT NULL,
    bottle_id int NOT NULL,
    quantity int NOT NULL,
    order_price decimal(8,2) NULL COMMENT 'price could be NULL initially and updated by supplier',
    CONSTRAINT order_item_pk PRIMARY KEY (id)
);

-- Table: producer
CREATE TABLE producer (
    id int NOT NULL AUTO_INCREMENT,
    producer_name varchar(255) NOT NULL,
    details text NULL,
    region_id int NOT NULL,
    UNIQUE INDEX producer_ak_1 (producer_name,region_id),
    CONSTRAINT producer_pk PRIMARY KEY (id)
);

-- Table: region
CREATE TABLE region (
    id int NOT NULL AUTO_INCREMENT,
    region_name varchar(255) NOT NULL,
    country_id int NOT NULL,
    UNIQUE INDEX region_ak_1 (region_name,country_id),
    CONSTRAINT region_pk PRIMARY KEY (id)
);

-- Table: store
CREATE TABLE store (
    id int NOT NULL AUTO_INCREMENT,
    store_name varchar(255) NOT NULL,
    city_id int NOT NULL,
    address varchar(255) NOT NULL,
    phone varchar(255) NOT NULL,
    mobile varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    details text NULL,
    UNIQUE INDEX store_ak_1 (store_name,city_id),
    CONSTRAINT store_pk PRIMARY KEY (id)
);

-- Table: supplier
CREATE TABLE supplier (
    id int NOT NULL AUTO_INCREMENT,
    supplier_name varchar(255) NOT NULL,
    address varchar(255) NOT NULL,
    phone varchar(255) NULL,
    mobile varchar(255) NULL,
    email varchar(255) NULL,
    details text NULL,
    UNIQUE INDEX supplier_ak_1 (supplier_name),
    CONSTRAINT supplier_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: bottle_category (table: bottle)
ALTER TABLE bottle ADD CONSTRAINT bottle_category FOREIGN KEY bottle_category (category_id)
    REFERENCES category (id);

-- Reference: bottle_producer (table: bottle)
ALTER TABLE bottle ADD CONSTRAINT bottle_producer FOREIGN KEY bottle_producer (producer_id)
    REFERENCES producer (id);

-- Reference: city_country (table: city)
ALTER TABLE city ADD CONSTRAINT city_country FOREIGN KEY city_country (country_id)
    REFERENCES country (id);

-- Reference: customer_order_customer (table: customer_order)
ALTER TABLE customer_order ADD CONSTRAINT customer_order_customer FOREIGN KEY customer_order_customer (customer_id)
    REFERENCES customer (id);

-- Reference: customer_order_items_bottle (table: customer_order_items)
ALTER TABLE customer_order_items ADD CONSTRAINT customer_order_items_bottle FOREIGN KEY customer_order_items_bottle (bottle_id)
    REFERENCES bottle (id);

-- Reference: customer_order_items_customer_order (table: customer_order_items)
ALTER TABLE customer_order_items ADD CONSTRAINT customer_order_items_customer_order FOREIGN KEY customer_order_items_customer_order (customer_order_id)
    REFERENCES customer_order (id);

-- Reference: customer_order_store (table: customer_order)
ALTER TABLE customer_order ADD CONSTRAINT customer_order_store FOREIGN KEY customer_order_store (store_id)
    REFERENCES store (id);

-- Reference: inventory_bottle (table: inventory)
ALTER TABLE inventory ADD CONSTRAINT inventory_bottle FOREIGN KEY inventory_bottle (bottle_id)
    REFERENCES bottle (id);

-- Reference: inventory_store (table: inventory)
ALTER TABLE inventory ADD CONSTRAINT inventory_store FOREIGN KEY inventory_store (store_id)
    REFERENCES store (id);

-- Reference: invoice_customer (table: invoice)
ALTER TABLE invoice ADD CONSTRAINT invoice_customer FOREIGN KEY invoice_customer (customer_id)
    REFERENCES customer (id);

-- Reference: invoice_customer_order (table: invoice)
ALTER TABLE invoice ADD CONSTRAINT invoice_customer_order FOREIGN KEY invoice_customer_order (customer_order_id)
    REFERENCES customer_order (id);

-- Reference: invoice_employee (table: invoice)
ALTER TABLE invoice ADD CONSTRAINT invoice_employee FOREIGN KEY invoice_employee (employee_id)
    REFERENCES employee (id);

-- Reference: invoice_item_bottle (table: invoice_item)
ALTER TABLE invoice_item ADD CONSTRAINT invoice_item_bottle FOREIGN KEY invoice_item_bottle (bottle_id)
    REFERENCES bottle (id);

-- Reference: invoice_item_invoice (table: invoice_item)
ALTER TABLE invoice_item ADD CONSTRAINT invoice_item_invoice FOREIGN KEY invoice_item_invoice (invoice_id)
    REFERENCES invoice (id);

-- Reference: invoice_store (table: invoice)
ALTER TABLE invoice ADD CONSTRAINT invoice_store FOREIGN KEY invoice_store (store_id)
    REFERENCES store (id);

-- Reference: order_employee (table: order)
ALTER TABLE `order` ADD CONSTRAINT order_employee FOREIGN KEY order_employee (employee_id)
    REFERENCES employee (id);

-- Reference: order_items_bottle (table: order_item)
ALTER TABLE order_item ADD CONSTRAINT order_items_bottle FOREIGN KEY order_items_bottle (bottle_id)
    REFERENCES bottle (id);

-- Reference: order_items_order (table: order_item)
ALTER TABLE order_item ADD CONSTRAINT order_items_order FOREIGN KEY order_items_order (order_id)
    REFERENCES `order` (id);

-- Reference: order_store (table: order)
ALTER TABLE `order` ADD CONSTRAINT order_store FOREIGN KEY order_store (store_id)
    REFERENCES store (id);

-- Reference: order_supplier (table: order)
ALTER TABLE `order` ADD CONSTRAINT order_supplier FOREIGN KEY order_supplier (supplier_id)
    REFERENCES supplier (id);

-- Reference: producer_region (table: producer)
ALTER TABLE producer ADD CONSTRAINT producer_region FOREIGN KEY producer_region (region_id)
    REFERENCES region (id);

-- Reference: region_country (table: region)
ALTER TABLE region ADD CONSTRAINT region_country FOREIGN KEY region_country (country_id)
    REFERENCES country (id);

-- Reference: store_city (table: store)
ALTER TABLE store ADD CONSTRAINT store_city FOREIGN KEY store_city (city_id)
    REFERENCES city (id);

-- End of file.


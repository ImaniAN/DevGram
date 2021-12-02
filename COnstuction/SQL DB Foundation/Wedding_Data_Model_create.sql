-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:57:34.766

-- tables
-- Table: city
CREATE TABLE city (
    id int NOT NULL AUTO_INCREMENT,
    city_name varchar(255) NOT NULL,
    postal_code varchar(16) NOT NULL,
    country_id int NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (id)
);

-- Table: country
CREATE TABLE country (
    id int NOT NULL AUTO_INCREMENT,
    country_name varchar(255) NOT NULL,
    UNIQUE INDEX country_ak_1 (country_name),
    CONSTRAINT country_pk PRIMARY KEY (id)
);

-- Table: event
CREATE TABLE event (
    id int NOT NULL AUTO_INCREMENT,
    event_name varchar(64) NOT NULL,
    wedding_id int NOT NULL,
    location_id int NULL,
    start_time_planned timestamp NULL,
    end_time_planned timestamp NULL,
    start_time timestamp NULL,
    end_time timestamp NULL,
    budget_planned decimal(10,2) NOT NULL,
    UNIQUE INDEX event_ak_1 (event_name,wedding_id),
    CONSTRAINT event_pk PRIMARY KEY (id)
);

-- Table: in_event
CREATE TABLE in_event (
    id int NOT NULL AUTO_INCREMENT,
    event_id int NOT NULL,
    participate_id int NOT NULL,
    details text NULL,
    UNIQUE INDEX in_event_ak_1 (event_id,participate_id),
    CONSTRAINT in_event_pk PRIMARY KEY (id)
);

-- Table: invoice
CREATE TABLE invoice (
    id int NOT NULL AUTO_INCREMENT,
    wedding_id int NOT NULL,
    time_created timestamp NOT NULL,
    due_date date NOT NULL,
    invoice_amount decimal(10,2) NOT NULL,
    payment_time timestamp NULL,
    paid bool NOT NULL,
    CONSTRAINT invoice_pk PRIMARY KEY (id)
);

-- Table: invoice_item
CREATE TABLE invoice_item (
    id int NOT NULL AUTO_INCREMENT,
    item_name varchar(255) NOT NULL,
    item_price decimal(10,2) NOT NULL,
    invoice_id int NOT NULL,
    service_included_id int NULL,
    product_included_id int NULL,
    CONSTRAINT invoice_item_pk PRIMARY KEY (id)
);

-- Table: location
CREATE TABLE location (
    id int NOT NULL AUTO_INCREMENT,
    location_name varchar(255) NOT NULL,
    city_id int NOT NULL,
    UNIQUE INDEX location_ak_1 (location_name,city_id),
    CONSTRAINT location_pk PRIMARY KEY (id)
);

-- Table: participate
CREATE TABLE participate (
    id int NOT NULL AUTO_INCREMENT,
    wedding_id int NOT NULL,
    person_id int NOT NULL,
    role_id int NOT NULL,
    UNIQUE INDEX participate_ak_1 (wedding_id,person_id),
    CONSTRAINT participate_pk PRIMARY KEY (id)
);

-- Table: partner
CREATE TABLE partner (
    id int NOT NULL AUTO_INCREMENT,
    partner_code varchar(16) NOT NULL,
    partner_name varchar(255) NOT NULL,
    UNIQUE INDEX partner_ak_1 (partner_code),
    CONSTRAINT partner_pk PRIMARY KEY (id)
);

-- Table: person
CREATE TABLE person (
    id int NOT NULL AUTO_INCREMENT,
    person_code varchar(16) NOT NULL,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    UNIQUE INDEX person_ak_1 (person_code),
    CONSTRAINT person_pk PRIMARY KEY (id)
);

-- Table: product
CREATE TABLE product (
    id int NOT NULL AUTO_INCREMENT,
    product_code varchar(16) NOT NULL,
    product_name varchar(255) NOT NULL,
    description text NULL,
    picture text NULL,
    price decimal(10,2) NULL,
    UNIQUE INDEX product_ak_1 (product_code),
    CONSTRAINT product_pk PRIMARY KEY (id)
);

-- Table: product_included
CREATE TABLE product_included (
    id int NOT NULL AUTO_INCREMENT,
    event_id int NOT NULL,
    provides_product_id int NOT NULL,
    price decimal(10,2) NOT NULL,
    current_status_id int NOT NULL,
    CONSTRAINT product_included_pk PRIMARY KEY (id)
);

-- Table: provides_product
CREATE TABLE provides_product (
    id int NOT NULL AUTO_INCREMENT,
    partner_id int NOT NULL,
    product_id int NOT NULL,
    details text NULL,
    is_active bool NOT NULL,
    UNIQUE INDEX provides_product_ak_1 (partner_id,product_id),
    CONSTRAINT provides_product_pk PRIMARY KEY (id)
);

-- Table: provides_service
CREATE TABLE provides_service (
    id int NOT NULL AUTO_INCREMENT,
    partner_id int NOT NULL,
    service_id int NOT NULL,
    details text NULL,
    is_active bool NOT NULL,
    UNIQUE INDEX provides_ak_1 (partner_id,service_id),
    CONSTRAINT provides_service_pk PRIMARY KEY (id)
);

-- Table: role
CREATE TABLE role (
    id int NOT NULL AUTO_INCREMENT,
    role_name varchar(64) NOT NULL,
    UNIQUE INDEX role_ak_1 (role_name),
    CONSTRAINT role_pk PRIMARY KEY (id)
) COMMENT 'bride, groom, best man, guest...';

-- Table: service
CREATE TABLE service (
    id int NOT NULL AUTO_INCREMENT,
    service_code varchar(16) NOT NULL,
    service_name varchar(255) NOT NULL,
    description text NULL,
    picture text NULL,
    price decimal(10,2) NULL,
    UNIQUE INDEX service_ak_1 (service_code),
    CONSTRAINT service_pk PRIMARY KEY (id)
) COMMENT 'service dictionary: renting hall, band, food & cake...';

-- Table: service_included
CREATE TABLE service_included (
    id int NOT NULL AUTO_INCREMENT,
    event_id int NOT NULL,
    provides_service_id int NOT NULL,
    price decimal(10,2) NOT NULL,
    current_status_id int NOT NULL,
    CONSTRAINT service_included_pk PRIMARY KEY (id)
);

-- Table: status
CREATE TABLE status (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(255) NOT NULL,
    offer bool NOT NULL,
    offer_accepted bool NOT NULL,
    offer_rejected bool NOT NULL,
    UNIQUE INDEX status_ak_1 (status_name),
    CONSTRAINT status_pk PRIMARY KEY (id)
) COMMENT 'list of all possible statuses like: offer, accepted, rejected';

-- Table: wedding
CREATE TABLE wedding (
    id int NOT NULL AUTO_INCREMENT,
    wedding_code varchar(16) NOT NULL,
    start_time_planned timestamp NULL,
    end_time_planned timestamp NULL,
    start_time timestamp NULL,
    end_time timestamp NULL,
    budget_planned decimal(10,2) NULL,
    UNIQUE INDEX wedding_ak_1 (wedding_code),
    CONSTRAINT wedding_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: city_country (table: city)
ALTER TABLE city ADD CONSTRAINT city_country FOREIGN KEY city_country (country_id)
    REFERENCES country (id);

-- Reference: event_location (table: event)
ALTER TABLE event ADD CONSTRAINT event_location FOREIGN KEY event_location (location_id)
    REFERENCES location (id);

-- Reference: event_wedding (table: event)
ALTER TABLE event ADD CONSTRAINT event_wedding FOREIGN KEY event_wedding (wedding_id)
    REFERENCES wedding (id);

-- Reference: in_event_event (table: in_event)
ALTER TABLE in_event ADD CONSTRAINT in_event_event FOREIGN KEY in_event_event (event_id)
    REFERENCES event (id);

-- Reference: in_event_participate (table: in_event)
ALTER TABLE in_event ADD CONSTRAINT in_event_participate FOREIGN KEY in_event_participate (participate_id)
    REFERENCES participate (id);

-- Reference: invoice_item_invoice (table: invoice_item)
ALTER TABLE invoice_item ADD CONSTRAINT invoice_item_invoice FOREIGN KEY invoice_item_invoice (invoice_id)
    REFERENCES invoice (id);

-- Reference: invoice_item_product_included (table: invoice_item)
ALTER TABLE invoice_item ADD CONSTRAINT invoice_item_product_included FOREIGN KEY invoice_item_product_included (product_included_id)
    REFERENCES product_included (id);

-- Reference: invoice_item_service_included (table: invoice_item)
ALTER TABLE invoice_item ADD CONSTRAINT invoice_item_service_included FOREIGN KEY invoice_item_service_included (service_included_id)
    REFERENCES service_included (id);

-- Reference: invoice_wedding (table: invoice)
ALTER TABLE invoice ADD CONSTRAINT invoice_wedding FOREIGN KEY invoice_wedding (wedding_id)
    REFERENCES wedding (id);

-- Reference: location_city (table: location)
ALTER TABLE location ADD CONSTRAINT location_city FOREIGN KEY location_city (city_id)
    REFERENCES city (id);

-- Reference: participate_person (table: participate)
ALTER TABLE participate ADD CONSTRAINT participate_person FOREIGN KEY participate_person (person_id)
    REFERENCES person (id);

-- Reference: participate_role (table: participate)
ALTER TABLE participate ADD CONSTRAINT participate_role FOREIGN KEY participate_role (role_id)
    REFERENCES role (id);

-- Reference: participate_wedding (table: participate)
ALTER TABLE participate ADD CONSTRAINT participate_wedding FOREIGN KEY participate_wedding (wedding_id)
    REFERENCES wedding (id);

-- Reference: product_included_event (table: product_included)
ALTER TABLE product_included ADD CONSTRAINT product_included_event FOREIGN KEY product_included_event (event_id)
    REFERENCES event (id);

-- Reference: product_included_provides_product (table: product_included)
ALTER TABLE product_included ADD CONSTRAINT product_included_provides_product FOREIGN KEY product_included_provides_product (provides_product_id)
    REFERENCES provides_product (id);

-- Reference: product_included_status (table: product_included)
ALTER TABLE product_included ADD CONSTRAINT product_included_status FOREIGN KEY product_included_status (current_status_id)
    REFERENCES status (id);

-- Reference: provides_partner (table: provides_service)
ALTER TABLE provides_service ADD CONSTRAINT provides_partner FOREIGN KEY provides_partner (partner_id)
    REFERENCES partner (id);

-- Reference: provides_product_partner (table: provides_product)
ALTER TABLE provides_product ADD CONSTRAINT provides_product_partner FOREIGN KEY provides_product_partner (partner_id)
    REFERENCES partner (id);

-- Reference: provides_product_product (table: provides_product)
ALTER TABLE provides_product ADD CONSTRAINT provides_product_product FOREIGN KEY provides_product_product (product_id)
    REFERENCES product (id);

-- Reference: provides_service (table: provides_service)
ALTER TABLE provides_service ADD CONSTRAINT provides_service FOREIGN KEY provides_service (service_id)
    REFERENCES service (id);

-- Reference: service_included_event (table: service_included)
ALTER TABLE service_included ADD CONSTRAINT service_included_event FOREIGN KEY service_included_event (event_id)
    REFERENCES event (id);

-- Reference: service_included_provides_service (table: service_included)
ALTER TABLE service_included ADD CONSTRAINT service_included_provides_service FOREIGN KEY service_included_provides_service (provides_service_id)
    REFERENCES provides_service (id);

-- Reference: service_included_status (table: service_included)
ALTER TABLE service_included ADD CONSTRAINT service_included_status FOREIGN KEY service_included_status (current_status_id)
    REFERENCES status (id);

-- End of file.


-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:47:43.702

-- tables
-- Table: city
CREATE TABLE city (
    id int NOT NULL,
    city_name varchar(128) NOT NULL,
    country_id int NOT NULL,
    UNIQUE INDEX city_ak_1 (city_name,country_id),
    CONSTRAINT city_pk PRIMARY KEY (id)
);

-- Table: company
CREATE TABLE company (
    id int NOT NULL AUTO_INCREMENT,
    company_name varchar(128) NOT NULL,
    city_id int NOT NULL,
    details text NOT NULL,
    UNIQUE INDEX company_ak_1 (company_name,city_id),
    CONSTRAINT company_pk PRIMARY KEY (id)
);

-- Table: country
CREATE TABLE country (
    id int NOT NULL,
    country_name varchar(128) NOT NULL,
    UNIQUE INDEX country_ak_1 (country_name),
    CONSTRAINT country_pk PRIMARY KEY (id)
);

-- Table: passenger
CREATE TABLE passenger (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    address varchar(128) NOT NULL,
    city_id int NOT NULL,
    CONSTRAINT passenger_pk PRIMARY KEY (id)
);

-- Table: service_included
CREATE TABLE service_included (
    ticket_type_id int NOT NULL,
    service_provided_id int NOT NULL,
    CONSTRAINT service_included_pk PRIMARY KEY (ticket_type_id,service_provided_id)
);

-- Table: service_provided
CREATE TABLE service_provided (
    id int NOT NULL AUTO_INCREMENT,
    zone_id int NOT NULL,
    company_id int NOT NULL,
    transport_form_id int NOT NULL,
    date_from date NOT NULL,
    date_to date NULL,
    details text NULL,
    is_active bool NOT NULL,
    UNIQUE INDEX service_provided_ak_1 (zone_id,company_id,date_from),
    CONSTRAINT service_provided_pk PRIMARY KEY (id)
);

-- Table: ticket
CREATE TABLE ticket (
    id int NOT NULL AUTO_INCREMENT,
    serial_number varchar(64) NOT NULL,
    ticket_type_id int NOT NULL,
    passenger_id int NULL,
    valid_from date NULL,
    valid_to date NULL,
    credits decimal(10,2) NULL,
    UNIQUE INDEX ticket_ak_1 (serial_number),
    CONSTRAINT ticket_pk PRIMARY KEY (id)
);

-- Table: ticket_type
CREATE TABLE ticket_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(64) NOT NULL,
    valid_from date NULL,
    valid_to date NULL,
    details text NULL,
    recurring bool NOT NULL,
    interval_months int NULL,
    UNIQUE INDEX ticket_type_ak_1 (type_name),
    CONSTRAINT ticket_type_pk PRIMARY KEY (id)
);

-- Table: transport_form
CREATE TABLE transport_form (
    id int NOT NULL AUTO_INCREMENT,
    form_name varchar(64) NOT NULL,
    UNIQUE INDEX transport_form_ak_1 (form_name),
    CONSTRAINT transport_form_pk PRIMARY KEY (id)
);

-- Table: zone
CREATE TABLE zone (
    id int NOT NULL AUTO_INCREMENT,
    city_id int NOT NULL,
    zone_name varchar(64) NOT NULL,
    UNIQUE INDEX zone_ak_1 (city_id,zone_name),
    CONSTRAINT zone_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: city_country (table: city)
ALTER TABLE city ADD CONSTRAINT city_country FOREIGN KEY city_country (country_id)
    REFERENCES country (id);

-- Reference: company_city (table: company)
ALTER TABLE company ADD CONSTRAINT company_city FOREIGN KEY company_city (city_id)
    REFERENCES city (id);

-- Reference: form_available_company (table: service_provided)
ALTER TABLE service_provided ADD CONSTRAINT form_available_company FOREIGN KEY form_available_company (company_id)
    REFERENCES company (id);

-- Reference: form_available_transport_form (table: service_provided)
ALTER TABLE service_provided ADD CONSTRAINT form_available_transport_form FOREIGN KEY form_available_transport_form (transport_form_id)
    REFERENCES transport_form (id);

-- Reference: form_available_zone (table: service_provided)
ALTER TABLE service_provided ADD CONSTRAINT form_available_zone FOREIGN KEY form_available_zone (zone_id)
    REFERENCES zone (id);

-- Reference: passenger_city (table: passenger)
ALTER TABLE passenger ADD CONSTRAINT passenger_city FOREIGN KEY passenger_city (city_id)
    REFERENCES city (id);

-- Reference: ticket_passenger (table: ticket)
ALTER TABLE ticket ADD CONSTRAINT ticket_passenger FOREIGN KEY ticket_passenger (passenger_id)
    REFERENCES passenger (id);

-- Reference: ticket_ticket_type (table: ticket)
ALTER TABLE ticket ADD CONSTRAINT ticket_ticket_type FOREIGN KEY ticket_ticket_type (ticket_type_id)
    REFERENCES ticket_type (id);

-- Reference: ticket_zones_form_available (table: service_included)
ALTER TABLE service_included ADD CONSTRAINT ticket_zones_form_available FOREIGN KEY ticket_zones_form_available (service_provided_id)
    REFERENCES service_provided (id);

-- Reference: ticket_zones_ticket_type (table: service_included)
ALTER TABLE service_included ADD CONSTRAINT ticket_zones_ticket_type FOREIGN KEY ticket_zones_ticket_type (ticket_type_id)
    REFERENCES ticket_type (id);

-- Reference: zone_city (table: zone)
ALTER TABLE zone ADD CONSTRAINT zone_city FOREIGN KEY zone_city (city_id)
    REFERENCES city (id);

-- End of file.


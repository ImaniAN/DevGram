-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:53:02.417

-- tables
-- Table: category
CREATE TABLE category (
    id int NOT NULL AUTO_INCREMENT,
    category_name varchar(128) NOT NULL,
    UNIQUE INDEX category_ak_1 (category_name),
    CONSTRAINT category_pk PRIMARY KEY (id)
);

-- Table: channel
CREATE TABLE channel (
    id int NOT NULL AUTO_INCREMENT,
    channel_name varchar(255) NOT NULL,
    details text NOT NULL,
    UNIQUE INDEX channel_ak_1 (channel_name),
    CONSTRAINT channel_pk PRIMARY KEY (id)
) COMMENT 'Booking, Airbnb, 
...';

-- Table: channel_used
CREATE TABLE channel_used (
    room_id int NOT NULL,
    channel_id int NOT NULL,
    CONSTRAINT channel_used_pk PRIMARY KEY (room_id,channel_id)
);

-- Table: city
CREATE TABLE city (
    id int NOT NULL AUTO_INCREMENT,
    city_name varchar(128) NOT NULL,
    postal_code varchar(16) NOT NULL,
    country_id int NOT NULL,
    UNIQUE INDEX city_ak_1 (city_name,postal_code,country_id),
    CONSTRAINT city_pk PRIMARY KEY (id)
);

-- Table: company
CREATE TABLE company (
    id int NOT NULL AUTO_INCREMENT,
    company_name varchar(255) NOT NULL,
    VAT_ID varchar(16) NOT NULL,
    email varchar(255) NOT NULL,
    city_id int NOT NULL,
    company_address varchar(255) NOT NULL,
    details text NOT NULL,
    is_active bool NOT NULL,
    UNIQUE INDEX company_ak_1 (VAT_ID),
    CONSTRAINT company_pk PRIMARY KEY (id)
);

-- Table: company_plan
CREATE TABLE company_plan (
    id int NOT NULL AUTO_INCREMENT,
    company_id int NOT NULL,
    plan_id int NOT NULL,
    ts_created timestamp NOT NULL,
    ts_activated timestamp NOT NULL,
    ts_deactivated timestamp NOT NULL,
    CONSTRAINT company_plan_pk PRIMARY KEY (id)
);

-- Table: company_plan_status_catalog
CREATE TABLE company_plan_status_catalog (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(64) NOT NULL,
    plan_is_active bool NOT NULL,
    UNIQUE INDEX company_plan_status_catalog_ak_1 (status_name),
    CONSTRAINT company_plan_status_catalog_pk PRIMARY KEY (id)
);

-- Table: company_plan_status_events
CREATE TABLE company_plan_status_events (
    id int NOT NULL AUTO_INCREMENT,
    company_plan_id int NOT NULL,
    company_plan_status_catalog_id int NOT NULL,
    ts timestamp NOT NULL,
    UNIQUE INDEX company_plan_status_ak_1 (company_plan_id,company_plan_status_catalog_id),
    CONSTRAINT company_plan_status_events_pk PRIMARY KEY (id)
);

-- Table: country
CREATE TABLE country (
    id int NOT NULL AUTO_INCREMENT,
    country_name varchar(128) NOT NULL,
    UNIQUE INDEX country_ak_1 (country_name),
    CONSTRAINT country_pk PRIMARY KEY (id)
);

-- Table: guest
CREATE TABLE guest (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(128) NOT NULL,
    last_name varchar(128) NOT NULL,
    email varchar(255) NOT NULL,
    phone varchar(255) NULL,
    address varchar(255) NULL,
    details text NULL,
    CONSTRAINT guest_pk PRIMARY KEY (id)
);

-- Table: hotel
CREATE TABLE hotel (
    id int NOT NULL AUTO_INCREMENT,
    hotel_name varchar(128) NOT NULL,
    description text NOT NULL,
    company_id int NOT NULL,
    city_id int NOT NULL,
    category_id int NOT NULL,
    is_active bool NOT NULL,
    UNIQUE INDEX hotel_ak_1 (hotel_name),
    CONSTRAINT hotel_pk PRIMARY KEY (id)
);

-- Table: invoice_company
CREATE TABLE invoice_company (
    id int NOT NULL AUTO_INCREMENT,
    company_id int NOT NULL,
    invoice_amount decimal(10,2) NOT NULL,
    invoice_period varchar(255) NOT NULL,
    invoice_details text NOT NULL,
    ts_issued timestamp NOT NULL,
    ts_paid timestamp NULL,
    ts_canceled timestamp NULL,
    CONSTRAINT invoice_company_pk PRIMARY KEY (id)
);

-- Table: invoice_guest
CREATE TABLE invoice_guest (
    id int NOT NULL AUTO_INCREMENT,
    guest_id int NOT NULL,
    reservation_id int NOT NULL,
    invoice_amount decimal(10,2) NOT NULL,
    ts_issued timestamp NOT NULL,
    ts_paid timestamp NULL,
    ts_canceled timestamp NULL,
    CONSTRAINT invoice_guest_pk PRIMARY KEY (id)
);

-- Table: plan
CREATE TABLE plan (
    id int NOT NULL AUTO_INCREMENT,
    plan_name varchar(64) NOT NULL,
    details varchar(255) NOT NULL,
    rooms_min int NOT NULL,
    rooms_max int NULL,
    monthly_price decimal(10,2) NOT NULL,
    UNIQUE INDEX plan_ak_1 (plan_name),
    CONSTRAINT plan_pk PRIMARY KEY (id)
);

-- Table: reservation
CREATE TABLE reservation (
    id int NOT NULL AUTO_INCREMENT,
    guest_id int NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    ts_created timestamp NOT NULL,
    ts_updated timestamp NOT NULL,
    discount_percent decimal(5,2) NOT NULL,
    total_price decimal(10,2) NOT NULL,
    CONSTRAINT reservation_pk PRIMARY KEY (id)
);

-- Table: reservation_status_catalog
CREATE TABLE reservation_status_catalog (
    id int NOT NULL AUTO_INCREMENT,
    status_name int NOT NULL,
    UNIQUE INDEX reservation_status_catalog_ak_1 (status_name),
    CONSTRAINT reservation_status_catalog_pk PRIMARY KEY (id)
);

-- Table: reservation_status_events
CREATE TABLE reservation_status_events (
    id int NOT NULL AUTO_INCREMENT,
    reservation_id int NOT NULL,
    reservation_status_catalog_id int NOT NULL,
    details text NULL,
    ts_created timestamp NOT NULL,
    CONSTRAINT reservation_status_events_pk PRIMARY KEY (id)
);

-- Table: room
CREATE TABLE room (
    id int NOT NULL AUTO_INCREMENT,
    room_name varchar(128) NOT NULL,
    description text NOT NULL,
    hotel_id int NOT NULL,
    room_type_id int NOT NULL,
    current_price decimal(10,2) NOT NULL,
    UNIQUE INDEX room_ak_1 (room_name,hotel_id),
    CONSTRAINT room_pk PRIMARY KEY (id)
);

-- Table: room_reserved
CREATE TABLE room_reserved (
    id int NOT NULL AUTO_INCREMENT,
    reservation_id int NOT NULL,
    room_id int NOT NULL,
    price decimal(10,2) NOT NULL,
    UNIQUE INDEX room_reserved_ak_1 (reservation_id,room_id),
    CONSTRAINT room_reserved_pk PRIMARY KEY (id)
);

-- Table: room_type
CREATE TABLE room_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(128) NOT NULL,
    UNIQUE INDEX room_type_ak_1 (type_name),
    CONSTRAINT room_type_pk PRIMARY KEY (id)
);

-- Table: syncronization
CREATE TABLE syncronization (
    id int NOT NULL AUTO_INCREMENT,
    reservation_id int NOT NULL,
    channel_id int NOT NULL,
    message_sent text NOT NULL,
    message_received text NULL,
    ts timestamp NOT NULL,
    CONSTRAINT syncronization_pk PRIMARY KEY (id)
);

-- Table: user_account
CREATE TABLE user_account (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(128) NOT NULL,
    last_name varchar(128) NOT NULL,
    email varchar(255) NOT NULL,
    user_name varchar(255) NOT NULL,
    password varchar(255) NOT NULL,
    is_active bool NOT NULL,
    ts_created timestamp NOT NULL,
    ts_updated timestamp NOT NULL,
    company_id int NOT NULL,
    UNIQUE INDEX user_account_ak_1 (user_name),
    CONSTRAINT user_account_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: channel_used_channel (table: channel_used)
ALTER TABLE channel_used ADD CONSTRAINT channel_used_channel FOREIGN KEY channel_used_channel (channel_id)
    REFERENCES channel (id);

-- Reference: channel_used_room (table: channel_used)
ALTER TABLE channel_used ADD CONSTRAINT channel_used_room FOREIGN KEY channel_used_room (room_id)
    REFERENCES room (id);

-- Reference: city_country (table: city)
ALTER TABLE city ADD CONSTRAINT city_country FOREIGN KEY city_country (country_id)
    REFERENCES country (id);

-- Reference: company_city (table: company)
ALTER TABLE company ADD CONSTRAINT company_city FOREIGN KEY company_city (city_id)
    REFERENCES city (id);

-- Reference: company_plan_company (table: company_plan)
ALTER TABLE company_plan ADD CONSTRAINT company_plan_company FOREIGN KEY company_plan_company (company_id)
    REFERENCES company (id);

-- Reference: company_plan_plan (table: company_plan)
ALTER TABLE company_plan ADD CONSTRAINT company_plan_plan FOREIGN KEY company_plan_plan (plan_id)
    REFERENCES plan (id);

-- Reference: company_plan_status_company_plan (table: company_plan_status_events)
ALTER TABLE company_plan_status_events ADD CONSTRAINT company_plan_status_company_plan FOREIGN KEY company_plan_status_company_plan (company_plan_id)
    REFERENCES company_plan (id);

-- Reference: company_plan_status_company_plan_status_catalog (table: company_plan_status_events)
ALTER TABLE company_plan_status_events ADD CONSTRAINT company_plan_status_company_plan_status_catalog FOREIGN KEY company_plan_status_company_plan_status_catalog (company_plan_status_catalog_id)
    REFERENCES company_plan_status_catalog (id);

-- Reference: hotel_category (table: hotel)
ALTER TABLE hotel ADD CONSTRAINT hotel_category FOREIGN KEY hotel_category (category_id)
    REFERENCES category (id);

-- Reference: hotel_city (table: hotel)
ALTER TABLE hotel ADD CONSTRAINT hotel_city FOREIGN KEY hotel_city (city_id)
    REFERENCES city (id);

-- Reference: hotel_company (table: hotel)
ALTER TABLE hotel ADD CONSTRAINT hotel_company FOREIGN KEY hotel_company (company_id)
    REFERENCES company (id);

-- Reference: invoice_company_company (table: invoice_company)
ALTER TABLE invoice_company ADD CONSTRAINT invoice_company_company FOREIGN KEY invoice_company_company (company_id)
    REFERENCES company (id);

-- Reference: invoice_guest_guest (table: invoice_guest)
ALTER TABLE invoice_guest ADD CONSTRAINT invoice_guest_guest FOREIGN KEY invoice_guest_guest (guest_id)
    REFERENCES guest (id);

-- Reference: invoice_guest_reservation (table: invoice_guest)
ALTER TABLE invoice_guest ADD CONSTRAINT invoice_guest_reservation FOREIGN KEY invoice_guest_reservation (reservation_id)
    REFERENCES reservation (id);

-- Reference: reservation_guest (table: reservation)
ALTER TABLE reservation ADD CONSTRAINT reservation_guest FOREIGN KEY reservation_guest (guest_id)
    REFERENCES guest (id);

-- Reference: reservation_status_reservation (table: reservation_status_events)
ALTER TABLE reservation_status_events ADD CONSTRAINT reservation_status_reservation FOREIGN KEY reservation_status_reservation (reservation_id)
    REFERENCES reservation (id);

-- Reference: reservation_status_reservation_status_catalog (table: reservation_status_events)
ALTER TABLE reservation_status_events ADD CONSTRAINT reservation_status_reservation_status_catalog FOREIGN KEY reservation_status_reservation_status_catalog (reservation_status_catalog_id)
    REFERENCES reservation_status_catalog (id);

-- Reference: room_hotel (table: room)
ALTER TABLE room ADD CONSTRAINT room_hotel FOREIGN KEY room_hotel (hotel_id)
    REFERENCES hotel (id);

-- Reference: room_reserved_reservation (table: room_reserved)
ALTER TABLE room_reserved ADD CONSTRAINT room_reserved_reservation FOREIGN KEY room_reserved_reservation (reservation_id)
    REFERENCES reservation (id);

-- Reference: room_reserved_room (table: room_reserved)
ALTER TABLE room_reserved ADD CONSTRAINT room_reserved_room FOREIGN KEY room_reserved_room (room_id)
    REFERENCES room (id);

-- Reference: room_room_type (table: room)
ALTER TABLE room ADD CONSTRAINT room_room_type FOREIGN KEY room_room_type (room_type_id)
    REFERENCES room_type (id);

-- Reference: syncronization_channel (table: syncronization)
ALTER TABLE syncronization ADD CONSTRAINT syncronization_channel FOREIGN KEY syncronization_channel (channel_id)
    REFERENCES channel (id);

-- Reference: syncronization_reservation (table: syncronization)
ALTER TABLE syncronization ADD CONSTRAINT syncronization_reservation FOREIGN KEY syncronization_reservation (reservation_id)
    REFERENCES reservation (id);

-- Reference: user_account_company (table: user_account)
ALTER TABLE user_account ADD CONSTRAINT user_account_company FOREIGN KEY user_account_company (company_id)
    REFERENCES company (id);

-- End of file.


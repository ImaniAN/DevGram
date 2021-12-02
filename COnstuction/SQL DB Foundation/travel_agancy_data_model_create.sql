-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:02:56.973

-- tables
-- Table: agent
CREATE TABLE agent (
    id int NOT NULL AUTO_INCREMENT,
    agent_code varchar(8) NOT NULL,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    active bool NOT NULL,
    UNIQUE INDEX agent_ak_1 (agent_code),
    CONSTRAINT agent_pk PRIMARY KEY (id)
) COMMENT 'list of all agents';

-- Table: city
CREATE TABLE city (
    id int NOT NULL AUTO_INCREMENT,
    city_name varchar(255) NOT NULL,
    country_id int NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (id)
);

-- Table: company_type
CREATE TABLE company_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(64) NOT NULL,
    UNIQUE INDEX company_type_ak_1 (type_name),
    CONSTRAINT company_type_pk PRIMARY KEY (id)
) COMMENT 'airline company, railway company, bus company, car rental company';

-- Table: contract
CREATE TABLE contract (
    id int NOT NULL AUTO_INCREMENT,
    contract_code varchar(8) NOT NULL,
    customer_id int NOT NULL,
    agent_id int NOT NULL,
    offer_id int NOT NULL,
    time_signed timestamp NOT NULL,
    total_price decimal(10,2) NOT NULL,
    payment_date date NOT NULL,
    paid bool NOT NULL,
    payment_time timestamp NULL,
    payment_amount decimal(10,2) NULL,
    refunded bool NOT NULL,
    refunded_time timestamp NULL,
    refunded_amount decimal(10,2) NULL,
    UNIQUE INDEX contract_ak_1 (contract_code),
    CONSTRAINT contract_pk PRIMARY KEY (id)
);

-- Table: country
CREATE TABLE country (
    id int NOT NULL AUTO_INCREMENT,
    country_code varchar(8) NOT NULL,
    country_name varchar(64) NOT NULL,
    UNIQUE INDEX country_ak_1 (country_code),
    UNIQUE INDEX country_ak_2 (country_name),
    CONSTRAINT country_pk PRIMARY KEY (id)
);

-- Table: customer
CREATE TABLE customer (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    address varchar(255) NULL,
    phone varchar(32) NULL,
    mobile varchar(32) NULL,
    email varchar(255) NULL,
    details text NULL,
    customer_from timestamp NOT NULL,
    CONSTRAINT customer_pk PRIMARY KEY (id)
) COMMENT 'list of all costumers we worked with';

-- Table: hotel
CREATE TABLE hotel (
    id int NOT NULL AUTO_INCREMENT,
    hotel_name varchar(255) NOT NULL,
    city_id int NOT NULL,
    hotel_address varchar(255) NOT NULL,
    details text NOT NULL,
    is_partner bool NOT NULL,
    active bool NOT NULL,
    CONSTRAINT hotel_pk PRIMARY KEY (id)
) COMMENT 'list of all hotels we work with';

-- Table: hotel_service
CREATE TABLE hotel_service (
    id int NOT NULL AUTO_INCREMENT,
    hotel_id int NOT NULL,
    room_type_id int NOT NULL,
    service_price decimal(10,2) NOT NULL,
    active bool NOT NULL,
    UNIQUE INDEX hotel_service_ak_1 (hotel_id,room_type_id),
    CONSTRAINT hotel_service_pk PRIMARY KEY (id)
) COMMENT 'list of accommodation services';

-- Table: offer
CREATE TABLE offer (
    id int NOT NULL AUTO_INCREMENT,
    offer_code varchar(8) NOT NULL,
    offer_name varchar(255) NOT NULL,
    time_created timestamp NOT NULL,
    active_from date NOT NULL,
    active_to date NULL,
    time_accepted timestamp NULL,
    accepted bool NOT NULL,
    promo_offer_id int NULL,
    agent_id int NOT NULL,
    customer_id int NOT NULL,
    UNIQUE INDEX offer_ak_1 (offer_code),
    CONSTRAINT offer_pk PRIMARY KEY (id)
);

-- Table: offer_hotel_services
CREATE TABLE offer_hotel_services (
    id int NOT NULL AUTO_INCREMENT,
    offer_id int NOT NULL,
    hotel_service_id int NOT NULL,
    price decimal(10,2) NOT NULL,
    discount_percent decimal(5,2) NOT NULL,
    final_service_price decimal(10,2) NOT NULL,
    description text NOT NULL COMMENT 'all details related with that service (e.g. room number, number of days staying in a hotel room, etc.)',
    CONSTRAINT offer_hotel_services_pk PRIMARY KEY (id)
);

-- Table: offer_transport_services
CREATE TABLE offer_transport_services (
    id int NOT NULL AUTO_INCREMENT,
    offer_id int NOT NULL,
    transport_service_id int NOT NULL,
    price decimal(10,2) NOT NULL,
    discount_percent decimal(5,2) NOT NULL,
    final_service_price decimal(10,2) NOT NULL,
    description text NOT NULL COMMENT 'all details related with that service (e.g. room number, number of days staying in a hotel room, etc.)',
    CONSTRAINT offer_transport_services_pk PRIMARY KEY (id)
);

-- Table: promo_offer
CREATE TABLE promo_offer (
    id int NOT NULL AUTO_INCREMENT,
    promo_offer_code varchar(8) NOT NULL,
    promo_offer_name varchar(64) NOT NULL,
    active_from date NOT NULL,
    active_to date NULL,
    UNIQUE INDEX promo_offer_ak_1 (promo_offer_code),
    CONSTRAINT promo_offer_pk PRIMARY KEY (id)
);

-- Table: promo_offer_hotel_services
CREATE TABLE promo_offer_hotel_services (
    id int NOT NULL AUTO_INCREMENT,
    promo_offer_id int NOT NULL,
    hotel_service_id int NOT NULL,
    price decimal(10,2) NOT NULL,
    discount_percent double(5,2) NOT NULL,
    final_service_price decimal(10,2) NOT NULL,
    description text NOT NULL,
    CONSTRAINT promo_offer_hotel_services_pk PRIMARY KEY (id)
);

-- Table: promo_offer_transport_services
CREATE TABLE promo_offer_transport_services (
    id int NOT NULL AUTO_INCREMENT,
    promo_offer_id int NOT NULL,
    transport_service_id int NOT NULL,
    price decimal(10,2) NOT NULL,
    discount_percent double(5,2) NOT NULL,
    final_service_price decimal(10,2) NOT NULL,
    description text NOT NULL,
    CONSTRAINT promo_offer_transport_services_pk PRIMARY KEY (id)
);

-- Table: room_type
CREATE TABLE room_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(64) NOT NULL,
    UNIQUE INDEX room_type_ak_1 (type_name),
    CONSTRAINT room_type_pk PRIMARY KEY (id)
) COMMENT 'single, double, etc.';

-- Table: ticket_type
CREATE TABLE ticket_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(64) NOT NULL,
    UNIQUE INDEX ticket_type_ak_1 (type_name),
    CONSTRAINT ticket_type_pk PRIMARY KEY (id)
) COMMENT 'one-way ticket, two-way ticket, first class etc. ';

-- Table: transport_company
CREATE TABLE transport_company (
    id int NOT NULL AUTO_INCREMENT,
    company_name varchar(255) NOT NULL,
    city_id int NOT NULL,
    HQ_address varchar(255) NOT NULL,
    company_type_id int NOT NULL,
    description text NOT NULL,
    is_partner bool NOT NULL,
    active bool NOT NULL,
    CONSTRAINT transport_company_pk PRIMARY KEY (id)
) COMMENT 'list of all transport companies we work with';

-- Table: transport_service
CREATE TABLE transport_service (
    id int NOT NULL AUTO_INCREMENT,
    transport_company_id int NULL,
    ticket_type_id int NOT NULL,
    from_city_id int NOT NULL,
    to_city_id int NOT NULL,
    service_price decimal(10,2) NOT NULL,
    active bool NOT NULL,
    UNIQUE INDEX transport_service_ak_1 (transport_company_id,ticket_type_id,from_city_id,to_city_id),
    CONSTRAINT transport_service_pk PRIMARY KEY (id)
) COMMENT 'list of transport services';

-- foreign keys
-- Reference: city_country (table: city)
ALTER TABLE city ADD CONSTRAINT city_country FOREIGN KEY city_country (country_id)
    REFERENCES country (id);

-- Reference: contract_agent (table: contract)
ALTER TABLE contract ADD CONSTRAINT contract_agent FOREIGN KEY contract_agent (agent_id)
    REFERENCES agent (id);

-- Reference: contract_customer (table: contract)
ALTER TABLE contract ADD CONSTRAINT contract_customer FOREIGN KEY contract_customer (customer_id)
    REFERENCES customer (id);

-- Reference: contract_offer (table: contract)
ALTER TABLE contract ADD CONSTRAINT contract_offer FOREIGN KEY contract_offer (offer_id)
    REFERENCES offer (id);

-- Reference: hotel_city (table: hotel)
ALTER TABLE hotel ADD CONSTRAINT hotel_city FOREIGN KEY hotel_city (city_id)
    REFERENCES city (id);

-- Reference: hotel_service_hotel (table: hotel_service)
ALTER TABLE hotel_service ADD CONSTRAINT hotel_service_hotel FOREIGN KEY hotel_service_hotel (hotel_id)
    REFERENCES hotel (id);

-- Reference: hotel_service_room_type (table: hotel_service)
ALTER TABLE hotel_service ADD CONSTRAINT hotel_service_room_type FOREIGN KEY hotel_service_room_type (room_type_id)
    REFERENCES room_type (id);

-- Reference: offer_agent (table: offer)
ALTER TABLE offer ADD CONSTRAINT offer_agent FOREIGN KEY offer_agent (agent_id)
    REFERENCES agent (id);

-- Reference: offer_customer (table: offer)
ALTER TABLE offer ADD CONSTRAINT offer_customer FOREIGN KEY offer_customer (customer_id)
    REFERENCES customer (id);

-- Reference: offer_hotel_services_hotel_service (table: offer_hotel_services)
ALTER TABLE offer_hotel_services ADD CONSTRAINT offer_hotel_services_hotel_service FOREIGN KEY offer_hotel_services_hotel_service (hotel_service_id)
    REFERENCES hotel_service (id);

-- Reference: offer_promo_offer (table: offer)
ALTER TABLE offer ADD CONSTRAINT offer_promo_offer FOREIGN KEY offer_promo_offer (promo_offer_id)
    REFERENCES promo_offer (id);

-- Reference: offer_services_offer (table: offer_hotel_services)
ALTER TABLE offer_hotel_services ADD CONSTRAINT offer_services_offer FOREIGN KEY offer_services_offer (offer_id)
    REFERENCES offer (id);

-- Reference: offer_transport_services_offer (table: offer_transport_services)
ALTER TABLE offer_transport_services ADD CONSTRAINT offer_transport_services_offer FOREIGN KEY offer_transport_services_offer (offer_id)
    REFERENCES offer (id);

-- Reference: offer_transport_services_transport_service (table: offer_transport_services)
ALTER TABLE offer_transport_services ADD CONSTRAINT offer_transport_services_transport_service FOREIGN KEY offer_transport_services_transport_service (transport_service_id)
    REFERENCES transport_service (id);

-- Reference: promo_offer_hotel_services_hotel_service (table: promo_offer_hotel_services)
ALTER TABLE promo_offer_hotel_services ADD CONSTRAINT promo_offer_hotel_services_hotel_service FOREIGN KEY promo_offer_hotel_services_hotel_service (hotel_service_id)
    REFERENCES hotel_service (id);

-- Reference: promo_offer_transport_services_promo_offer (table: promo_offer_transport_services)
ALTER TABLE promo_offer_transport_services ADD CONSTRAINT promo_offer_transport_services_promo_offer FOREIGN KEY promo_offer_transport_services_promo_offer (promo_offer_id)
    REFERENCES promo_offer (id);

-- Reference: promo_offer_transport_services_transport_service (table: promo_offer_transport_services)
ALTER TABLE promo_offer_transport_services ADD CONSTRAINT promo_offer_transport_services_transport_service FOREIGN KEY promo_offer_transport_services_transport_service (transport_service_id)
    REFERENCES transport_service (id);

-- Reference: promo_services_promo_offer (table: promo_offer_hotel_services)
ALTER TABLE promo_offer_hotel_services ADD CONSTRAINT promo_services_promo_offer FOREIGN KEY promo_services_promo_offer (promo_offer_id)
    REFERENCES promo_offer (id);

-- Reference: provides_transport_company (table: transport_service)
ALTER TABLE transport_service ADD CONSTRAINT provides_transport_company FOREIGN KEY provides_transport_company (transport_company_id)
    REFERENCES transport_company (id);

-- Reference: transport_company_city (table: transport_company)
ALTER TABLE transport_company ADD CONSTRAINT transport_company_city FOREIGN KEY transport_company_city (city_id)
    REFERENCES city (id);

-- Reference: transport_company_company_type (table: transport_company)
ALTER TABLE transport_company ADD CONSTRAINT transport_company_company_type FOREIGN KEY transport_company_company_type (company_type_id)
    REFERENCES company_type (id);

-- Reference: transport_service_city_from (table: transport_service)
ALTER TABLE transport_service ADD CONSTRAINT transport_service_city_from FOREIGN KEY transport_service_city_from (from_city_id)
    REFERENCES city (id);

-- Reference: transport_service_city_to (table: transport_service)
ALTER TABLE transport_service ADD CONSTRAINT transport_service_city_to FOREIGN KEY transport_service_city_to (to_city_id)
    REFERENCES city (id);

-- Reference: transport_service_ticket_type (table: transport_service)
ALTER TABLE transport_service ADD CONSTRAINT transport_service_ticket_type FOREIGN KEY transport_service_ticket_type (ticket_type_id)
    REFERENCES ticket_type (id);

-- End of file.


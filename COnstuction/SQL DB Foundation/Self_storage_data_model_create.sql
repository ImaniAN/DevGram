-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:06:38.542

-- tables
-- Table: auction
CREATE TABLE auction (
    id int NOT NULL AUTO_INCREMENT,
    auction_code varchar(32) NOT NULL,
    start_time timestamp NOT NULL,
    storage_facility_id int NOT NULL,
    auction_details text NULL,
    CONSTRAINT auction_pk PRIMARY KEY (id)
);

-- Table: city
CREATE TABLE city (
    id int NOT NULL AUTO_INCREMENT,
    city_name varchar(128) NOT NULL,
    country_id int NOT NULL,
    postal_code varchar(16) NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (id)
);

-- Table: contract
CREATE TABLE contract (
    id int NOT NULL AUTO_INCREMENT,
    renter_id int NOT NULL,
    contract_code varchar(32) NOT NULL,
    date_signed date NOT NULL,
    contract_details text NULL,
    interval_id int NOT NULL,
    discount_percentage decimal(5,2) NOT NULL,
    UNIQUE INDEX contract_ak_1 (contract_code),
    CONSTRAINT contract_pk PRIMARY KEY (id)
);

-- Table: country
CREATE TABLE country (
    id int NOT NULL AUTO_INCREMENT,
    country_name varchar(128) NOT NULL,
    UNIQUE INDEX country_ak_1 (country_name),
    CONSTRAINT country_pk PRIMARY KEY (id)
);

-- Table: interval
CREATE TABLE `interval` (
    id int NOT NULL AUTO_INCREMENT,
    interval_name varchar(32) NOT NULL,
    daily bool NOT NULL COMMENT 'is invoice generated daily?',
    weekly bool NOT NULL COMMENT 'is invoice generated weekly?',
    monthly bool NOT NULL COMMENT 'is invoice generated monthly?',
    yearly bool NOT NULL COMMENT 'is invoice generated yearly?',
    `interval` int NOT NULL COMMENT 'number of days/weeks/months/years after which the invoice is generated',
    UNIQUE INDEX interval_ak_1 (interval_name),
    CONSTRAINT interval_pk PRIMARY KEY (id)
) COMMENT 'intervals when invoices are generated (weekly, monthly, quarterly)';

-- Table: invoice
CREATE TABLE invoice (
    id int NOT NULL AUTO_INCREMENT,
    issued_by varchar(255) NOT NULL,
    issued_to varchar(255) NOT NULL,
    contract_id int NULL,
    renter_id int NULL,
    time_created timestamp NOT NULL,
    invoice_items text NOT NULL,
    invoice_amount decimal(10,2) NOT NULL,
    discount_percentage decimal(5,2) NOT NULL,
    discount decimal(10,2) NOT NULL,
    tax_percentage decimal(5,2) NOT NULL,
    tax_amount decimal(10,2) NOT NULL,
    CONSTRAINT invoice_pk PRIMARY KEY (id)
);

-- Table: on_auction
CREATE TABLE on_auction (
    id int NOT NULL AUTO_INCREMENT,
    auction_id int NOT NULL,
    storage_unit_id int NOT NULL,
    opening_bid decimal(10,2) NULL,
    highest_bid decimal(10,2) NULL,
    sold bool NOT NULL,
    details int NULL COMMENT 'e.g. reason why is not sold',
    invoice_id int NOT NULL,
    ts timestamp NOT NULL,
    UNIQUE INDEX on_auction_ak_1 (auction_id,storage_unit_id),
    CONSTRAINT on_auction_pk PRIMARY KEY (id)
);

-- Table: rental_period
CREATE TABLE rental_period (
    id int NOT NULL AUTO_INCREMENT,
    contract_id int NOT NULL,
    storage_unit_id int NOT NULL,
    period_start date NOT NULL,
    period_end date NULL,
    price_per_day decimal(10,2) NOT NULL,
    CONSTRAINT rental_period_pk PRIMARY KEY (id)
);

-- Table: renter
CREATE TABLE renter (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(64) NULL,
    last_name varchar(64) NULL,
    company_name varchar(128) NULL,
    full_name varchar(255) NOT NULL,
    phone varchar(64) NOT NULL,
    mobile varchar(64) NOT NULL,
    email varchar(255) NOT NULL,
    CONSTRAINT renter_pk PRIMARY KEY (id)
);

-- Table: status
CREATE TABLE status (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(32) NOT NULL,
    occupied bool NOT NULL COMMENT 'is unit with this status currently occupied or not',
    UNIQUE INDEX status_ak_1 (status_name),
    CONSTRAINT status_pk PRIMARY KEY (id)
) COMMENT 'list of all possible statuse that could be assigned to a unit';

-- Table: status_history
CREATE TABLE status_history (
    id int NOT NULL AUTO_INCREMENT,
    storage_unit_id int NOT NULL,
    status_id int NOT NULL,
    start_date date NOT NULL,
    end_date date NULL,
    CONSTRAINT status_history_pk PRIMARY KEY (id)
);

-- Table: storage_facility
CREATE TABLE storage_facility (
    id int NOT NULL AUTO_INCREMENT,
    city_id int NOT NULL,
    facility_code varchar(32) NOT NULL,
    facility_name varchar(255) NOT NULL,
    address varchar(255) NOT NULL,
    capacity int NOT NULL COMMENT 'number of lockers',
    UNIQUE INDEX storage_facility_ak_1 (facility_code),
    CONSTRAINT storage_facility_pk PRIMARY KEY (id)
);

-- Table: storage_unit
CREATE TABLE storage_unit (
    id int NOT NULL AUTO_INCREMENT,
    unit_code varchar(32) NOT NULL,
    storage_facility_id int NOT NULL,
    storage_unit_type_id int NOT NULL,
    location text NOT NULL COMMENT 'e.g section A at the end of the hall',
    current_status_id int NOT NULL,
    price_per_day decimal(10,2) NOT NULL,
    UNIQUE INDEX storage_unit_ak_1 (unit_code,storage_facility_id),
    CONSTRAINT storage_unit_pk PRIMARY KEY (id)
);

-- Table: storage_unit_type
CREATE TABLE storage_unit_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(64) NOT NULL,
    length decimal(6,2) NOT NULL,
    width decimal(6,2) NOT NULL,
    height decimal(6,2) NOT NULL,
    description text NOT NULL,
    UNIQUE INDEX storage_unit_type_ak_1 (type_name),
    CONSTRAINT storage_unit_type_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: auction_storage_facility (table: auction)
ALTER TABLE auction ADD CONSTRAINT auction_storage_facility FOREIGN KEY auction_storage_facility (storage_facility_id)
    REFERENCES storage_facility (id);

-- Reference: city_country (table: city)
ALTER TABLE city ADD CONSTRAINT city_country FOREIGN KEY city_country (country_id)
    REFERENCES country (id);

-- Reference: contract_interval (table: contract)
ALTER TABLE contract ADD CONSTRAINT contract_interval FOREIGN KEY contract_interval (interval_id)
    REFERENCES `interval` (id);

-- Reference: contract_renter (table: contract)
ALTER TABLE contract ADD CONSTRAINT contract_renter FOREIGN KEY contract_renter (renter_id)
    REFERENCES renter (id);

-- Reference: invoice_contract (table: invoice)
ALTER TABLE invoice ADD CONSTRAINT invoice_contract FOREIGN KEY invoice_contract (contract_id)
    REFERENCES contract (id);

-- Reference: invoice_renter (table: invoice)
ALTER TABLE invoice ADD CONSTRAINT invoice_renter FOREIGN KEY invoice_renter (renter_id)
    REFERENCES renter (id);

-- Reference: on_auction_auction (table: on_auction)
ALTER TABLE on_auction ADD CONSTRAINT on_auction_auction FOREIGN KEY on_auction_auction (auction_id)
    REFERENCES auction (id);

-- Reference: on_auction_invoice (table: on_auction)
ALTER TABLE on_auction ADD CONSTRAINT on_auction_invoice FOREIGN KEY on_auction_invoice (invoice_id)
    REFERENCES invoice (id);

-- Reference: on_auction_storage_unit (table: on_auction)
ALTER TABLE on_auction ADD CONSTRAINT on_auction_storage_unit FOREIGN KEY on_auction_storage_unit (storage_unit_id)
    REFERENCES storage_unit (id);

-- Reference: rental_period_contract (table: rental_period)
ALTER TABLE rental_period ADD CONSTRAINT rental_period_contract FOREIGN KEY rental_period_contract (contract_id)
    REFERENCES contract (id);

-- Reference: rental_period_storage_unit (table: rental_period)
ALTER TABLE rental_period ADD CONSTRAINT rental_period_storage_unit FOREIGN KEY rental_period_storage_unit (storage_unit_id)
    REFERENCES storage_unit (id);

-- Reference: status_history_status (table: status_history)
ALTER TABLE status_history ADD CONSTRAINT status_history_status FOREIGN KEY status_history_status (status_id)
    REFERENCES status (id);

-- Reference: status_history_storage_unit (table: status_history)
ALTER TABLE status_history ADD CONSTRAINT status_history_storage_unit FOREIGN KEY status_history_storage_unit (storage_unit_id)
    REFERENCES storage_unit (id);

-- Reference: storage_facility_city (table: storage_facility)
ALTER TABLE storage_facility ADD CONSTRAINT storage_facility_city FOREIGN KEY storage_facility_city (city_id)
    REFERENCES city (id);

-- Reference: storage_unit_status (table: storage_unit)
ALTER TABLE storage_unit ADD CONSTRAINT storage_unit_status FOREIGN KEY storage_unit_status (current_status_id)
    REFERENCES status (id);

-- Reference: storage_unit_storage_facility (table: storage_unit)
ALTER TABLE storage_unit ADD CONSTRAINT storage_unit_storage_facility FOREIGN KEY storage_unit_storage_facility (storage_facility_id)
    REFERENCES storage_facility (id);

-- Reference: storage_unit_storage_unit_type (table: storage_unit)
ALTER TABLE storage_unit ADD CONSTRAINT storage_unit_storage_unit_type FOREIGN KEY storage_unit_storage_unit_type (storage_unit_type_id)
    REFERENCES storage_unit_type (id);

-- End of file.


-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:08:18.176

-- tables
-- Table: city
CREATE TABLE city (
    id int NOT NULL AUTO_INCREMENT,
    city_name varchar(128) NOT NULL,
    country_id int NOT NULL,
    UNIQUE INDEX city_ak_1 (city_name,country_id),
    CONSTRAINT city_pk PRIMARY KEY (id)
);

-- Table: client
CREATE TABLE client (
    id int NOT NULL AUTO_INCREMENT,
    client_name varchar(255) NOT NULL,
    client_address varchar(255) NOT NULL,
    contact_person varchar(255) NULL,
    phone varchar(64) NULL,
    mobile varchar(64) NULL,
    mail varchar(64) NULL,
    client_details text NULL,
    CONSTRAINT client_pk PRIMARY KEY (id)
);

-- Table: contact
CREATE TABLE contact (
    id int NOT NULL AUTO_INCREMENT,
    client_id int NOT NULL,
    employee_id int NULL,
    estate_id int NULL,
    contact_time timestamp NOT NULL,
    contact_details text NOT NULL,
    CONSTRAINT contact_pk PRIMARY KEY (id)
) COMMENT 'list of all contacts with clients';

-- Table: contract
CREATE TABLE contract (
    id int NOT NULL AUTO_INCREMENT,
    client_id int NOT NULL,
    employee_id int NOT NULL,
    contract_type_id int NOT NULL,
    contract_details text NOT NULL,
    payment_frequency_id int NOT NULL,
    number_of_invoices int NOT NULL,
    payment_amount decimal(10,2) NULL COMMENT 'rate amount',
    fee_precentage decimal(5,2) NOT NULL,
    fee_amount decimal(10,2) NULL,
    date_signed date NOT NULL,
    start_date date NOT NULL COMMENT 'date from which contract becomes valid',
    end_date date NULL COMMENT 'date when contract ends; in case of selling an estate end_date is the same as the start_date',
    transaction_id int NULL,
    CONSTRAINT contract_pk PRIMARY KEY (id)
);

-- Table: contract_invoice
CREATE TABLE contract_invoice (
    id int NOT NULL AUTO_INCREMENT,
    contract_id int NOT NULL,
    invoice_number varchar(64) NOT NULL,
    issued_by text NOT NULL,
    issued_to text NOT NULL COMMENT 'client',
    invoice_details text NOT NULL COMMENT 'list of invoice items',
    invoice_amount decimal(10,2) NOT NULL,
    date_created date NOT NULL,
    billing_date date NOT NULL,
    date_paid date NULL,
    UNIQUE INDEX contract_invoice_ak_1 (invoice_number),
    CONSTRAINT contract_invoice_pk PRIMARY KEY (id)
);

-- Table: contract_type
CREATE TABLE contract_type (
    id int NOT NULL AUTO_INCREMENT,
    contract_type_name varchar(64) NOT NULL,
    fee_precentage decimal(5,2) NOT NULL,
    UNIQUE INDEX contract_type_ak_1 (contract_type_name),
    CONSTRAINT contract_type_pk PRIMARY KEY (id)
) COMMENT 'selling (to a customer), renting (to a customer)';

-- Table: country
CREATE TABLE country (
    id int NOT NULL AUTO_INCREMENT,
    country_name varchar(128) NOT NULL,
    UNIQUE INDEX country_ak_1 (country_name),
    CONSTRAINT country_pk PRIMARY KEY (id)
);

-- Table: employee
CREATE TABLE employee (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    CONSTRAINT employee_pk PRIMARY KEY (id)
);

-- Table: estate
CREATE TABLE estate (
    id int NOT NULL AUTO_INCREMENT,
    estate_name varchar(255) NOT NULL,
    city_id int NOT NULL,
    estate_type_id int NOT NULL,
    floor_space decimal(8,2) NULL COMMENT 'in m2',
    number_of_balconies int NULL,
    balconies_space decimal(8,2) NULL COMMENT 'in m2',
    number_of_bedrooms int NULL,
    number_of_bathrooms int NULL,
    number_of_garages int NULL,
    number_of_parking_spaces int NULL,
    pets_allowed bool NULL,
    estate_description text NOT NULL,
    estate_status_id int NOT NULL,
    CONSTRAINT estate_pk PRIMARY KEY (id)
);

-- Table: estate_status
CREATE TABLE estate_status (
    id int NOT NULL AUTO_INCREMENT,
    estate_status_name varchar(64) NOT NULL,
    UNIQUE INDEX estate_status_ak_1 (estate_status_name),
    CONSTRAINT estate_status_pk PRIMARY KEY (id)
) COMMENT 'is estate available or not (e.g. available, sold...), ';

-- Table: estate_type
CREATE TABLE estate_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(128) NOT NULL,
    UNIQUE INDEX estate_type_ak_1 (type_name),
    CONSTRAINT estate_type_pk PRIMARY KEY (id)
);

-- Table: in_charge
CREATE TABLE in_charge (
    id int NOT NULL AUTO_INCREMENT,
    estate_id int NOT NULL,
    employee_id int NOT NULL,
    date_from date NOT NULL,
    date_to date NULL,
    CONSTRAINT in_charge_pk PRIMARY KEY (id)
);

-- Table: payment_frequency
CREATE TABLE payment_frequency (
    id int NOT NULL AUTO_INCREMENT,
    payment_frequency_name varchar(64) NOT NULL,
    UNIQUE INDEX payment_frequency_ak_1 (payment_frequency_name),
    CONSTRAINT payment_frequency_pk PRIMARY KEY (id)
) COMMENT 'e.g. once, once per month, once per year';

-- Table: transaction
CREATE TABLE transaction (
    id int NOT NULL AUTO_INCREMENT,
    transaction_type_id int NOT NULL,
    client_offered int NOT NULL,
    client_requested int NOT NULL,
    transaction_date date NOT NULL,
    transaction_details text NOT NULL,
    CONSTRAINT transaction_pk PRIMARY KEY (id)
);

-- Table: transaction_type
CREATE TABLE transaction_type (
    id int NOT NULL AUTO_INCREMENT,
    transaction_type_name varchar(64) NOT NULL,
    UNIQUE INDEX transaction_type_ak_1 (transaction_type_name),
    CONSTRAINT transaction_type_pk PRIMARY KEY (id)
) COMMENT 'buying/selling or renting/leasing';

-- Table: under_contract
CREATE TABLE under_contract (
    id int NOT NULL AUTO_INCREMENT,
    estate_id int NOT NULL,
    contract_id int NOT NULL,
    UNIQUE INDEX under_contract_ak_1 (estate_id,contract_id),
    CONSTRAINT under_contract_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: city_country (table: city)
ALTER TABLE city ADD CONSTRAINT city_country FOREIGN KEY city_country (country_id)
    REFERENCES country (id);

-- Reference: contact_client (table: contact)
ALTER TABLE contact ADD CONSTRAINT contact_client FOREIGN KEY contact_client (client_id)
    REFERENCES client (id);

-- Reference: contact_employee (table: contact)
ALTER TABLE contact ADD CONSTRAINT contact_employee FOREIGN KEY contact_employee (employee_id)
    REFERENCES employee (id);

-- Reference: contact_estate (table: contact)
ALTER TABLE contact ADD CONSTRAINT contact_estate FOREIGN KEY contact_estate (estate_id)
    REFERENCES estate (id);

-- Reference: contract_client (table: contract)
ALTER TABLE contract ADD CONSTRAINT contract_client FOREIGN KEY contract_client (client_id)
    REFERENCES client (id);

-- Reference: contract_contract_type (table: contract)
ALTER TABLE contract ADD CONSTRAINT contract_contract_type FOREIGN KEY contract_contract_type (contract_type_id)
    REFERENCES contract_type (id);

-- Reference: contract_employee (table: contract)
ALTER TABLE contract ADD CONSTRAINT contract_employee FOREIGN KEY contract_employee (employee_id)
    REFERENCES employee (id);

-- Reference: contract_payment_frequency (table: contract)
ALTER TABLE contract ADD CONSTRAINT contract_payment_frequency FOREIGN KEY contract_payment_frequency (payment_frequency_id)
    REFERENCES payment_frequency (id);

-- Reference: contract_transaction (table: contract)
ALTER TABLE contract ADD CONSTRAINT contract_transaction FOREIGN KEY contract_transaction (transaction_id)
    REFERENCES transaction (id);

-- Reference: estate_city (table: estate)
ALTER TABLE estate ADD CONSTRAINT estate_city FOREIGN KEY estate_city (city_id)
    REFERENCES city (id);

-- Reference: estate_estate_status (table: estate)
ALTER TABLE estate ADD CONSTRAINT estate_estate_status FOREIGN KEY estate_estate_status (estate_status_id)
    REFERENCES estate_status (id);

-- Reference: estate_estate_type (table: estate)
ALTER TABLE estate ADD CONSTRAINT estate_estate_type FOREIGN KEY estate_estate_type (estate_type_id)
    REFERENCES estate_type (id);

-- Reference: in_charge_employee (table: in_charge)
ALTER TABLE in_charge ADD CONSTRAINT in_charge_employee FOREIGN KEY in_charge_employee (employee_id)
    REFERENCES employee (id);

-- Reference: in_charge_estate (table: in_charge)
ALTER TABLE in_charge ADD CONSTRAINT in_charge_estate FOREIGN KEY in_charge_estate (estate_id)
    REFERENCES estate (id);

-- Reference: invoice_contract (table: contract_invoice)
ALTER TABLE contract_invoice ADD CONSTRAINT invoice_contract FOREIGN KEY invoice_contract (contract_id)
    REFERENCES contract (id);

-- Reference: transaction_client1 (table: transaction)
ALTER TABLE transaction ADD CONSTRAINT transaction_client1 FOREIGN KEY transaction_client1 (client_offered)
    REFERENCES client (id);

-- Reference: transaction_client2 (table: transaction)
ALTER TABLE transaction ADD CONSTRAINT transaction_client2 FOREIGN KEY transaction_client2 (client_requested)
    REFERENCES client (id);

-- Reference: transaction_transaction_type (table: transaction)
ALTER TABLE transaction ADD CONSTRAINT transaction_transaction_type FOREIGN KEY transaction_transaction_type (transaction_type_id)
    REFERENCES transaction_type (id);

-- Reference: under_contract_contract (table: under_contract)
ALTER TABLE under_contract ADD CONSTRAINT under_contract_contract FOREIGN KEY under_contract_contract (contract_id)
    REFERENCES contract (id);

-- Reference: under_contract_estate (table: under_contract)
ALTER TABLE under_contract ADD CONSTRAINT under_contract_estate FOREIGN KEY under_contract_estate (estate_id)
    REFERENCES estate (id);

-- End of file.


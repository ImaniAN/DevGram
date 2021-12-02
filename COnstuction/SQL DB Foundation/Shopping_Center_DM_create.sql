-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:02:35.815

-- tables
-- Table: billing_frequency
CREATE TABLE billing_frequency (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    UNIQUE INDEX billing_frequency_ak_1 (name),
    CONSTRAINT billing_frequency_pk PRIMARY KEY (id)
) COMMENT 'intervals when invoices will be generated (e.g. daily, weekly, monthly)';

-- Table: company
CREATE TABLE company (
    id int NOT NULL AUTO_INCREMENT,
    company_code varchar(8) NOT NULL,
    company_name varchar(255) NOT NULL,
    address varchar(255) NULL,
    contact_person varchar(128) NULL,
    contact_email varchar(128) NULL,
    contact_phone varchar(128) NULL,
    contact_mobile varchar(128) NULL,
    details text NULL,
    UNIQUE INDEX company_ak_1 (company_code),
    CONSTRAINT company_pk PRIMARY KEY (id)
) COMMENT 'list of all companies that: own shopping center, run shops, provide services (e.g. cleaning)';

-- Table: contract
CREATE TABLE contract (
    id int NOT NULL AUTO_INCREMENT,
    contract_code varchar(8) NOT NULL,
    contract_details text NOT NULL,
    date_signed date NOT NULL,
    date_active_from date NOT NULL,
    date_active_to date NULL COMMENT 'if NULL -> active indefinitely (e.g. sold)',
    contract_type_id int NOT NULL,
    provider_id int NOT NULL,
    customer_id int NOT NULL,
    billing_frequency_id int NOT NULL,
    billing_units int NOT NULL COMMENT 'number of units for defiled billing frequency, e.g. 1 (in combination with frequency one month would mean to generate new invoice each month)',
    first_invoice_date date NOT NULL,
    UNIQUE INDEX contract_ak_1 (contract_code),
    CONSTRAINT contract_pk PRIMARY KEY (id)
);

-- Table: contract_type
CREATE TABLE contract_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(255) NOT NULL,
    UNIQUE INDEX contract_type_ak_1 (type_name),
    CONSTRAINT contract_type_pk PRIMARY KEY (id)
) COMMENT 'e.g. sold, lease (1 year), lease (5 years)....';

-- Table: invoice
CREATE TABLE invoice (
    id int NOT NULL,
    invoice_code varchar(255) NOT NULL,
    contract_id int NOT NULL,
    issued_by_id int NOT NULL,
    issued_by text NOT NULL,
    issued_to_id int NOT NULL,
    issued_to text NOT NULL,
    invoice_amount decimal(10,2) NOT NULL,
    fee decimal(10,2) NOT NULL,
    discount decimal(10,2) NOT NULL,
    tax decimal(10,2) NOT NULL,
    total_amount decimal(10,2) NOT NULL,
    invoice_serial int NOT NULL COMMENT 'serial number of that invoice on that contract',
    time_created timestamp NOT NULL,
    date_issued date NOT NULL,
    date_paid date NULL,
    amount_refunded decimal(10,2) NOT NULL,
    invoice_details text NOT NULL,
    UNIQUE INDEX invoice_ak_1 (invoice_code),
    CONSTRAINT invoice_pk PRIMARY KEY (id)
);

-- Table: service
CREATE TABLE service (
    id int NOT NULL AUTO_INCREMENT,
    service_type varchar(255) NOT NULL,
    UNIQUE INDEX service_ak_1 (service_type),
    CONSTRAINT service_pk PRIMARY KEY (id)
);

-- Table: service_on_contract
CREATE TABLE service_on_contract (
    id int NOT NULL AUTO_INCREMENT,
    contract_id int NOT NULL,
    service_id int NOT NULL,
    details text NULL,
    shopping_center_id int NULL,
    shop_id int NULL,
    CONSTRAINT service_on_contract_pk PRIMARY KEY (id)
) COMMENT 'list of all services related with contracts and shopping centers/shops';

-- Table: shop
CREATE TABLE shop (
    id int NOT NULL AUTO_INCREMENT,
    shop_code varchar(8) NOT NULL,
    shop_name varchar(255) NOT NULL,
    shopping_center_id int NOT NULL,
    floor varchar(8) NOT NULL,
    position text NOT NULL,
    description text NOT NULL,
    active_from date NOT NULL,
    active_to date NULL COMMENT 'if NULL -> active indefinitely',
    active bool NOT NULL,
    UNIQUE INDEX shop_ak_1 (shop_code),
    CONSTRAINT shop_pk PRIMARY KEY (id)
) COMMENT 'list of all "shops" in a center';

-- Table: shop_on_contract
CREATE TABLE shop_on_contract (
    id int NOT NULL AUTO_INCREMENT,
    contract_id int NOT NULL,
    shop_id int NOT NULL,
    details text NULL,
    UNIQUE INDEX on_contract_ak_1 (contract_id,shop_id),
    CONSTRAINT shop_on_contract_pk PRIMARY KEY (id)
) COMMENT 'list of all shops related with contracts';

-- Table: shopping_center
CREATE TABLE shopping_center (
    id int NOT NULL AUTO_INCREMENT,
    code varchar(8) NOT NULL,
    name varchar(255) NOT NULL,
    address varchar(255) NOT NULL,
    details text NOT NULL,
    UNIQUE INDEX shopping_center_ak_1 (code),
    CONSTRAINT shopping_center_pk PRIMARY KEY (id)
) COMMENT 'list of all shopping centers we run';

-- foreign keys
-- Reference: contract_billing_frequency (table: contract)
ALTER TABLE contract ADD CONSTRAINT contract_billing_frequency FOREIGN KEY contract_billing_frequency (billing_frequency_id)
    REFERENCES billing_frequency (id);

-- Reference: contract_company_customer (table: contract)
ALTER TABLE contract ADD CONSTRAINT contract_company_customer FOREIGN KEY contract_company_customer (provider_id)
    REFERENCES company (id);

-- Reference: contract_company_provider (table: contract)
ALTER TABLE contract ADD CONSTRAINT contract_company_provider FOREIGN KEY contract_company_provider (customer_id)
    REFERENCES company (id);

-- Reference: contract_contract_type (table: contract)
ALTER TABLE contract ADD CONSTRAINT contract_contract_type FOREIGN KEY contract_contract_type (contract_type_id)
    REFERENCES contract_type (id);

-- Reference: invoice_company_by (table: invoice)
ALTER TABLE invoice ADD CONSTRAINT invoice_company_by FOREIGN KEY invoice_company_by (issued_by_id)
    REFERENCES company (id);

-- Reference: invoice_company_to (table: invoice)
ALTER TABLE invoice ADD CONSTRAINT invoice_company_to FOREIGN KEY invoice_company_to (issued_to_id)
    REFERENCES company (id);

-- Reference: invoice_contract (table: invoice)
ALTER TABLE invoice ADD CONSTRAINT invoice_contract FOREIGN KEY invoice_contract (contract_id)
    REFERENCES contract (id);

-- Reference: on_contract_contract (table: shop_on_contract)
ALTER TABLE shop_on_contract ADD CONSTRAINT on_contract_contract FOREIGN KEY on_contract_contract (contract_id)
    REFERENCES contract (id);

-- Reference: on_contract_shop (table: shop_on_contract)
ALTER TABLE shop_on_contract ADD CONSTRAINT on_contract_shop FOREIGN KEY on_contract_shop (shop_id)
    REFERENCES shop (id);

-- Reference: service_on_contract_contract (table: service_on_contract)
ALTER TABLE service_on_contract ADD CONSTRAINT service_on_contract_contract FOREIGN KEY service_on_contract_contract (contract_id)
    REFERENCES contract (id);

-- Reference: service_on_contract_service (table: service_on_contract)
ALTER TABLE service_on_contract ADD CONSTRAINT service_on_contract_service FOREIGN KEY service_on_contract_service (service_id)
    REFERENCES service (id);

-- Reference: service_on_contract_shop (table: service_on_contract)
ALTER TABLE service_on_contract ADD CONSTRAINT service_on_contract_shop FOREIGN KEY service_on_contract_shop (shop_id)
    REFERENCES shop (id);

-- Reference: service_on_contract_shopping_center (table: service_on_contract)
ALTER TABLE service_on_contract ADD CONSTRAINT service_on_contract_shopping_center FOREIGN KEY service_on_contract_shopping_center (shopping_center_id)
    REFERENCES shopping_center (id);

-- Reference: shop_shopping_center (table: shop)
ALTER TABLE shop ADD CONSTRAINT shop_shopping_center FOREIGN KEY shop_shopping_center (shopping_center_id)
    REFERENCES shopping_center (id);

-- End of file.


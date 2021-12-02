-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:02:49.177

-- tables
-- Table: advertising
CREATE TABLE advertising (
    id int NOT NULL AUTO_INCREMENT,
    campaign_id int NOT NULL,
    advertising_type_id int NOT NULL,
    planned_start_time timestamp NOT NULL,
    planned_end_time timestamp NOT NULL,
    start_time timestamp NULL,
    end_time timestamp NULL,
    details text NULL,
    funds_planned decimal(10,2) NOT NULL,
    actual_costs decimal(10,2) NULL,
    employee_id int NOT NULL COMMENT 'employee in charge of this advertising',
    CONSTRAINT advertising_pk PRIMARY KEY (id)
);

-- Table: advertising_contract
CREATE TABLE advertising_contract (
    id int NOT NULL,
    advertising_partner_id int NOT NULL,
    contract_id int NOT NULL,
    UNIQUE INDEX advertising_contract_ak_1 (advertising_partner_id,contract_id),
    CONSTRAINT advertising_contract_pk PRIMARY KEY (id)
);

-- Table: advertising_partner
CREATE TABLE advertising_partner (
    id int NOT NULL AUTO_INCREMENT,
    advertising_id int NOT NULL,
    partner_id int NOT NULL,
    details text NULL,
    UNIQUE INDEX advertising_partner_ak_1 (advertising_id,partner_id),
    CONSTRAINT advertising_partner_pk PRIMARY KEY (id)
);

-- Table: advertising_type
CREATE TABLE advertising_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(64) NOT NULL,
    UNIQUE INDEX advertising_type_ak_1 (type_name),
    CONSTRAINT advertising_type_pk PRIMARY KEY (id)
) COMMENT 'e.g. newspapers adds, tv campaign, online marketing, social media campaign';

-- Table: agency
CREATE TABLE agency (
    id int NOT NULL AUTO_INCREMENT,
    agency_name varchar(255) NOT NULL,
    UNIQUE INDEX agency_ak_1 (agency_name),
    CONSTRAINT agency_pk PRIMARY KEY (id)
);

-- Table: campaign
CREATE TABLE campaign (
    id int NOT NULL AUTO_INCREMENT,
    campaign_code varchar(32) NOT NULL,
    contract_id int NOT NULL,
    description text NOT NULL,
    current_status int NOT NULL,
    employee_id int NOT NULL COMMENT 'employee in charge of this campaign',
    UNIQUE INDEX campaign_ak_1 (campaign_code),
    CONSTRAINT campaign_pk PRIMARY KEY (id)
);

-- Table: client
CREATE TABLE client (
    id int NOT NULL AUTO_INCREMENT,
    client_code varchar(32) NOT NULL,
    client_name varchar(255) NOT NULL,
    address varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    phone varchar(255) NULL,
    mobile varchar(255) NULL,
    contact_person varchar(255) NULL,
    UNIQUE INDEX client_ak_1 (client_code),
    CONSTRAINT client_pk PRIMARY KEY (id)
);

-- Table: contract
CREATE TABLE contract (
    id int NOT NULL AUTO_INCREMENT,
    contract_code varchar(32) NOT NULL,
    document_location text NOT NULL,
    details text NULL,
    agency_id int NOT NULL,
    client_id int NOT NULL,
    date_signed date NOT NULL,
    valid_from date NOT NULL,
    valid_to date NULL COMMENT 'if NULL -> inmdefenitely',
    UNIQUE INDEX contract_ak_1 (contract_code),
    CONSTRAINT contract_pk PRIMARY KEY (id)
);

-- Table: employee
CREATE TABLE employee (
    id int NOT NULL AUTO_INCREMENT,
    employee_code varchar(32) NOT NULL,
    agency_id int NOT NULL,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    UNIQUE INDEX employee_ak_1 (employee_code,agency_id),
    CONSTRAINT employee_pk PRIMARY KEY (id)
);

-- Table: partner
CREATE TABLE partner (
    id int NOT NULL AUTO_INCREMENT,
    partner_code varchar(32) NOT NULL,
    partner_name varchar(255) NOT NULL,
    contract_id int NOT NULL,
    UNIQUE INDEX partner_ak_1 (partner_code),
    CONSTRAINT partner_pk PRIMARY KEY (id)
) COMMENT 'list of all partners our agency works with';

-- Table: product
CREATE TABLE product (
    id int NOT NULL AUTO_INCREMENT,
    campaign_id int NOT NULL,
    product_type_id int NOT NULL,
    planned_start_time timestamp NOT NULL,
    planned_end_time timestamp NOT NULL,
    start_time timestamp NULL,
    end_time timestamp NULL,
    details text NOT NULL,
    funds_planned decimal(10,2) NOT NULL,
    actual_cost decimal(10,2) NULL,
    employee_id int NOT NULL COMMENT 'employee in charge of this product',
    product_link text NULL,
    CONSTRAINT product_pk PRIMARY KEY (id)
);

-- Table: product_contract
CREATE TABLE product_contract (
    id int NOT NULL AUTO_INCREMENT,
    product_partner_id int NOT NULL,
    contract_id int NOT NULL,
    UNIQUE INDEX product_contract_ak_1 (product_partner_id,contract_id),
    CONSTRAINT product_contract_pk PRIMARY KEY (id)
);

-- Table: product_partner
CREATE TABLE product_partner (
    id int NOT NULL AUTO_INCREMENT,
    product_id int NOT NULL,
    partner_id int NOT NULL,
    details text NULL,
    UNIQUE INDEX product_partner_ak_1 (product_id,partner_id),
    CONSTRAINT product_partner_pk PRIMARY KEY (id)
);

-- Table: product_type
CREATE TABLE product_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(64) NOT NULL,
    UNIQUE INDEX product_type_ak_1 (type_name),
    CONSTRAINT product_type_pk PRIMARY KEY (id)
) COMMENT 'e.g. tv commercial, banner, ad design etc.';

-- Table: status_catalog
CREATE TABLE status_catalog (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(64) NOT NULL,
    is_completed bool NOT NULL COMMENT 'denotes is campaign completed or not, when assigned this status ',
    is_ok bool NOT NULL COMMENT 'denotes is everything ok with campaign',
    UNIQUE INDEX status_catalog_ak_1 (status_name),
    CONSTRAINT status_catalog_pk PRIMARY KEY (id)
);

-- Table: status_history
CREATE TABLE status_history (
    id int NOT NULL AUTO_INCREMENT,
    campaign_id int NOT NULL,
    status_catalog_id int NOT NULL,
    status_time timestamp NOT NULL,
    details text NULL,
    CONSTRAINT status_history_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: Table_8_campaign (table: product)
ALTER TABLE product ADD CONSTRAINT Table_8_campaign FOREIGN KEY Table_8_campaign (campaign_id)
    REFERENCES campaign (id);

-- Reference: advertising_advertising_type (table: advertising)
ALTER TABLE advertising ADD CONSTRAINT advertising_advertising_type FOREIGN KEY advertising_advertising_type (advertising_type_id)
    REFERENCES advertising_type (id);

-- Reference: advertising_campaign (table: advertising)
ALTER TABLE advertising ADD CONSTRAINT advertising_campaign FOREIGN KEY advertising_campaign (campaign_id)
    REFERENCES campaign (id);

-- Reference: advertising_contract_advertising_partner (table: advertising_contract)
ALTER TABLE advertising_contract ADD CONSTRAINT advertising_contract_advertising_partner FOREIGN KEY advertising_contract_advertising_partner (advertising_partner_id)
    REFERENCES advertising_partner (id);

-- Reference: advertising_contract_contract (table: advertising_contract)
ALTER TABLE advertising_contract ADD CONSTRAINT advertising_contract_contract FOREIGN KEY advertising_contract_contract (contract_id)
    REFERENCES contract (id);

-- Reference: advertising_employee (table: advertising)
ALTER TABLE advertising ADD CONSTRAINT advertising_employee FOREIGN KEY advertising_employee (employee_id)
    REFERENCES employee (id);

-- Reference: advertising_partner_advertising (table: advertising_partner)
ALTER TABLE advertising_partner ADD CONSTRAINT advertising_partner_advertising FOREIGN KEY advertising_partner_advertising (advertising_id)
    REFERENCES advertising (id);

-- Reference: advertising_partner_partner (table: advertising_partner)
ALTER TABLE advertising_partner ADD CONSTRAINT advertising_partner_partner FOREIGN KEY advertising_partner_partner (partner_id)
    REFERENCES partner (id);

-- Reference: campaign_contract (table: campaign)
ALTER TABLE campaign ADD CONSTRAINT campaign_contract FOREIGN KEY campaign_contract (contract_id)
    REFERENCES contract (id);

-- Reference: campaign_employee (table: campaign)
ALTER TABLE campaign ADD CONSTRAINT campaign_employee FOREIGN KEY campaign_employee (employee_id)
    REFERENCES employee (id);

-- Reference: campaign_status_catalog (table: campaign)
ALTER TABLE campaign ADD CONSTRAINT campaign_status_catalog FOREIGN KEY campaign_status_catalog (current_status)
    REFERENCES status_catalog (id);

-- Reference: contract_agency (table: contract)
ALTER TABLE contract ADD CONSTRAINT contract_agency FOREIGN KEY contract_agency (agency_id)
    REFERENCES agency (id);

-- Reference: contract_client (table: contract)
ALTER TABLE contract ADD CONSTRAINT contract_client FOREIGN KEY contract_client (client_id)
    REFERENCES client (id);

-- Reference: employee_agency (table: employee)
ALTER TABLE employee ADD CONSTRAINT employee_agency FOREIGN KEY employee_agency (agency_id)
    REFERENCES agency (id);

-- Reference: partner_contract (table: partner)
ALTER TABLE partner ADD CONSTRAINT partner_contract FOREIGN KEY partner_contract (contract_id)
    REFERENCES contract (id);

-- Reference: product_contract_contract (table: product_contract)
ALTER TABLE product_contract ADD CONSTRAINT product_contract_contract FOREIGN KEY product_contract_contract (contract_id)
    REFERENCES contract (id);

-- Reference: product_contract_product_partner (table: product_contract)
ALTER TABLE product_contract ADD CONSTRAINT product_contract_product_partner FOREIGN KEY product_contract_product_partner (product_partner_id)
    REFERENCES product_partner (id);

-- Reference: product_employee (table: product)
ALTER TABLE product ADD CONSTRAINT product_employee FOREIGN KEY product_employee (employee_id)
    REFERENCES employee (id);

-- Reference: product_partner_partner (table: product_partner)
ALTER TABLE product_partner ADD CONSTRAINT product_partner_partner FOREIGN KEY product_partner_partner (partner_id)
    REFERENCES partner (id);

-- Reference: product_partner_product (table: product_partner)
ALTER TABLE product_partner ADD CONSTRAINT product_partner_product FOREIGN KEY product_partner_product (product_id)
    REFERENCES product (id);

-- Reference: product_product_type (table: product)
ALTER TABLE product ADD CONSTRAINT product_product_type FOREIGN KEY product_product_type (product_type_id)
    REFERENCES product_type (id);

-- Reference: status_history_campaign (table: status_history)
ALTER TABLE status_history ADD CONSTRAINT status_history_campaign FOREIGN KEY status_history_campaign (campaign_id)
    REFERENCES campaign (id);

-- Reference: status_history_status_catalog (table: status_history)
ALTER TABLE status_history ADD CONSTRAINT status_history_status_catalog FOREIGN KEY status_history_status_catalog (status_catalog_id)
    REFERENCES status_catalog (id);

-- End of file.


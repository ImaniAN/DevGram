-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:56:36.232

-- tables
-- Table: city
CREATE TABLE city (
    id int NOT NULL AUTO_INCREMENT,
    postal_code varchar(16) NOT NULL,
    city_name varchar(128) NOT NULL,
    country_id int NOT NULL,
    UNIQUE INDEX city_ak_1 (postal_code,city_name,country_id),
    CONSTRAINT city_pk PRIMARY KEY (id)
);

-- Table: country
CREATE TABLE country (
    id int NOT NULL AUTO_INCREMENT,
    country_name varchar(128) NOT NULL,
    UNIQUE INDEX country_ak_1 (country_name),
    CONSTRAINT country_pk PRIMARY KEY (id)
);

-- Table: document
CREATE TABLE document (
    id int NOT NULL AUTO_INCREMENT,
    document_location text NOT NULL,
    document_type_id int NOT NULL,
    user_account_id int NULL,
    property_id int NULL,
    is_active bool NOT NULL,
    UNIQUE INDEX document_ak_1 (document_location),
    CONSTRAINT document_pk PRIMARY KEY (id)
);

-- Table: document_type
CREATE TABLE document_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(128) NOT NULL,
    UNIQUE INDEX document_type_ak_1 (type_name),
    CONSTRAINT document_type_pk PRIMARY KEY (id)
);

-- Table: has_role
CREATE TABLE has_role (
    id int NOT NULL AUTO_INCREMENT,
    user_account_id int NOT NULL,
    role_id int NOT NULL,
    time_from timestamp NOT NULL,
    time_to timestamp NULL,
    is_active int NOT NULL,
    UNIQUE INDEX has_role_ak_1 (user_account_id,role_id,time_from),
    CONSTRAINT has_role_pk PRIMARY KEY (id)
);

-- Table: invoice
CREATE TABLE invoice (
    id int NOT NULL AUTO_INCREMENT,
    customer_name varchar(255) NOT NULL,
    provided_service_id int NOT NULL,
    total_amount decimal(10,2) NOT NULL,
    fee_amount decimal(10,2) NOT NULL,
    time_issued timestamp NOT NULL,
    time_paid timestamp NULL,
    paid bool NOT NULL,
    UNIQUE INDEX invoice_ak_1 (provided_service_id),
    CONSTRAINT invoice_pk PRIMARY KEY (id)
);

-- Table: property
CREATE TABLE property (
    id int NOT NULL AUTO_INCREMENT,
    property_name varchar(128) NOT NULL,
    property_description text NOT NULL COMMENT 'description in structured format key:value',
    active_from timestamp NOT NULL,
    active_to timestamp NULL,
    is_avaliable bool NOT NULL COMMENT 'is it available at this moment or not',
    is_active bool NOT NULL COMMENT 'can be offered',
    CONSTRAINT property_pk PRIMARY KEY (id)
) COMMENT 'car (Uber), apartment (AirBnB), etc.';

-- Table: provided_service
CREATE TABLE provided_service (
    id int NOT NULL AUTO_INCREMENT,
    request_id int NOT NULL,
    provides_id int NOT NULL,
    details text NOT NULL COMMENT 'detailed description in structured textual format',
    start_time timestamp NULL,
    end_time timestamp NULL,
    grade_customer int NULL,
    grade_provider int NULL,
    UNIQUE INDEX provided_service_ak_1 (request_id,provides_id),
    CONSTRAINT provided_service_pk PRIMARY KEY (id)
);

-- Table: provides
CREATE TABLE provides (
    id int NOT NULL AUTO_INCREMENT,
    user_account_id int NOT NULL,
    service_id int NOT NULL,
    property_id int NOT NULL,
    city_id int NOT NULL,
    time_from timestamp NOT NULL,
    time_to timestamp NULL,
    is_active bool NOT NULL,
    CONSTRAINT provides_pk PRIMARY KEY (id)
);

-- Table: request
CREATE TABLE request (
    id int NOT NULL AUTO_INCREMENT,
    has_role_id int NOT NULL,
    request_status_id int NOT NULL,
    status_time timestamp NOT NULL,
    service_id int NOT NULL,
    city_id int NOT NULL,
    request_details text NOT NULL,
    is_processed bool NOT NULL COMMENT 'is request is assigned to somebody or not',
    is_active bool NOT NULL COMMENT 'if user canceled it -> is_active = No, else -> Yes',
    CONSTRAINT request_pk PRIMARY KEY (id)
);

-- Table: request_status
CREATE TABLE request_status (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(64) NOT NULL,
    UNIQUE INDEX request_status_ak_1 (status_name),
    CONSTRAINT request_status_pk PRIMARY KEY (id)
);

-- Table: request_status_history
CREATE TABLE request_status_history (
    id int NOT NULL AUTO_INCREMENT,
    request_id int NOT NULL,
    request_status_id int NOT NULL,
    has_role_id int NOT NULL,
    status_time timestamp NOT NULL,
    CONSTRAINT request_status_history_pk PRIMARY KEY (id)
);

-- Table: role
CREATE TABLE role (
    id int NOT NULL AUTO_INCREMENT,
    role_name varchar(64) NOT NULL,
    UNIQUE INDEX role_ak_1 (role_name),
    CONSTRAINT role_pk PRIMARY KEY (id)
);

-- Table: service
CREATE TABLE service (
    id int NOT NULL AUTO_INCREMENT,
    service_name varchar(128) NOT NULL,
    description text NULL,
    UNIQUE INDEX service_ak_1 (service_name),
    CONSTRAINT service_pk PRIMARY KEY (id)
);

-- Table: user_account
CREATE TABLE user_account (
    id int NOT NULL AUTO_INCREMENT,
    user_name varchar(64) NOT NULL,
    password varchar(64) NOT NULL,
    first_name varchar(128) NOT NULL,
    last_name varchar(128) NOT NULL,
    city_id int NOT NULL,
    current_city_id int NOT NULL,
    email varchar(255) NOT NULL,
    time_inserted timestamp NOT NULL,
    confirmation_code varchar(255) NOT NULL,
    time_confirmed timestamp NULL,
    UNIQUE INDEX user_account_ak_1 (user_name),
    CONSTRAINT user_account_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: city_country (table: city)
ALTER TABLE city ADD CONSTRAINT city_country FOREIGN KEY city_country (country_id)
    REFERENCES country (id);

-- Reference: document_document_type (table: document)
ALTER TABLE document ADD CONSTRAINT document_document_type FOREIGN KEY document_document_type (document_type_id)
    REFERENCES document_type (id);

-- Reference: document_property (table: document)
ALTER TABLE document ADD CONSTRAINT document_property FOREIGN KEY document_property (property_id)
    REFERENCES property (id);

-- Reference: document_user_account (table: document)
ALTER TABLE document ADD CONSTRAINT document_user_account FOREIGN KEY document_user_account (user_account_id)
    REFERENCES user_account (id);

-- Reference: has_role_role (table: has_role)
ALTER TABLE has_role ADD CONSTRAINT has_role_role FOREIGN KEY has_role_role (role_id)
    REFERENCES role (id);

-- Reference: has_role_user_account (table: has_role)
ALTER TABLE has_role ADD CONSTRAINT has_role_user_account FOREIGN KEY has_role_user_account (user_account_id)
    REFERENCES user_account (id);

-- Reference: invoice_provided_service (table: invoice)
ALTER TABLE invoice ADD CONSTRAINT invoice_provided_service FOREIGN KEY invoice_provided_service (provided_service_id)
    REFERENCES provided_service (id);

-- Reference: provided_service_provides (table: provided_service)
ALTER TABLE provided_service ADD CONSTRAINT provided_service_provides FOREIGN KEY provided_service_provides (provides_id)
    REFERENCES provides (id);

-- Reference: provided_service_reuqest (table: provided_service)
ALTER TABLE provided_service ADD CONSTRAINT provided_service_reuqest FOREIGN KEY provided_service_reuqest (request_id)
    REFERENCES request (id);

-- Reference: provides_city (table: provides)
ALTER TABLE provides ADD CONSTRAINT provides_city FOREIGN KEY provides_city (city_id)
    REFERENCES city (id);

-- Reference: provides_property (table: provides)
ALTER TABLE provides ADD CONSTRAINT provides_property FOREIGN KEY provides_property (property_id)
    REFERENCES property (id);

-- Reference: provides_service (table: provides)
ALTER TABLE provides ADD CONSTRAINT provides_service FOREIGN KEY provides_service (service_id)
    REFERENCES service (id);

-- Reference: provides_user_account (table: provides)
ALTER TABLE provides ADD CONSTRAINT provides_user_account FOREIGN KEY provides_user_account (user_account_id)
    REFERENCES user_account (id);

-- Reference: request_status_history_has_role (table: request_status_history)
ALTER TABLE request_status_history ADD CONSTRAINT request_status_history_has_role FOREIGN KEY request_status_history_has_role (has_role_id)
    REFERENCES has_role (id);

-- Reference: request_status_history_request_status (table: request_status_history)
ALTER TABLE request_status_history ADD CONSTRAINT request_status_history_request_status FOREIGN KEY request_status_history_request_status (request_status_id)
    REFERENCES request_status (id);

-- Reference: request_status_history_reuqest (table: request_status_history)
ALTER TABLE request_status_history ADD CONSTRAINT request_status_history_reuqest FOREIGN KEY request_status_history_reuqest (request_id)
    REFERENCES request (id);

-- Reference: reuqest_city (table: request)
ALTER TABLE request ADD CONSTRAINT reuqest_city FOREIGN KEY reuqest_city (city_id)
    REFERENCES city (id);

-- Reference: reuqest_has_role (table: request)
ALTER TABLE request ADD CONSTRAINT reuqest_has_role FOREIGN KEY reuqest_has_role (has_role_id)
    REFERENCES has_role (id);

-- Reference: reuqest_request_status (table: request)
ALTER TABLE request ADD CONSTRAINT reuqest_request_status FOREIGN KEY reuqest_request_status (request_status_id)
    REFERENCES request_status (id);

-- Reference: reuqest_service (table: request)
ALTER TABLE request ADD CONSTRAINT reuqest_service FOREIGN KEY reuqest_service (service_id)
    REFERENCES service (id);

-- Reference: user_account_city (table: user_account)
ALTER TABLE user_account ADD CONSTRAINT user_account_city FOREIGN KEY user_account_city (city_id)
    REFERENCES city (id);

-- Reference: user_account_current_city (table: user_account)
ALTER TABLE user_account ADD CONSTRAINT user_account_current_city FOREIGN KEY user_account_current_city (current_city_id)
    REFERENCES city (id);

-- End of file.


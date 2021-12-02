-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:02:34.055

-- tables
-- Table: assigned_to
CREATE TABLE assigned_to (
    id int NOT NULL AUTO_INCREMENT,
    mail_id int NOT NULL,
    mail_carrier_id int NOT NULL,
    time_assigned timestamp NOT NULL,
    time_completed timestamp NULL,
    notes text NULL,
    CONSTRAINT assigned_to_pk PRIMARY KEY (id)
);

-- Table: city
CREATE TABLE city (
    id int NOT NULL AUTO_INCREMENT,
    city_name varchar(255) NOT NULL,
    country_id int NOT NULL,
    latitude decimal(9,6) NOT NULL,
    longitude decimal(9,6) NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (id)
);

-- Table: collecting_catalog
CREATE TABLE collecting_catalog (
    id int NOT NULL,
    option_name varchar(255) NOT NULL,
    UNIQUE INDEX collecting_option_ak_1 (option_name),
    CONSTRAINT collecting_catalog_pk PRIMARY KEY (id)
) COMMENT 'list of options how to collect mails and packages - e.g. from mailbox(es), personal delivery combined with mail, package etc.';

-- Table: collecting_option
CREATE TABLE collecting_option (
    id int NOT NULL AUTO_INCREMENT,
    location_id int NOT NULL,
    collecting_catalog_id int NOT NULL,
    details text NULL,
    UNIQUE INDEX collectiong_option_ak_1 (location_id,collecting_catalog_id),
    CONSTRAINT collecting_option_pk PRIMARY KEY (id)
);

-- Table: connection_type
CREATE TABLE connection_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(255) NOT NULL,
    UNIQUE INDEX connection_type_ak_1 (type_name),
    CONSTRAINT connection_type_pk PRIMARY KEY (id)
) COMMENT 'e.g. daily delivery';

-- Table: country
CREATE TABLE country (
    id int NOT NULL AUTO_INCREMENT,
    country_name varchar(255) NOT NULL,
    UNIQUE INDEX country_ak_1 (country_name),
    CONSTRAINT country_pk PRIMARY KEY (id)
);

-- Table: location
CREATE TABLE location (
    id int NOT NULL AUTO_INCREMENT,
    location_name varchar(255) NOT NULL,
    post_office_in_charge int NOT NULL,
    post_office_id int NULL COMMENT 'contain value only if the location is also the post office at the same time',
    description text NULL,
    UNIQUE INDEX location_ak_1 (location_name),
    CONSTRAINT location_pk PRIMARY KEY (id)
) COMMENT 'list of locations (post offices but also group of mailboxes a certain post office is in charge) where mails could be submitted';

-- Table: location_assigned
CREATE TABLE location_assigned (
    id int NOT NULL AUTO_INCREMENT,
    mail_carrier_id int NOT NULL,
    location_id int NOT NULL,
    start_date date NOT NULL,
    end_date date NULL,
    details text NULL,
    UNIQUE INDEX location_assigned_ak_1 (mail_carrier_id,location_id,start_date),
    CONSTRAINT location_assigned_pk PRIMARY KEY (id)
);

-- Table: location_connection
CREATE TABLE location_connection (
    id int NOT NULL AUTO_INCREMENT,
    location_from int NOT NULL,
    location_to int NOT NULL,
    connection_type_id int NOT NULL,
    UNIQUE INDEX location_relation_ak_1 (location_from,location_to,connection_type_id),
    CONSTRAINT location_connection_pk PRIMARY KEY (id)
) COMMENT 'describes in what way are location_from and location_to connacted (they can be related in more than 1 way)';

-- Table: mail
CREATE TABLE mail (
    id int NOT NULL AUTO_INCREMENT,
    mail_code varchar(255) NOT NULL,
    mail_category_id int NOT NULL,
    recipient_address text NOT NULL,
    sender_address text NULL,
    location_start int NOT NULL,
    location_end int NOT NULL,
    time_inserted timestamp NOT NULL COMMENT 'when the mail was inserted in the system',
    time_delivered timestamp NULL,
    UNIQUE INDEX mail_ak_1 (mail_code),
    CONSTRAINT mail_pk PRIMARY KEY (id)
);

-- Table: mail_carrier
CREATE TABLE mail_carrier (
    id int NOT NULL AUTO_INCREMENT,
    employee_code varchar(255) NOT NULL,
    first_name varchar(128) NOT NULL,
    last_name varchar(128) NOT NULL,
    active_from date NOT NULL,
    active_to date NULL,
    is_active bool NOT NULL,
    UNIQUE INDEX mail_carrier_ak_1 (employee_code),
    CONSTRAINT mail_carrier_pk PRIMARY KEY (id)
) COMMENT 'mail man/woman, postman, letter carrier etc.';

-- Table: mail_category
CREATE TABLE mail_category (
    id int NOT NULL AUTO_INCREMENT,
    category_name varchar(255) NOT NULL,
    UNIQUE INDEX mail_category_ak_1 (category_name),
    CONSTRAINT mail_category_pk PRIMARY KEY (id)
);

-- Table: mail_status
CREATE TABLE mail_status (
    id int NOT NULL AUTO_INCREMENT,
    mail_id int NOT NULL,
    status_catalog_id int NOT NULL,
    mail_carrier_id int NULL,
    time_assigned timestamp NOT NULL,
    CONSTRAINT mail_status_pk PRIMARY KEY (id)
);

-- Table: post_office
CREATE TABLE post_office (
    id int NOT NULL AUTO_INCREMENT,
    po_name varchar(255) NOT NULL,
    city_id int NOT NULL,
    po_address varchar(255) NOT NULL,
    po_contact_details text NOT NULL,
    po_manager varchar(255) NOT NULL,
    po_contact_person varchar(255) NOT NULL,
    UNIQUE INDEX post_office_ak_1 (po_name),
    CONSTRAINT post_office_pk PRIMARY KEY (id)
);

-- Table: processing_catalog
CREATE TABLE processing_catalog (
    id int NOT NULL AUTO_INCREMENT,
    option_name varchar(255) NOT NULL,
    UNIQUE INDEX processing_option_ak_1 (option_name),
    CONSTRAINT processing_catalog_pk PRIMARY KEY (id)
) COMMENT 'list of options how to handle mails and packages';

-- Table: processing_option
CREATE TABLE processing_option (
    id int NOT NULL AUTO_INCREMENT,
    location_id int NOT NULL,
    processing_catalog_id int NOT NULL,
    details text NULL,
    UNIQUE INDEX processing_option_ak_1 (location_id,processing_catalog_id),
    CONSTRAINT processing_option_pk PRIMARY KEY (id)
);

-- Table: service
CREATE TABLE service (
    id int NOT NULL AUTO_INCREMENT,
    sevice_name varchar(255) NOT NULL,
    description text NOT NULL,
    is_active bool NOT NULL,
    UNIQUE INDEX service_ak_1 (sevice_name),
    CONSTRAINT service_pk PRIMARY KEY (id)
) COMMENT 'list of all services';

-- Table: service_avaliable
CREATE TABLE service_avaliable (
    id int NOT NULL AUTO_INCREMENT,
    location_id int NOT NULL,
    service_id int NOT NULL,
    details text NULL,
    UNIQUE INDEX service_avaliable_ak_1 (location_id,service_id),
    CONSTRAINT service_avaliable_pk PRIMARY KEY (id)
);

-- Table: status_catalog
CREATE TABLE status_catalog (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(255) NOT NULL,
    UNIQUE INDEX status_catalog_ak_1 (status_name),
    CONSTRAINT status_catalog_pk PRIMARY KEY (id)
) COMMENT 'list of all statuses that could be assigned to a mail';

-- foreign keys
-- Reference: assigned_to_mail (table: assigned_to)
ALTER TABLE assigned_to ADD CONSTRAINT assigned_to_mail FOREIGN KEY assigned_to_mail (mail_id)
    REFERENCES mail (id);

-- Reference: assigned_to_mail_carrier (table: assigned_to)
ALTER TABLE assigned_to ADD CONSTRAINT assigned_to_mail_carrier FOREIGN KEY assigned_to_mail_carrier (mail_carrier_id)
    REFERENCES mail_carrier (id);

-- Reference: city_country (table: city)
ALTER TABLE city ADD CONSTRAINT city_country FOREIGN KEY city_country (country_id)
    REFERENCES country (id);

-- Reference: collectiong_option_collecting_catalog (table: collecting_option)
ALTER TABLE collecting_option ADD CONSTRAINT collectiong_option_collecting_catalog FOREIGN KEY collectiong_option_collecting_catalog (collecting_catalog_id)
    REFERENCES collecting_catalog (id);

-- Reference: collectiong_option_location (table: collecting_option)
ALTER TABLE collecting_option ADD CONSTRAINT collectiong_option_location FOREIGN KEY collectiong_option_location (location_id)
    REFERENCES location (id);

-- Reference: location_assigned_location (table: location_assigned)
ALTER TABLE location_assigned ADD CONSTRAINT location_assigned_location FOREIGN KEY location_assigned_location (location_id)
    REFERENCES location (id);

-- Reference: location_assigned_mail_carrier (table: location_assigned)
ALTER TABLE location_assigned ADD CONSTRAINT location_assigned_mail_carrier FOREIGN KEY location_assigned_mail_carrier (mail_carrier_id)
    REFERENCES mail_carrier (id);

-- Reference: location_post_office (table: location)
ALTER TABLE location ADD CONSTRAINT location_post_office FOREIGN KEY location_post_office (post_office_id)
    REFERENCES post_office (id);

-- Reference: location_post_office_in_charge (table: location)
ALTER TABLE location ADD CONSTRAINT location_post_office_in_charge FOREIGN KEY location_post_office_in_charge (post_office_in_charge)
    REFERENCES post_office (id);

-- Reference: location_relation_connection_type (table: location_connection)
ALTER TABLE location_connection ADD CONSTRAINT location_relation_connection_type FOREIGN KEY location_relation_connection_type (connection_type_id)
    REFERENCES connection_type (id);

-- Reference: location_relation_location_from (table: location_connection)
ALTER TABLE location_connection ADD CONSTRAINT location_relation_location_from FOREIGN KEY location_relation_location_from (location_from)
    REFERENCES location (id);

-- Reference: location_relation_location_to (table: location_connection)
ALTER TABLE location_connection ADD CONSTRAINT location_relation_location_to FOREIGN KEY location_relation_location_to (location_to)
    REFERENCES location (id);

-- Reference: mail_location_end (table: mail)
ALTER TABLE mail ADD CONSTRAINT mail_location_end FOREIGN KEY mail_location_end (location_end)
    REFERENCES location (id);

-- Reference: mail_location_start (table: mail)
ALTER TABLE mail ADD CONSTRAINT mail_location_start FOREIGN KEY mail_location_start (location_start)
    REFERENCES location (id);

-- Reference: mail_mail_category (table: mail)
ALTER TABLE mail ADD CONSTRAINT mail_mail_category FOREIGN KEY mail_mail_category (mail_category_id)
    REFERENCES mail_category (id);

-- Reference: mail_status_mail (table: mail_status)
ALTER TABLE mail_status ADD CONSTRAINT mail_status_mail FOREIGN KEY mail_status_mail (mail_id)
    REFERENCES mail (id);

-- Reference: mail_status_mail_carrier (table: mail_status)
ALTER TABLE mail_status ADD CONSTRAINT mail_status_mail_carrier FOREIGN KEY mail_status_mail_carrier (mail_carrier_id)
    REFERENCES mail_carrier (id);

-- Reference: mail_status_status_catalog (table: mail_status)
ALTER TABLE mail_status ADD CONSTRAINT mail_status_status_catalog FOREIGN KEY mail_status_status_catalog (status_catalog_id)
    REFERENCES status_catalog (id);

-- Reference: post_office_city (table: post_office)
ALTER TABLE post_office ADD CONSTRAINT post_office_city FOREIGN KEY post_office_city (city_id)
    REFERENCES city (id);

-- Reference: processing_option_location (table: processing_option)
ALTER TABLE processing_option ADD CONSTRAINT processing_option_location FOREIGN KEY processing_option_location (location_id)
    REFERENCES location (id);

-- Reference: processing_option_processing_catalog (table: processing_option)
ALTER TABLE processing_option ADD CONSTRAINT processing_option_processing_catalog FOREIGN KEY processing_option_processing_catalog (processing_catalog_id)
    REFERENCES processing_catalog (id);

-- Reference: service_avaliable_location (table: service_avaliable)
ALTER TABLE service_avaliable ADD CONSTRAINT service_avaliable_location FOREIGN KEY service_avaliable_location (location_id)
    REFERENCES location (id);

-- Reference: service_avaliable_service (table: service_avaliable)
ALTER TABLE service_avaliable ADD CONSTRAINT service_avaliable_service FOREIGN KEY service_avaliable_service (service_id)
    REFERENCES service (id);

-- End of file.


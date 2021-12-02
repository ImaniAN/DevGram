-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:52:03.034

-- tables
-- Table: city
CREATE TABLE city (
    id int NOT NULL AUTO_INCREMENT,
    postal_code varchar(16) NOT NULL,
    city_name varchar(128) NOT NULL,
    country_id int NOT NULL,
    UNIQUE INDEX city_ak_1 (postal_code,city_name,country_id),
    CONSTRAINT city_pk PRIMARY KEY (id)
) COMMENT 'list of all cities';

-- Table: complex
CREATE TABLE complex (
    id int NOT NULL AUTO_INCREMENT,
    complex_code varchar(255) NOT NULL,
    complex_name varchar(128) NOT NULL,
    city_id int NOT NULL,
    address varchar(255) NOT NULL,
    position varchar(255) NOT NULL COMMENT 'coordinates on the map',
    description text NULL,
    ts_inserted timestamp NOT NULL,
    is_active bool NOT NULL,
    UNIQUE INDEX complex_ak_1 (complex_code),
    CONSTRAINT complex_pk PRIMARY KEY (id)
) COMMENT 'list of all complexes (e.g. shopping mall) where devices are installed';

-- Table: country
CREATE TABLE country (
    id int NOT NULL AUTO_INCREMENT,
    country_name varchar(128) NOT NULL,
    UNIQUE INDEX country_ak_1 (country_name),
    CONSTRAINT country_pk PRIMARY KEY (id)
) COMMENT 'list of all countries';

-- Table: device
CREATE TABLE device (
    id int NOT NULL AUTO_INCREMENT,
    device_code varchar(255) NOT NULL,
    device_name int NOT NULL,
    installation_id int NOT NULL,
    current_status_id int NOT NULL,
    ts_inserted timestamp NOT NULL,
    UNIQUE INDEX device_ak_1 (device_code),
    CONSTRAINT device_pk PRIMARY KEY (id)
);

-- Table: device_status
CREATE TABLE device_status (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(255) NOT NULL,
    is_maintenance bool NOT NULL,
    is_broken bool NOT NULL,
    is_inactive bool NOT NULL,
    is_active bool NOT NULL,
    UNIQUE INDEX device_status_catalog_ak_1 (status_name),
    CONSTRAINT device_status_pk PRIMARY KEY (id)
);

-- Table: device_status_history
CREATE TABLE device_status_history (
    id int NOT NULL AUTO_INCREMENT,
    device_id int NOT NULL,
    status_id int NOT NULL,
    ts_inserted timestamp NOT NULL,
    CONSTRAINT device_status_history_pk PRIMARY KEY (id)
);

-- Table: event
CREATE TABLE event (
    id int NOT NULL AUTO_INCREMENT,
    event_type_id int NOT NULL,
    description text NULL,
    signal_id int NULL,
    inserted_manually bool NOT NULL,
    event_ts timestamp NOT NULL,
    ts_inserted timestamp NOT NULL,
    CONSTRAINT event_pk PRIMARY KEY (id)
) COMMENT 'events created automatically or manually, e.g. person is at the door - detected by sensors';

-- Table: event_device
CREATE TABLE event_device (
    id int NOT NULL AUTO_INCREMENT,
    event_id int NOT NULL,
    device_id int NOT NULL,
    ts_inserted timestamp NOT NULL,
    UNIQUE INDEX event_device_ak_1 (event_id,device_id),
    CONSTRAINT event_device_pk PRIMARY KEY (id)
) COMMENT 'list of all related devices - especially important if event was inserted manually';

-- Table: event_type
CREATE TABLE event_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(255) NOT NULL,
    UNIQUE INDEX event_type_ak_1 (type_name),
    CONSTRAINT event_type_pk PRIMARY KEY (id)
);

-- Table: installation
CREATE TABLE installation (
    id int NOT NULL AUTO_INCREMENT,
    installation_code varchar(255) NOT NULL,
    installation_type_id int NOT NULL,
    complex_id int NOT NULL,
    position varchar(255) NOT NULL COMMENT 'coordinates inside complex',
    description text NULL,
    current_status_id int NOT NULL,
    ts_inserted timestamp NOT NULL,
    UNIQUE INDEX installation_ak_1 (installation_code),
    CONSTRAINT installation_pk PRIMARY KEY (id)
) COMMENT 'list of all installations (e.g. doors, video system) where devices are installed';

-- Table: installation_status
CREATE TABLE installation_status (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(255) NOT NULL,
    is_maintenance bool NOT NULL,
    is_broken bool NOT NULL,
    is_inactive bool NOT NULL,
    is_active bool NOT NULL,
    UNIQUE INDEX installation_status_catalog_ak_1 (status_name),
    CONSTRAINT installation_status_pk PRIMARY KEY (id)
);

-- Table: installation_status_history
CREATE TABLE installation_status_history (
    id int NOT NULL AUTO_INCREMENT,
    installation_id int NOT NULL,
    status_id int NOT NULL,
    ts_inserted timestamp NOT NULL,
    CONSTRAINT installation_status_history_pk PRIMARY KEY (id)
);

-- Table: installation_type
CREATE TABLE installation_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(128) NOT NULL,
    UNIQUE INDEX installation_type_ak_1 (type_name),
    CONSTRAINT installation_type_pk PRIMARY KEY (id)
);

-- Table: related_device
CREATE TABLE related_device (
    id int NOT NULL AUTO_INCREMENT,
    device_1_id int NOT NULL,
    device_2_id int NOT NULL,
    UNIQUE INDEX related_device_ak_1 (device_1_id,device_2_id),
    CONSTRAINT related_device_pk PRIMARY KEY (id)
) COMMENT 'list of related devices, e.g. sensors and motor';

-- Table: related_installation
CREATE TABLE related_installation (
    id int NOT NULL AUTO_INCREMENT,
    installation_1_id int NOT NULL,
    installation_2_id int NOT NULL,
    UNIQUE INDEX related_installation_ak_1 (installation_1_id,installation_2_id),
    CONSTRAINT related_installation_pk PRIMARY KEY (id)
) COMMENT 'related installations, e.g. doors and escalator';

-- Table: signal
CREATE TABLE `signal` (
    id int NOT NULL AUTO_INCREMENT,
    device_id int NOT NULL,
    value decimal(12,2) NOT NULL,
    description text NULL COMMENT 'signal type, values, unit used...',
    ts timestamp NOT NULL,
    CONSTRAINT signal_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: city_country (table: city)
ALTER TABLE city ADD CONSTRAINT city_country FOREIGN KEY city_country (country_id)
    REFERENCES country (id);

-- Reference: complex_city (table: complex)
ALTER TABLE complex ADD CONSTRAINT complex_city FOREIGN KEY complex_city (city_id)
    REFERENCES city (id);

-- Reference: device_device_status_catalog (table: device)
ALTER TABLE device ADD CONSTRAINT device_device_status_catalog FOREIGN KEY device_device_status_catalog (current_status_id)
    REFERENCES device_status (id);

-- Reference: device_installation (table: device)
ALTER TABLE device ADD CONSTRAINT device_installation FOREIGN KEY device_installation (installation_id)
    REFERENCES installation (id);

-- Reference: device_status_device (table: device_status_history)
ALTER TABLE device_status_history ADD CONSTRAINT device_status_device FOREIGN KEY device_status_device (device_id)
    REFERENCES device (id);

-- Reference: device_status_device_status_catalog (table: device_status_history)
ALTER TABLE device_status_history ADD CONSTRAINT device_status_device_status_catalog FOREIGN KEY device_status_device_status_catalog (status_id)
    REFERENCES device_status (id);

-- Reference: event_device_device (table: event_device)
ALTER TABLE event_device ADD CONSTRAINT event_device_device FOREIGN KEY event_device_device (device_id)
    REFERENCES device (id);

-- Reference: event_device_event (table: event_device)
ALTER TABLE event_device ADD CONSTRAINT event_device_event FOREIGN KEY event_device_event (event_id)
    REFERENCES event (id);

-- Reference: event_event_type (table: event)
ALTER TABLE event ADD CONSTRAINT event_event_type FOREIGN KEY event_event_type (event_type_id)
    REFERENCES event_type (id);

-- Reference: event_signal (table: event)
ALTER TABLE event ADD CONSTRAINT event_signal FOREIGN KEY event_signal (signal_id)
    REFERENCES `signal` (id);

-- Reference: installation_complex (table: installation)
ALTER TABLE installation ADD CONSTRAINT installation_complex FOREIGN KEY installation_complex (complex_id)
    REFERENCES complex (id);

-- Reference: installation_installation_status_catalog (table: installation)
ALTER TABLE installation ADD CONSTRAINT installation_installation_status_catalog FOREIGN KEY installation_installation_status_catalog (current_status_id)
    REFERENCES installation_status (id);

-- Reference: installation_installation_type (table: installation)
ALTER TABLE installation ADD CONSTRAINT installation_installation_type FOREIGN KEY installation_installation_type (installation_type_id)
    REFERENCES installation_type (id);

-- Reference: installation_status_installation (table: installation_status_history)
ALTER TABLE installation_status_history ADD CONSTRAINT installation_status_installation FOREIGN KEY installation_status_installation (installation_id)
    REFERENCES installation (id);

-- Reference: installation_status_installation_status_catalog (table: installation_status_history)
ALTER TABLE installation_status_history ADD CONSTRAINT installation_status_installation_status_catalog FOREIGN KEY installation_status_installation_status_catalog (status_id)
    REFERENCES installation_status (id);

-- Reference: related_device_device_1 (table: related_device)
ALTER TABLE related_device ADD CONSTRAINT related_device_device_1 FOREIGN KEY related_device_device_1 (device_1_id)
    REFERENCES device (id);

-- Reference: related_device_device_2 (table: related_device)
ALTER TABLE related_device ADD CONSTRAINT related_device_device_2 FOREIGN KEY related_device_device_2 (device_2_id)
    REFERENCES device (id);

-- Reference: related_installation_installation_1 (table: related_installation)
ALTER TABLE related_installation ADD CONSTRAINT related_installation_installation_1 FOREIGN KEY related_installation_installation_1 (installation_1_id)
    REFERENCES installation (id);

-- Reference: related_installation_installation_2 (table: related_installation)
ALTER TABLE related_installation ADD CONSTRAINT related_installation_installation_2 FOREIGN KEY related_installation_installation_2 (installation_2_id)
    REFERENCES installation (id);

-- Reference: signal_device (table: signal)
ALTER TABLE `signal` ADD CONSTRAINT signal_device FOREIGN KEY signal_device (device_id)
    REFERENCES device (id);

-- End of file.


-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:01:43.143

-- tables
-- Table: acquisition
CREATE TABLE acquisition (
    id int NOT NULL AUTO_INCREMENT,
    acquisition_name varchar(255) NOT NULL,
    UNIQUE INDEX aquisition_ak_1 (acquisition_name),
    CONSTRAINT acquisition_pk PRIMARY KEY (id)
) COMMENT 'e.g. direct, google, facebook...';

-- Table: age
CREATE TABLE age (
    id int NOT NULL AUTO_INCREMENT,
    age_range varchar(32) NOT NULL COMMENT 'e.g. 18 to 24',
    lower_boundary int NOT NULL,
    upper_boundary int NULL,
    UNIQUE INDEX age_ak_1 (age_range),
    CONSTRAINT age_pk PRIMARY KEY (id)
);

-- Table: browser
CREATE TABLE browser (
    id int NOT NULL AUTO_INCREMENT,
    browser_name varchar(255) NOT NULL,
    UNIQUE INDEX browser_ak_1 (browser_name),
    CONSTRAINT browser_pk PRIMARY KEY (id)
) COMMENT 'list of all browsers';

-- Table: city
CREATE TABLE city (
    id int NOT NULL AUTO_INCREMENT,
    city_name varchar(255) NOT NULL,
    postal_code varchar(16) NULL,
    country_id int NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (id)
) COMMENT 'lits of all cities & places';

-- Table: country
CREATE TABLE country (
    id int NOT NULL AUTO_INCREMENT,
    country_code varchar(8) NOT NULL,
    country_name varchar(255) NOT NULL,
    UNIQUE INDEX country_ak_1 (country_code),
    UNIQUE INDEX country_ak_2 (country_name),
    CONSTRAINT country_pk PRIMARY KEY (id)
) COMMENT 'list of all countries';

-- Table: device_type
CREATE TABLE device_type (
    id int NOT NULL AUTO_INCREMENT,
    device_type_name varchar(255) NOT NULL,
    UNIQUE INDEX device_type_ak_1 (device_type_name),
    CONSTRAINT device_type_pk PRIMARY KEY (id)
) COMMENT 'e.g. desktop, mobile, tablet';

-- Table: gender
CREATE TABLE gender (
    id int NOT NULL AUTO_INCREMENT,
    gender_name varchar(32) NOT NULL,
    UNIQUE INDEX gender_ak_1 (gender_name),
    CONSTRAINT gender_pk PRIMARY KEY (id)
);

-- Table: language
CREATE TABLE language (
    id int NOT NULL AUTO_INCREMENT,
    language_code varchar(8) NOT NULL,
    language_name varchar(255) NOT NULL,
    UNIQUE INDEX language_ak_1 (language_code),
    UNIQUE INDEX language_ak_2 (language_name),
    CONSTRAINT language_pk PRIMARY KEY (id)
);

-- Table: operating_system
CREATE TABLE operating_system (
    id int NOT NULL AUTO_INCREMENT,
    os_name varchar(255) NOT NULL,
    UNIQUE INDEX operating_system_ak_1 (os_name),
    CONSTRAINT operating_system_pk PRIMARY KEY (id)
) COMMENT 'list of all operating systems';

-- Table: page
CREATE TABLE page (
    id int NOT NULL AUTO_INCREMENT,
    page_url text NOT NULL,
    UNIQUE INDEX page_ak_1 (page_url),
    CONSTRAINT page_pk PRIMARY KEY (id)
) COMMENT 'list of all pages on site';

-- Table: service_provider
CREATE TABLE service_provider (
    id int NOT NULL AUTO_INCREMENT,
    sp_name varchar(255) NOT NULL,
    UNIQUE INDEX service_provider_ak_1 (sp_name),
    CONSTRAINT service_provider_pk PRIMARY KEY (id)
) COMMENT 'service providers list';

-- Table: session
CREATE TABLE session (
    id int NOT NULL AUTO_INCREMENT,
    jsession_id text NULL,
    user_id varchar(255) NOT NULL,
    session_start_time timestamp NOT NULL,
    session_end_time timestamp NULL,
    entrance_page_id int NOT NULL,
    exit_page_id int NULL,
    city_id int NULL,
    language_id int NULL,
    service_provider_id int NULL,
    device_type_id int NULL,
    operating_system_id int NULL,
    browser_id int NULL,
    acquisition_id int NULL,
    age_id int NULL,
    gender_id int NULL,
    is_first_visit bool NOT NULL COMMENT 'is this visit daily unique visitor',
    CONSTRAINT session_pk PRIMARY KEY (id)
);

-- Table: session_page
CREATE TABLE session_page (
    id int NOT NULL AUTO_INCREMENT,
    session_id int NOT NULL,
    page_id int NOT NULL,
    page_order int NOT NULL,
    start_time timestamp NOT NULL,
    end_time timestamp NULL,
    CONSTRAINT session_page_pk PRIMARY KEY (id)
) COMMENT 'order of pages in session';

-- foreign keys
-- Reference: city_country (table: city)
ALTER TABLE city ADD CONSTRAINT city_country FOREIGN KEY city_country (country_id)
    REFERENCES country (id);

-- Reference: session_acquisition (table: session)
ALTER TABLE session ADD CONSTRAINT session_acquisition FOREIGN KEY session_acquisition (acquisition_id)
    REFERENCES acquisition (id);

-- Reference: session_age (table: session)
ALTER TABLE session ADD CONSTRAINT session_age FOREIGN KEY session_age (age_id)
    REFERENCES age (id);

-- Reference: session_browser (table: session)
ALTER TABLE session ADD CONSTRAINT session_browser FOREIGN KEY session_browser (browser_id)
    REFERENCES browser (id);

-- Reference: session_city (table: session)
ALTER TABLE session ADD CONSTRAINT session_city FOREIGN KEY session_city (city_id)
    REFERENCES city (id);

-- Reference: session_device_type (table: session)
ALTER TABLE session ADD CONSTRAINT session_device_type FOREIGN KEY session_device_type (device_type_id)
    REFERENCES device_type (id);

-- Reference: session_gender (table: session)
ALTER TABLE session ADD CONSTRAINT session_gender FOREIGN KEY session_gender (gender_id)
    REFERENCES gender (id);

-- Reference: session_language (table: session)
ALTER TABLE session ADD CONSTRAINT session_language FOREIGN KEY session_language (language_id)
    REFERENCES language (id);

-- Reference: session_operating_system (table: session)
ALTER TABLE session ADD CONSTRAINT session_operating_system FOREIGN KEY session_operating_system (operating_system_id)
    REFERENCES operating_system (id);

-- Reference: session_page_entrance (table: session)
ALTER TABLE session ADD CONSTRAINT session_page_entrance FOREIGN KEY session_page_entrance (entrance_page_id)
    REFERENCES page (id);

-- Reference: session_page_exit (table: session)
ALTER TABLE session ADD CONSTRAINT session_page_exit FOREIGN KEY session_page_exit (exit_page_id)
    REFERENCES page (id);

-- Reference: session_pages_page (table: session_page)
ALTER TABLE session_page ADD CONSTRAINT session_pages_page FOREIGN KEY session_pages_page (page_id)
    REFERENCES page (id);

-- Reference: session_pages_session (table: session_page)
ALTER TABLE session_page ADD CONSTRAINT session_pages_session FOREIGN KEY session_pages_session (session_id)
    REFERENCES session (id);

-- Reference: session_service_provider (table: session)
ALTER TABLE session ADD CONSTRAINT session_service_provider FOREIGN KEY session_service_provider (service_provider_id)
    REFERENCES service_provider (id);

-- End of file.


-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:01:40.876

-- tables
-- Table: avaliable_for
CREATE TABLE avaliable_for (
    id int NOT NULL AUTO_INCREMENT,
    service_id int NOT NULL,
    species_id int NOT NULL,
    UNIQUE INDEX avaliable_for_ak_1 (service_id,species_id),
    CONSTRAINT avaliable_for_pk PRIMARY KEY (id)
) COMMENT 'list of all species that this service could be provided for (e.g. accommodation for cats and dogs could go into the same category)';

-- Table: case
CREATE TABLE `case` (
    id int NOT NULL AUTO_INCREMENT,
    facility_id int NOT NULL,
    pet_id int NOT NULL,
    start_time timestamp NOT NULL,
    end_time timestamp NULL,
    notes text NULL,
    closed bool NOT NULL,
    UNIQUE INDEX case_ak_1 (facility_id,pet_id,start_time),
    CONSTRAINT case_pk PRIMARY KEY (id)
) COMMENT 'list of all cases/visits';

-- Table: current_status
CREATE TABLE current_status (
    id int NOT NULL AUTO_INCREMENT,
    case_id int NOT NULL,
    status_id int NOT NULL,
    notes text NOT NULL,
    insert_time timestamp NOT NULL,
    UNIQUE INDEX current_status_ak_1 (case_id,status_id),
    CONSTRAINT current_status_pk PRIMARY KEY (id)
);

-- Table: facility
CREATE TABLE facility (
    id int NOT NULL AUTO_INCREMENT,
    facility_name varchar(255) NOT NULL,
    address varchar(255) NOT NULL,
    phone varchar(64) NOT NULL,
    email varchar(255) NOT NULL,
    contact_person varchar(255) NOT NULL,
    UNIQUE INDEX facility_ak_1 (facility_name),
    CONSTRAINT facility_pk PRIMARY KEY (id)
);

-- Table: invoice
CREATE TABLE invoice (
    id int NOT NULL AUTO_INCREMENT,
    invoice_code varchar(255) NOT NULL,
    case_id int NOT NULL,
    time_generated int NOT NULL,
    invoice_amount decimal(10,2) NOT NULL,
    discount decimal(10,2) NOT NULL,
    time_charged timestamp NULL,
    amount_charged decimal(10,2) NULL,
    notes text NULL,
    UNIQUE INDEX invoice_ak_1 (invoice_code),
    CONSTRAINT invoice_pk PRIMARY KEY (id)
);

-- Table: note
CREATE TABLE note (
    id int NOT NULL AUTO_INCREMENT,
    note_text text NOT NULL,
    case_id int NOT NULL,
    insert_time timestamp NOT NULL,
    CONSTRAINT note_pk PRIMARY KEY (id)
) COMMENT 'all notes related with cases/visits';

-- Table: owner
CREATE TABLE owner (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(128) NOT NULL,
    last_name varchar(128) NOT NULL,
    mobile varchar(64) NOT NULL,
    email varchar(255) NULL,
    phone varchar(64) NULL,
    notes text NULL,
    CONSTRAINT owner_pk PRIMARY KEY (id)
);

-- Table: pet
CREATE TABLE pet (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(128) NOT NULL,
    species_id int NOT NULL,
    birth_date date NULL,
    notes text NULL,
    CONSTRAINT pet_pk PRIMARY KEY (id)
);

-- Table: pet_owner
CREATE TABLE pet_owner (
    id int NOT NULL AUTO_INCREMENT,
    pet_id int NOT NULL,
    owner_id int NOT NULL,
    UNIQUE INDEX pet_owner_ak_1 (pet_id,owner_id),
    CONSTRAINT pet_owner_pk PRIMARY KEY (id)
);

-- Table: provides
CREATE TABLE provides (
    id int NOT NULL AUTO_INCREMENT,
    facility_id int NOT NULL,
    service_id int NOT NULL,
    service_limit int NULL COMMENT 'if a service has a limit, we''''ll need to define it for each facility',
    currently_used int NULL COMMENT 'if a service has a limit, we''''ll need to store current occupancy',
    CONSTRAINT provides_pk PRIMARY KEY (id)
) COMMENT 'list of all services that are provided in that facility';

-- Table: service
CREATE TABLE service (
    id int NOT NULL AUTO_INCREMENT,
    service_name varchar(255) NOT NULL,
    has_limit bool NOT NULL COMMENT 'does service has limit (e.g. number of "beds" for pets") or not',
    unit_id int NOT NULL,
    cost_per_unit decimal(10,2) NOT NULL,
    UNIQUE INDEX service_ak_1 (service_name),
    CONSTRAINT service_pk PRIMARY KEY (id)
);

-- Table: service_planned
CREATE TABLE service_planned (
    id int NOT NULL AUTO_INCREMENT,
    case_id int NOT NULL,
    service_id int NOT NULL,
    planned_start_time timestamp NULL,
    planned_end_time timestamp NOT NULL,
    planned_units int NOT NULL,
    cost_per_unit decimal(10,2) NOT NULL,
    planned_price decimal(10,2) NOT NULL,
    notes text NULL,
    CONSTRAINT service_planned_pk PRIMARY KEY (id)
);

-- Table: service_provided
CREATE TABLE service_provided (
    id int NOT NULL AUTO_INCREMENT,
    case_id int NOT NULL,
    service_id int NOT NULL,
    start_time timestamp NOT NULL,
    end_time timestamp NULL,
    units int NULL,
    cost_per_unit decimal(10,2) NOT NULL,
    price_charged decimal(10,2) NULL,
    notes text NULL,
    CONSTRAINT service_provided_pk PRIMARY KEY (id)
);

-- Table: species
CREATE TABLE species (
    id int NOT NULL AUTO_INCREMENT,
    species_name varchar(255) NOT NULL,
    UNIQUE INDEX species_ak_1 (species_name),
    CONSTRAINT species_pk PRIMARY KEY (id)
) COMMENT 'e.g. cat, dog, bird - or more detailed if we need it';

-- Table: status
CREATE TABLE status (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(255) NOT NULL,
    status_category_id int NOT NULL,
    is_closing_status bool NOT NULL,
    UNIQUE INDEX status_ak_1 (status_name,status_category_id),
    CONSTRAINT status_pk PRIMARY KEY (id)
) COMMENT 'list of all statuses (e.g. problems if sick)';

-- Table: status_category
CREATE TABLE status_category (
    id int NOT NULL AUTO_INCREMENT,
    status_category_name varchar(255) NOT NULL,
    UNIQUE INDEX status_category_ak_1 (status_category_name),
    CONSTRAINT status_category_pk PRIMARY KEY (id)
) COMMENT 'categories like: physical status, appetite, general, ....';

-- Table: unit
CREATE TABLE unit (
    id int NOT NULL AUTO_INCREMENT,
    unit_name varchar(64) NOT NULL,
    UNIQUE INDEX unit_ak_1 (unit_name),
    CONSTRAINT unit_pk PRIMARY KEY (id)
) COMMENT 'all units we''''ll use: e.g. working hours, days, etc.';

-- foreign keys
-- Reference: avaliable_for_service (table: avaliable_for)
ALTER TABLE avaliable_for ADD CONSTRAINT avaliable_for_service FOREIGN KEY avaliable_for_service (service_id)
    REFERENCES service (id);

-- Reference: avaliable_for_species (table: avaliable_for)
ALTER TABLE avaliable_for ADD CONSTRAINT avaliable_for_species FOREIGN KEY avaliable_for_species (species_id)
    REFERENCES species (id);

-- Reference: current_status_case (table: current_status)
ALTER TABLE current_status ADD CONSTRAINT current_status_case FOREIGN KEY current_status_case (case_id)
    REFERENCES `case` (id);

-- Reference: current_status_status (table: current_status)
ALTER TABLE current_status ADD CONSTRAINT current_status_status FOREIGN KEY current_status_status (status_id)
    REFERENCES status (id);

-- Reference: invoice_case (table: invoice)
ALTER TABLE invoice ADD CONSTRAINT invoice_case FOREIGN KEY invoice_case (case_id)
    REFERENCES `case` (id);

-- Reference: notes_case (table: note)
ALTER TABLE note ADD CONSTRAINT notes_case FOREIGN KEY notes_case (case_id)
    REFERENCES `case` (id);

-- Reference: pet_owner_owner (table: pet_owner)
ALTER TABLE pet_owner ADD CONSTRAINT pet_owner_owner FOREIGN KEY pet_owner_owner (owner_id)
    REFERENCES owner (id);

-- Reference: pet_owner_pet (table: pet_owner)
ALTER TABLE pet_owner ADD CONSTRAINT pet_owner_pet FOREIGN KEY pet_owner_pet (pet_id)
    REFERENCES pet (id);

-- Reference: pet_species (table: pet)
ALTER TABLE pet ADD CONSTRAINT pet_species FOREIGN KEY pet_species (species_id)
    REFERENCES species (id);

-- Reference: provides_facility (table: provides)
ALTER TABLE provides ADD CONSTRAINT provides_facility FOREIGN KEY provides_facility (facility_id)
    REFERENCES facility (id);

-- Reference: provides_service (table: provides)
ALTER TABLE provides ADD CONSTRAINT provides_service FOREIGN KEY provides_service (service_id)
    REFERENCES service (id);

-- Reference: service_planned_case (table: service_planned)
ALTER TABLE service_planned ADD CONSTRAINT service_planned_case FOREIGN KEY service_planned_case (case_id)
    REFERENCES `case` (id);

-- Reference: service_planned_service (table: service_planned)
ALTER TABLE service_planned ADD CONSTRAINT service_planned_service FOREIGN KEY service_planned_service (service_id)
    REFERENCES service (id);

-- Reference: service_provided_case (table: service_provided)
ALTER TABLE service_provided ADD CONSTRAINT service_provided_case FOREIGN KEY service_provided_case (case_id)
    REFERENCES `case` (id);

-- Reference: service_provided_service (table: service_provided)
ALTER TABLE service_provided ADD CONSTRAINT service_provided_service FOREIGN KEY service_provided_service (service_id)
    REFERENCES service (id);

-- Reference: service_unit (table: service)
ALTER TABLE service ADD CONSTRAINT service_unit FOREIGN KEY service_unit (unit_id)
    REFERENCES unit (id);

-- Reference: status_status_category (table: status)
ALTER TABLE status ADD CONSTRAINT status_status_category FOREIGN KEY status_status_category (status_category_id)
    REFERENCES status_category (id);

-- Reference: visit_facility (table: case)
ALTER TABLE `case` ADD CONSTRAINT visit_facility FOREIGN KEY visit_facility (facility_id)
    REFERENCES facility (id);

-- Reference: visit_pet (table: case)
ALTER TABLE `case` ADD CONSTRAINT visit_pet FOREIGN KEY visit_pet (pet_id)
    REFERENCES pet (id);

-- End of file.


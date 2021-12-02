-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:08:45.811

-- tables
-- Table: employee
CREATE TABLE employee (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    CONSTRAINT employee_pk PRIMARY KEY (id)
) COMMENT 'employees dictionary';

-- Table: engaged
CREATE TABLE engaged (
    id int NOT NULL AUTO_INCREMENT,
    show_id int NOT NULL,
    has_role_id int NOT NULL,
    start_time timestamp NOT NULL,
    end_time timestamp NULL,
    cost_planned decimal(8,2) NOT NULL,
    cost_actual decimal(8,2) NULL,
    CONSTRAINT engaged_pk PRIMARY KEY (id)
) COMMENT 'users (having roles) working on that show';

-- Table: equipment
CREATE TABLE equipment (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    equipment_type_id int NOT NULL,
    available decimal(8,2) NOT NULL,
    UNIQUE INDEX equipment_ak_1 (name),
    CONSTRAINT equipment_pk PRIMARY KEY (id)
) COMMENT 'list of all available equipment';

-- Table: equipment_type
CREATE TABLE equipment_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(255) NOT NULL,
    UNIQUE INDEX equipment_type_ak_1 (type_name),
    CONSTRAINT equipment_type_pk PRIMARY KEY (id)
) COMMENT 'equipment type dictionary (e.g. lightning equipment, musical equipment)';

-- Table: event
CREATE TABLE event (
    id int NOT NULL AUTO_INCREMENT,
    event_name varchar(255) NOT NULL,
    event_type_id int NOT NULL,
    event_location varchar(255) NOT NULL,
    event_description text NOT NULL,
    start_time timestamp NOT NULL,
    end_time timestamp NULL,
    CONSTRAINT event_pk PRIMARY KEY (id)
);

-- Table: event_type
CREATE TABLE event_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(255) NOT NULL,
    UNIQUE INDEX event_type_ak_1 (type_name),
    CONSTRAINT event_type_pk PRIMARY KEY (id)
) COMMENT 'event types, e.g. music festival, film festival';

-- Table: has_role
CREATE TABLE has_role (
    id int NOT NULL AUTO_INCREMENT,
    employee_id int NOT NULL,
    role_id int NOT NULL,
    start_time timestamp NOT NULL,
    end_time timestamp NOT NULL,
    UNIQUE INDEX has_role_ak_1 (employee_id,role_id,start_time),
    CONSTRAINT has_role_pk PRIMARY KEY (id)
) COMMENT 'list of all roles assigned to users
';

-- Table: is_partner
CREATE TABLE is_partner (
    id int NOT NULL AUTO_INCREMENT,
    event_id int NOT NULL,
    partner_id int NOT NULL,
    partner_role_id int NOT NULL,
    UNIQUE INDEX is_partner_ak_1 (event_id,partner_id,partner_role_id),
    CONSTRAINT is_partner_pk PRIMARY KEY (id)
) COMMENT 'list of all partners (and their types) for a certain event, e.g. media partner, sponsor';

-- Table: participate
CREATE TABLE participate (
    id int NOT NULL AUTO_INCREMENT,
    show_id int NOT NULL,
    performer_id int NOT NULL,
    start_time timestamp NOT NULL,
    end_time timestamp NOT NULL,
    cost_planned decimal(8,2) NOT NULL,
    cost_actual decimal(8,2) NULL,
    CONSTRAINT participate_pk PRIMARY KEY (id)
) COMMENT 'performers taking part in a show';

-- Table: partner
CREATE TABLE partner (
    id int NOT NULL AUTO_INCREMENT,
    partner_name varchar(255) NOT NULL,
    partner_details text NOT NULL,
    CONSTRAINT partner_pk PRIMARY KEY (id)
) COMMENT 'partners catalog';

-- Table: partner_role
CREATE TABLE partner_role (
    id int NOT NULL AUTO_INCREMENT,
    role_name varchar(255) NOT NULL,
    UNIQUE INDEX partner_type_ak_1 (role_name),
    CONSTRAINT partner_role_pk PRIMARY KEY (id)
) COMMENT 'partner roles dictionary';

-- Table: performer
CREATE TABLE performer (
    id int NOT NULL AUTO_INCREMENT,
    full_name varchar(255) NOT NULL,
    genre varchar(255) NOT NULL,
    contact_details text NOT NULL,
    CONSTRAINT performer_pk PRIMARY KEY (id)
) COMMENT 'performers dictionary';

-- Table: required
CREATE TABLE required (
    id int NOT NULL AUTO_INCREMENT,
    show_id int NOT NULL,
    equipment_id int NOT NULL,
    qunatity decimal(8,2) NOT NULL,
    cost_planned decimal(8,2) NOT NULL,
    cost_actual decimal(8,2) NULL,
    UNIQUE INDEX required_ak_1 (show_id,equipment_id),
    CONSTRAINT required_pk PRIMARY KEY (id)
) COMMENT 'equipment required for a specific show';

-- Table: role
CREATE TABLE role (
    id int NOT NULL AUTO_INCREMENT,
    role_name varchar(64) NOT NULL,
    UNIQUE INDEX role_ak_1 (role_name),
    CONSTRAINT role_pk PRIMARY KEY (id)
) COMMENT 'roles dictionary';

-- Table: show
CREATE TABLE `show` (
    id int NOT NULL AUTO_INCREMENT,
    show_name varchar(255) NOT NULL,
    show_location varchar(255) NOT NULL,
    show_description text NOT NULL,
    start_time timestamp NOT NULL,
    end_time timestamp NULL,
    event_id int NOT NULL,
    CONSTRAINT show_pk PRIMARY KEY (id)
) COMMENT 'shows catalog';

-- foreign keys
-- Reference: engaged_has_role (table: engaged)
ALTER TABLE engaged ADD CONSTRAINT engaged_has_role FOREIGN KEY engaged_has_role (has_role_id)
    REFERENCES has_role (id);

-- Reference: engaged_show (table: engaged)
ALTER TABLE engaged ADD CONSTRAINT engaged_show FOREIGN KEY engaged_show (show_id)
    REFERENCES `show` (id);

-- Reference: equipment_equipment_type (table: equipment)
ALTER TABLE equipment ADD CONSTRAINT equipment_equipment_type FOREIGN KEY equipment_equipment_type (equipment_type_id)
    REFERENCES equipment_type (id);

-- Reference: event_event_type (table: event)
ALTER TABLE event ADD CONSTRAINT event_event_type FOREIGN KEY event_event_type (event_type_id)
    REFERENCES event_type (id);

-- Reference: has_role_employee (table: has_role)
ALTER TABLE has_role ADD CONSTRAINT has_role_employee FOREIGN KEY has_role_employee (employee_id)
    REFERENCES employee (id);

-- Reference: has_role_role (table: has_role)
ALTER TABLE has_role ADD CONSTRAINT has_role_role FOREIGN KEY has_role_role (role_id)
    REFERENCES role (id);

-- Reference: is_partner_event (table: is_partner)
ALTER TABLE is_partner ADD CONSTRAINT is_partner_event FOREIGN KEY is_partner_event (event_id)
    REFERENCES event (id);

-- Reference: is_partner_partner (table: is_partner)
ALTER TABLE is_partner ADD CONSTRAINT is_partner_partner FOREIGN KEY is_partner_partner (partner_id)
    REFERENCES partner (id);

-- Reference: is_partner_partner_type (table: is_partner)
ALTER TABLE is_partner ADD CONSTRAINT is_partner_partner_type FOREIGN KEY is_partner_partner_type (partner_role_id)
    REFERENCES partner_role (id);

-- Reference: participate_performer (table: participate)
ALTER TABLE participate ADD CONSTRAINT participate_performer FOREIGN KEY participate_performer (performer_id)
    REFERENCES performer (id);

-- Reference: participate_show (table: participate)
ALTER TABLE participate ADD CONSTRAINT participate_show FOREIGN KEY participate_show (show_id)
    REFERENCES `show` (id);

-- Reference: required_equipment (table: required)
ALTER TABLE required ADD CONSTRAINT required_equipment FOREIGN KEY required_equipment (equipment_id)
    REFERENCES equipment (id);

-- Reference: required_show (table: required)
ALTER TABLE required ADD CONSTRAINT required_show FOREIGN KEY required_show (show_id)
    REFERENCES `show` (id);

-- Reference: show_event (table: show)
ALTER TABLE `show` ADD CONSTRAINT show_event FOREIGN KEY show_event (event_id)
    REFERENCES event (id);

-- End of file.


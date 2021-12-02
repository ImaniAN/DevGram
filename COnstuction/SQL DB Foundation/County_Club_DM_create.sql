-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:01:24.645

-- tables
-- Table: club
CREATE TABLE club (
    id int NOT NULL AUTO_INCREMENT,
    club_name varchar(255) NOT NULL,
    address varchar(255) NOT NULL,
    email varchar(255) NULL,
    phone varchar(255) NULL,
    mobile varchar(255) NULL,
    date_active_from date NULL COMMENT 'date esatblished',
    date_active_to date NULL,
    desctiption text NULL,
    UNIQUE INDEX club_ak_1 (club_name),
    CONSTRAINT club_pk PRIMARY KEY (id)
);

-- Table: club_in_cahrge
CREATE TABLE club_in_cahrge (
    id int NOT NULL,
    event_id int NOT NULL,
    club_id int NOT NULL,
    details text NULL,
    UNIQUE INDEX club_in_cahrge_ak_1 (event_id,club_id),
    CONSTRAINT club_in_cahrge_pk PRIMARY KEY (id)
);

-- Table: club_role
CREATE TABLE club_role (
    id int NOT NULL AUTO_INCREMENT,
    in_club_id int NOT NULL,
    role_id int NOT NULL,
    active_form date NOT NULL,
    active_to date NULL,
    is_active bool NOT NULL,
    details text NULL,
    UNIQUE INDEX club_role_ak_1 (in_club_id,role_id,active_form),
    CONSTRAINT club_role_pk PRIMARY KEY (id)
) COMMENT 'list of roles members have in clubs';

-- Table: club_section
CREATE TABLE club_section (
    id int NOT NULL AUTO_INCREMENT,
    club_id int NOT NULL,
    section_id int NOT NULL,
    date_active_from date NULL,
    date_active_to date NULL,
    description text NULL,
    CONSTRAINT club_section_pk PRIMARY KEY (id)
);

-- Table: event
CREATE TABLE event (
    id int NOT NULL AUTO_INCREMENT,
    event_name varchar(255) NOT NULL,
    start_time timestamp NOT NULL,
    end_time timestamp NULL,
    location text NULL,
    description text NULL,
    for_club_members_only bool NOT NULL,
    UNIQUE INDEX event_ak_1 (event_name),
    CONSTRAINT event_pk PRIMARY KEY (id)
);

-- Table: event_partner
CREATE TABLE event_partner (
    id int NOT NULL AUTO_INCREMENT,
    event_id int NOT NULL,
    partner_id int NOT NULL,
    details text NULL,
    UNIQUE INDEX event_partner_ak_1 (event_id,partner_id),
    CONSTRAINT event_partner_pk PRIMARY KEY (id)
);

-- Table: event_role
CREATE TABLE event_role (
    id int NOT NULL AUTO_INCREMENT,
    event_id int NOT NULL,
    section_role_id int NOT NULL,
    details text NULL,
    UNIQUE INDEX event_role_ak_1 (event_id,section_role_id),
    CONSTRAINT event_role_pk PRIMARY KEY (id)
);

-- Table: event_service
CREATE TABLE event_service (
    id int NOT NULL AUTO_INCREMENT,
    event_partner_id int NOT NULL,
    service_id int NOT NULL,
    details text NULL,
    UNIQUE INDEX event_service_ak_1 (event_partner_id,service_id),
    CONSTRAINT event_service_pk PRIMARY KEY (id)
);

-- Table: in_club
CREATE TABLE in_club (
    id int NOT NULL AUTO_INCREMENT,
    club_id int NOT NULL,
    member_id int NOT NULL,
    active_from date NOT NULL,
    active_to date NULL,
    is_active bool NOT NULL,
    details text NULL,
    UNIQUE INDEX in_club_ak_1 (club_id,member_id,active_from),
    CONSTRAINT in_club_pk PRIMARY KEY (id)
);

-- Table: in_section
CREATE TABLE in_section (
    id int NOT NULL AUTO_INCREMENT,
    club_section_id int NOT NULL,
    member_id int NOT NULL,
    active_from date NOT NULL,
    active_to date NULL,
    is_active bool NOT NULL,
    details text NULL,
    UNIQUE INDEX in_section_ak_1 (club_section_id,member_id,active_from),
    CONSTRAINT in_section_pk PRIMARY KEY (id)
);

-- Table: member
CREATE TABLE member (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(128) NOT NULL,
    last_name varchar(128) NOT NULL,
    title varchar(128) NOT NULL,
    date_of_birth date NOT NULL,
    date_of_death date NULL,
    CONSTRAINT member_pk PRIMARY KEY (id)
) COMMENT 'list of all club members';

-- Table: partner
CREATE TABLE partner (
    id int NOT NULL AUTO_INCREMENT,
    partner_name varchar(255) NOT NULL,
    address varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    phone varchar(255) NOT NULL,
    mobile varchar(255) NOT NULL,
    contact_person varchar(255) NOT NULL,
    details text NOT NULL,
    CONSTRAINT partner_pk PRIMARY KEY (id)
);

-- Table: provides_service
CREATE TABLE provides_service (
    id int NOT NULL AUTO_INCREMENT,
    partner_id int NOT NULL,
    service_id int NOT NULL,
    details text NULL,
    UNIQUE INDEX provides_service_ak_1 (partner_id,service_id),
    CONSTRAINT provides_service_pk PRIMARY KEY (id)
);

-- Table: role
CREATE TABLE role (
    id int NOT NULL AUTO_INCREMENT,
    role_name varchar(255) NOT NULL,
    is_club_role bool NOT NULL COMMENT 'if True -> this role could be assigned to club members',
    is_section_role bool NOT NULL COMMENT 'if True -> this role could be assigned to club section members',
    UNIQUE INDEX role_ak_1 (role_name),
    CONSTRAINT role_pk PRIMARY KEY (id)
) COMMENT 'list of all roles, e.g. president, secretary';

-- Table: section
CREATE TABLE section (
    id int NOT NULL AUTO_INCREMENT,
    section_name varchar(255) NOT NULL,
    UNIQUE INDEX section_ak_1 (section_name),
    CONSTRAINT section_pk PRIMARY KEY (id)
) COMMENT 'section/sport';

-- Table: section_in_charge
CREATE TABLE section_in_charge (
    id int NOT NULL,
    event_id int NOT NULL,
    club_section_id int NOT NULL,
    details text NULL,
    UNIQUE INDEX section_in_charge_ak_1 (event_id,club_section_id),
    CONSTRAINT section_in_charge_pk PRIMARY KEY (id)
);

-- Table: section_role
CREATE TABLE section_role (
    id int NOT NULL AUTO_INCREMENT,
    in_section_id int NOT NULL,
    role_id int NOT NULL,
    active_from date NOT NULL,
    active_to date NULL,
    is_active int NOT NULL,
    details text NULL,
    UNIQUE INDEX section_role_ak_1 (in_section_id,role_id,active_from),
    CONSTRAINT section_role_pk PRIMARY KEY (id)
) COMMENT 'list of roles members have in sections';

-- Table: service
CREATE TABLE service (
    id int NOT NULL AUTO_INCREMENT,
    service_name varchar(255) NOT NULL,
    UNIQUE INDEX service_ak_1 (service_name),
    CONSTRAINT service_pk PRIMARY KEY (id)
);

-- Table: visitor
CREATE TABLE visitor (
    id int NOT NULL AUTO_INCREMENT,
    event_id int NOT NULL,
    member_id int NULL,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    CONSTRAINT visitor_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: club_in_cahrge_club (table: club_in_cahrge)
ALTER TABLE club_in_cahrge ADD CONSTRAINT club_in_cahrge_club FOREIGN KEY club_in_cahrge_club (club_id)
    REFERENCES club (id);

-- Reference: club_in_cahrge_event (table: club_in_cahrge)
ALTER TABLE club_in_cahrge ADD CONSTRAINT club_in_cahrge_event FOREIGN KEY club_in_cahrge_event (event_id)
    REFERENCES event (id);

-- Reference: club_role_in_club (table: club_role)
ALTER TABLE club_role ADD CONSTRAINT club_role_in_club FOREIGN KEY club_role_in_club (in_club_id)
    REFERENCES in_club (id);

-- Reference: club_role_role (table: club_role)
ALTER TABLE club_role ADD CONSTRAINT club_role_role FOREIGN KEY club_role_role (role_id)
    REFERENCES role (id);

-- Reference: club_section_club (table: club_section)
ALTER TABLE club_section ADD CONSTRAINT club_section_club FOREIGN KEY club_section_club (club_id)
    REFERENCES club (id);

-- Reference: club_section_section (table: club_section)
ALTER TABLE club_section ADD CONSTRAINT club_section_section FOREIGN KEY club_section_section (section_id)
    REFERENCES section (id);

-- Reference: event_partner_event (table: event_partner)
ALTER TABLE event_partner ADD CONSTRAINT event_partner_event FOREIGN KEY event_partner_event (event_id)
    REFERENCES event (id);

-- Reference: event_partner_partner (table: event_partner)
ALTER TABLE event_partner ADD CONSTRAINT event_partner_partner FOREIGN KEY event_partner_partner (partner_id)
    REFERENCES partner (id);

-- Reference: event_role_event (table: event_role)
ALTER TABLE event_role ADD CONSTRAINT event_role_event FOREIGN KEY event_role_event (event_id)
    REFERENCES event (id);

-- Reference: event_role_section_role (table: event_role)
ALTER TABLE event_role ADD CONSTRAINT event_role_section_role FOREIGN KEY event_role_section_role (section_role_id)
    REFERENCES section_role (id);

-- Reference: event_service_event_partner (table: event_service)
ALTER TABLE event_service ADD CONSTRAINT event_service_event_partner FOREIGN KEY event_service_event_partner (event_partner_id)
    REFERENCES event_partner (id);

-- Reference: event_service_service (table: event_service)
ALTER TABLE event_service ADD CONSTRAINT event_service_service FOREIGN KEY event_service_service (service_id)
    REFERENCES service (id);

-- Reference: in_club_club (table: in_club)
ALTER TABLE in_club ADD CONSTRAINT in_club_club FOREIGN KEY in_club_club (club_id)
    REFERENCES club (id);

-- Reference: in_club_member (table: in_club)
ALTER TABLE in_club ADD CONSTRAINT in_club_member FOREIGN KEY in_club_member (member_id)
    REFERENCES member (id);

-- Reference: in_section_club_section (table: in_section)
ALTER TABLE in_section ADD CONSTRAINT in_section_club_section FOREIGN KEY in_section_club_section (club_section_id)
    REFERENCES club_section (id);

-- Reference: in_section_member (table: in_section)
ALTER TABLE in_section ADD CONSTRAINT in_section_member FOREIGN KEY in_section_member (member_id)
    REFERENCES member (id);

-- Reference: provides_service_partner (table: provides_service)
ALTER TABLE provides_service ADD CONSTRAINT provides_service_partner FOREIGN KEY provides_service_partner (partner_id)
    REFERENCES partner (id);

-- Reference: provides_service_service (table: provides_service)
ALTER TABLE provides_service ADD CONSTRAINT provides_service_service FOREIGN KEY provides_service_service (service_id)
    REFERENCES service (id);

-- Reference: section_in_charge_club_section (table: section_in_charge)
ALTER TABLE section_in_charge ADD CONSTRAINT section_in_charge_club_section FOREIGN KEY section_in_charge_club_section (club_section_id)
    REFERENCES club_section (id);

-- Reference: section_in_charge_event (table: section_in_charge)
ALTER TABLE section_in_charge ADD CONSTRAINT section_in_charge_event FOREIGN KEY section_in_charge_event (event_id)
    REFERENCES event (id);

-- Reference: section_role_in_section (table: section_role)
ALTER TABLE section_role ADD CONSTRAINT section_role_in_section FOREIGN KEY section_role_in_section (in_section_id)
    REFERENCES in_section (id);

-- Reference: section_role_role (table: section_role)
ALTER TABLE section_role ADD CONSTRAINT section_role_role FOREIGN KEY section_role_role (role_id)
    REFERENCES role (id);

-- Reference: visitor_event (table: visitor)
ALTER TABLE visitor ADD CONSTRAINT visitor_event FOREIGN KEY visitor_event (event_id)
    REFERENCES event (id);

-- Reference: visitor_member (table: visitor)
ALTER TABLE visitor ADD CONSTRAINT visitor_member FOREIGN KEY visitor_member (member_id)
    REFERENCES member (id);

-- End of file.


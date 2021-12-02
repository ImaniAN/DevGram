-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:08:52.673

-- tables
-- Table: can_comment
CREATE TABLE can_comment (
    id int NOT NULL AUTO_INCREMENT,
    role_id int NOT NULL,
    process_phase_id int NOT NULL,
    UNIQUE INDEX can_comment_ak_1 (role_id,process_phase_id),
    CONSTRAINT can_comment_pk PRIMARY KEY (id)
) COMMENT 'list of roles that can enter new phase and comments while subject is in that phase';

-- Table: can_initiate
CREATE TABLE can_initiate (
    id int NOT NULL AUTO_INCREMENT,
    role_id int NOT NULL,
    process_id int NOT NULL,
    UNIQUE INDEX can_initiate_ak_1 (role_id,process_id),
    CONSTRAINT can_initiate_pk PRIMARY KEY (id)
) COMMENT 'list of roles that can assign that process to a subject';

-- Table: has_role
CREATE TABLE has_role (
    id int NOT NULL AUTO_INCREMENT,
    user_account_id int NOT NULL,
    role_id int NOT NULL,
    role_start timestamp NOT NULL,
    role_end timestamp NULL,
    CONSTRAINT has_role_pk PRIMARY KEY (id)
) COMMENT 'check roles for overlapping before adding new or updating existing';

-- Table: item
CREATE TABLE item (
    id int NOT NULL AUTO_INCREMENT,
    item_code varchar(255) NOT NULL COMMENT 'unique subject designation like internal code, project name etc.',
    item_type_id int NOT NULL,
    description text NULL,
    UNIQUE INDEX subject_ak_1 (item_code),
    CONSTRAINT item_pk PRIMARY KEY (id)
);

-- Table: item_phase
CREATE TABLE item_phase (
    id int NOT NULL AUTO_INCREMENT,
    item_process_id int NOT NULL,
    process_phase_id int NOT NULL,
    phase_started timestamp NOT NULL,
    phase_ended timestamp NULL,
    has_role_id int NOT NULL COMMENT 'user who inserted this phase',
    CONSTRAINT item_phase_pk PRIMARY KEY (id)
) COMMENT 'list of all phases itemwent during that process';

-- Table: item_process
CREATE TABLE item_process (
    id int NOT NULL AUTO_INCREMENT,
    item_id int NOT NULL,
    process_id int NOT NULL,
    process_started timestamp NOT NULL,
    process_ended timestamp NULL,
    completed_succesfully bool NULL COMMENT 'set to "True" if process_phase.final = "True" and process_phase.normal_flow = "True"; set to "True" if process_phase.final = "True" and process_phase.normal_flow = "False"; otherwise it''''s NULL',
    is_last_process bool NOT NULL COMMENT 'if that process is the one used last - in case we have few records for the same subject in this table, only one can have this attribute set to "True"',
    has_role_id int NOT NULL COMMENT 'user who initiated this process',
    CONSTRAINT item_process_pk PRIMARY KEY (id)
) COMMENT 'which process was used for that item - same item could use few processes (start one process, terminate it and use the other), but only one can be active at the time';

-- Table: item_type
CREATE TABLE item_type (
    id int NOT NULL AUTO_INCREMENT,
    item_type_name varchar(128) NOT NULL,
    UNIQUE INDEX subject_type_ak_1 (item_type_name),
    CONSTRAINT item_type_pk PRIMARY KEY (id)
) COMMENT 'product, task, ...';

-- Table: phase
CREATE TABLE phase (
    id int NOT NULL AUTO_INCREMENT,
    phase_name varchar(128) NOT NULL COMMENT 'unique phase name',
    UNIQUE INDEX phase_ak_1 (phase_name),
    CONSTRAINT phase_pk PRIMARY KEY (id)
);

-- Table: phase_comment
CREATE TABLE phase_comment (
    id int NOT NULL AUTO_INCREMENT,
    item_phase_id int NOT NULL,
    has_role_id int NOT NULL,
    comment_time timestamp NOT NULL,
    comment_text text NOT NULL,
    CONSTRAINT phase_comment_pk PRIMARY KEY (id)
) COMMENT 'list of comments users inserted for that phase';

-- Table: prerequisite_phase
CREATE TABLE prerequisite_phase (
    id int NOT NULL AUTO_INCREMENT,
    prerequisite_process_phase_id int NOT NULL,
    process_phase_id int NOT NULL,
    UNIQUE INDEX prerequisite_phase_ak_1 (prerequisite_process_phase_id,process_phase_id),
    CONSTRAINT prerequisite_phase_pk PRIMARY KEY (id)
) COMMENT 'phases that should be completed before we can start with this phase; one phase could have 0 to N prerequisite phases; phase should have greater phase_order number then all its'''' prerequisite phases';

-- Table: process
CREATE TABLE process (
    id int NOT NULL AUTO_INCREMENT,
    process_name varchar(128) NOT NULL,
    used_from date NOT NULL COMMENT 'date when we started using this process in our company',
    used_to date NULL COMMENT 'day when we stopped using this process - if is_active = "False", this day should be set',
    is_active bool NOT NULL COMMENT 'do we currently use this process in our company? maybe we used process till some time and then stopped useing it',
    UNIQUE INDEX process_ak_1 (process_name),
    CONSTRAINT process_pk PRIMARY KEY (id)
);

-- Table: process_list
CREATE TABLE process_list (
    id int NOT NULL,
    item_type_id int NOT NULL,
    process_id int NOT NULL,
    UNIQUE INDEX process_list_ak_1 (item_type_id,process_id),
    CONSTRAINT process_list_pk PRIMARY KEY (id)
) COMMENT 'which process could be applied on that subject type';

-- Table: process_phase
CREATE TABLE process_phase (
    id int NOT NULL AUTO_INCREMENT,
    process_id int NOT NULL,
    phase_id int NOT NULL,
    phase_order int NOT NULL COMMENT 'few phases could have same phase_order',
    description text NULL COMMENT 'explanation what should be done in this phase or similar, if needed',
    is_final bool NOT NULL COMMENT 'is that final phase in a process',
    normal_flow bool NOT NULL COMMENT 'if process completed successfully if that is a final phase? does process flows normally if that is not the final phase?',
    CONSTRAINT process_phase_pk PRIMARY KEY (id)
) COMMENT 'is phase in that process?';

-- Table: resource
CREATE TABLE resource (
    id int NOT NULL AUTO_INCREMENT,
    resource_name varchar(128) NOT NULL,
    UNIQUE INDEX resource_ak_1 (resource_name),
    CONSTRAINT resource_pk PRIMARY KEY (id)
) COMMENT 'e.g. machine, material etc.';

-- Table: resource_required
CREATE TABLE resource_required (
    id int NOT NULL AUTO_INCREMENT,
    phase_id int NOT NULL,
    resource_id int NOT NULL,
    resource_unit_catalog_id int NOT NULL,
    required decimal(8,2) NOT NULL,
    UNIQUE INDEX resource_required_ak_1 (phase_id,resource_id),
    CONSTRAINT resource_required_pk PRIMARY KEY (id)
) COMMENT 'resource quantity required for that resource measured in the selected unit';

-- Table: resource_unit
CREATE TABLE resource_unit (
    id int NOT NULL AUTO_INCREMENT,
    resource_id int NOT NULL,
    resource_unit_catalog_id int NOT NULL,
    UNIQUE INDEX resource_unit_ak_1 (resource_id,resource_unit_catalog_id),
    CONSTRAINT resource_unit_pk PRIMARY KEY (id)
) COMMENT 'list of all units that can be used to measure that resource';

-- Table: resource_unit_catalog
CREATE TABLE resource_unit_catalog (
    id int NOT NULL AUTO_INCREMENT,
    unit_name varchar(128) NOT NULL,
    UNIQUE INDEX resource_unit_catalog_ak_1 (unit_name),
    CONSTRAINT resource_unit_catalog_pk PRIMARY KEY (id)
) COMMENT 'e.g. hour (how many hours we need to use that machine), kg (how many kg of material is needed)';

-- Table: resource_used
CREATE TABLE resource_used (
    id int NOT NULL AUTO_INCREMENT,
    item_phase_id int NOT NULL,
    resource_required_id int NOT NULL,
    used decimal(8,2) NOT NULL,
    CONSTRAINT resource_used_pk PRIMARY KEY (id)
) COMMENT 'actual resources used';

-- Table: role
CREATE TABLE role (
    id int NOT NULL AUTO_INCREMENT,
    role_name varchar(128) NOT NULL,
    UNIQUE INDEX role_ak_1 (role_name),
    CONSTRAINT role_pk PRIMARY KEY (id)
);

-- Table: time_required
CREATE TABLE time_required (
    id int NOT NULL AUTO_INCREMENT,
    phase_id int NOT NULL,
    role_id int NOT NULL,
    time_unit_id int NOT NULL,
    required decimal(8,2) NOT NULL,
    UNIQUE INDEX time_required_ak_1 (phase_id),
    CONSTRAINT time_required_pk PRIMARY KEY (id)
) COMMENT 'how much time is required for that role measured in the selected unit; user with that role is also available to enter new data related with the subject (comment, new phases)';

-- Table: time_unit_catalog
CREATE TABLE time_unit_catalog (
    id int NOT NULL AUTO_INCREMENT,
    unit_name varchar(128) NOT NULL,
    UNIQUE INDEX time_unit_ak_1 (unit_name),
    CONSTRAINT time_unit_catalog_pk PRIMARY KEY (id)
) COMMENT 'e.g. week, day, hour...';

-- Table: time_used
CREATE TABLE time_used (
    id int NOT NULL AUTO_INCREMENT,
    item_phase_id int NOT NULL,
    time_required_id int NOT NULL,
    used decimal(8,2) NOT NULL,
    has_role_id int NOT NULL,
    CONSTRAINT time_used_pk PRIMARY KEY (id)
) COMMENT 'actual time devoted - with user in that role';

-- Table: user_account
CREATE TABLE user_account (
    id int NOT NULL AUTO_INCREMENT,
    username varchar(64) NOT NULL,
    password varchar(64) NOT NULL,
    email varchar(255) NOT NULL,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    UNIQUE INDEX user_account_ak_1 (username),
    UNIQUE INDEX user_account_ak_2 (email),
    CONSTRAINT user_account_pk PRIMARY KEY (id)
) COMMENT 'list of all users that can use the system';

-- foreign keys
-- Reference: can_comment_process_phase (table: can_comment)
ALTER TABLE can_comment ADD CONSTRAINT can_comment_process_phase FOREIGN KEY can_comment_process_phase (process_phase_id)
    REFERENCES process_phase (id);

-- Reference: can_comment_role (table: can_comment)
ALTER TABLE can_comment ADD CONSTRAINT can_comment_role FOREIGN KEY can_comment_role (role_id)
    REFERENCES role (id);

-- Reference: can_initiate_process (table: can_initiate)
ALTER TABLE can_initiate ADD CONSTRAINT can_initiate_process FOREIGN KEY can_initiate_process (process_id)
    REFERENCES process (id);

-- Reference: can_initiate_role (table: can_initiate)
ALTER TABLE can_initiate ADD CONSTRAINT can_initiate_role FOREIGN KEY can_initiate_role (role_id)
    REFERENCES role (id);

-- Reference: has_role_role (table: has_role)
ALTER TABLE has_role ADD CONSTRAINT has_role_role FOREIGN KEY has_role_role (role_id)
    REFERENCES role (id);

-- Reference: has_role_user_account (table: has_role)
ALTER TABLE has_role ADD CONSTRAINT has_role_user_account FOREIGN KEY has_role_user_account (user_account_id)
    REFERENCES user_account (id);

-- Reference: in_phase_has_role (table: item_phase)
ALTER TABLE item_phase ADD CONSTRAINT in_phase_has_role FOREIGN KEY in_phase_has_role (has_role_id)
    REFERENCES has_role (id);

-- Reference: in_phase_process_phase (table: item_phase)
ALTER TABLE item_phase ADD CONSTRAINT in_phase_process_phase FOREIGN KEY in_phase_process_phase (process_phase_id)
    REFERENCES process_phase (id);

-- Reference: in_phase_process_used (table: item_phase)
ALTER TABLE item_phase ADD CONSTRAINT in_phase_process_used FOREIGN KEY in_phase_process_used (item_process_id)
    REFERENCES item_process (id);

-- Reference: phase_comment_has_role (table: phase_comment)
ALTER TABLE phase_comment ADD CONSTRAINT phase_comment_has_role FOREIGN KEY phase_comment_has_role (has_role_id)
    REFERENCES has_role (id);

-- Reference: phase_comment_in_phase (table: phase_comment)
ALTER TABLE phase_comment ADD CONSTRAINT phase_comment_in_phase FOREIGN KEY phase_comment_in_phase (item_phase_id)
    REFERENCES item_phase (id);

-- Reference: prerequisite_phase_process_phase_phase_id (table: prerequisite_phase)
ALTER TABLE prerequisite_phase ADD CONSTRAINT prerequisite_phase_process_phase_phase_id FOREIGN KEY prerequisite_phase_process_phase_phase_id (process_phase_id)
    REFERENCES process_phase (id);

-- Reference: prerequisite_phase_process_phase_prerequisite_id (table: prerequisite_phase)
ALTER TABLE prerequisite_phase ADD CONSTRAINT prerequisite_phase_process_phase_prerequisite_id FOREIGN KEY prerequisite_phase_process_phase_prerequisite_id (prerequisite_process_phase_id)
    REFERENCES process_phase (id);

-- Reference: process_list_process (table: process_list)
ALTER TABLE process_list ADD CONSTRAINT process_list_process FOREIGN KEY process_list_process (process_id)
    REFERENCES process (id);

-- Reference: process_list_subject_type (table: process_list)
ALTER TABLE process_list ADD CONSTRAINT process_list_subject_type FOREIGN KEY process_list_subject_type (item_type_id)
    REFERENCES item_type (id);

-- Reference: process_phase_phase (table: process_phase)
ALTER TABLE process_phase ADD CONSTRAINT process_phase_phase FOREIGN KEY process_phase_phase (phase_id)
    REFERENCES phase (id);

-- Reference: process_phase_process (table: process_phase)
ALTER TABLE process_phase ADD CONSTRAINT process_phase_process FOREIGN KEY process_phase_process (process_id)
    REFERENCES process (id);

-- Reference: process_used_has_role (table: item_process)
ALTER TABLE item_process ADD CONSTRAINT process_used_has_role FOREIGN KEY process_used_has_role (has_role_id)
    REFERENCES has_role (id);

-- Reference: process_used_process (table: item_process)
ALTER TABLE item_process ADD CONSTRAINT process_used_process FOREIGN KEY process_used_process (process_id)
    REFERENCES process (id);

-- Reference: process_used_subject (table: item_process)
ALTER TABLE item_process ADD CONSTRAINT process_used_subject FOREIGN KEY process_used_subject (item_id)
    REFERENCES item (id);

-- Reference: resource_required_phase (table: resource_required)
ALTER TABLE resource_required ADD CONSTRAINT resource_required_phase FOREIGN KEY resource_required_phase (phase_id)
    REFERENCES phase (id);

-- Reference: resource_required_resource (table: resource_required)
ALTER TABLE resource_required ADD CONSTRAINT resource_required_resource FOREIGN KEY resource_required_resource (resource_id)
    REFERENCES resource (id);

-- Reference: resource_required_resource_unit (table: resource_required)
ALTER TABLE resource_required ADD CONSTRAINT resource_required_resource_unit FOREIGN KEY resource_required_resource_unit (resource_unit_catalog_id)
    REFERENCES resource_unit_catalog (id);

-- Reference: resource_unit_resource (table: resource_unit)
ALTER TABLE resource_unit ADD CONSTRAINT resource_unit_resource FOREIGN KEY resource_unit_resource (resource_id)
    REFERENCES resource (id);

-- Reference: resource_unit_resource_unit_catalog (table: resource_unit)
ALTER TABLE resource_unit ADD CONSTRAINT resource_unit_resource_unit_catalog FOREIGN KEY resource_unit_resource_unit_catalog (resource_unit_catalog_id)
    REFERENCES resource_unit_catalog (id);

-- Reference: resource_used_in_phase (table: resource_used)
ALTER TABLE resource_used ADD CONSTRAINT resource_used_in_phase FOREIGN KEY resource_used_in_phase (item_phase_id)
    REFERENCES item_phase (id);

-- Reference: resource_used_resource_required (table: resource_used)
ALTER TABLE resource_used ADD CONSTRAINT resource_used_resource_required FOREIGN KEY resource_used_resource_required (resource_required_id)
    REFERENCES resource_required (id);

-- Reference: subject_subject_type (table: item)
ALTER TABLE item ADD CONSTRAINT subject_subject_type FOREIGN KEY subject_subject_type (item_type_id)
    REFERENCES item_type (id);

-- Reference: time_required_phase (table: time_required)
ALTER TABLE time_required ADD CONSTRAINT time_required_phase FOREIGN KEY time_required_phase (phase_id)
    REFERENCES phase (id);

-- Reference: time_required_role (table: time_required)
ALTER TABLE time_required ADD CONSTRAINT time_required_role FOREIGN KEY time_required_role (role_id)
    REFERENCES role (id);

-- Reference: time_required_time_unit (table: time_required)
ALTER TABLE time_required ADD CONSTRAINT time_required_time_unit FOREIGN KEY time_required_time_unit (time_unit_id)
    REFERENCES time_unit_catalog (id);

-- Reference: time_used_has_role (table: time_used)
ALTER TABLE time_used ADD CONSTRAINT time_used_has_role FOREIGN KEY time_used_has_role (has_role_id)
    REFERENCES has_role (id);

-- Reference: time_used_in_phase (table: time_used)
ALTER TABLE time_used ADD CONSTRAINT time_used_in_phase FOREIGN KEY time_used_in_phase (item_phase_id)
    REFERENCES item_phase (id);

-- Reference: time_used_time_required (table: time_used)
ALTER TABLE time_used ADD CONSTRAINT time_used_time_required FOREIGN KEY time_used_time_required (time_required_id)
    REFERENCES time_required (id);

-- End of file.


-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:57:19.545

-- tables
-- Table: availability
CREATE TABLE availability (
    id int NOT NULL AUTO_INCREMENT,
    availability_name varchar(64) NOT NULL,
    UNIQUE INDEX availability_ak_1 (availability_name),
    CONSTRAINT availability_pk PRIMARY KEY (id)
);

-- Table: customer
CREATE TABLE customer (
    id int NOT NULL AUTO_INCREMENT,
    user_name varchar(64) NOT NULL,
    password varchar(64) NOT NULL,
    customer_name varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    mobile varchar(255) NOT NULL,
    details text NOT NULL,
    UNIQUE INDEX customer_ak_1 (user_name),
    CONSTRAINT customer_pk PRIMARY KEY (id)
);

-- Table: freelancer
CREATE TABLE freelancer (
    id int NOT NULL AUTO_INCREMENT,
    user_name varchar(64) NOT NULL,
    password varchar(255) NOT NULL,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    email varchar(255) NOT NULL,
    mobile varchar(255) NOT NULL,
    current_availability_id int NOT NULL,
    UNIQUE INDEX freelancer_ak_1 (user_name),
    CONSTRAINT freelancer_pk PRIMARY KEY (id)
);

-- Table: has_skill
CREATE TABLE has_skill (
    id int NOT NULL AUTO_INCREMENT,
    freelancer_id int NOT NULL,
    skill_id int NOT NULL,
    skill_level_id int NOT NULL,
    UNIQUE INDEX has_skill_ak_1 (freelancer_id,skill_id),
    CONSTRAINT has_skill_pk PRIMARY KEY (id)
);

-- Table: in_charge
CREATE TABLE in_charge (
    id int NOT NULL AUTO_INCREMENT,
    team_id int NOT NULL,
    phase_plan_id int NOT NULL,
    UNIQUE INDEX in_charge_ak_1 (team_id,phase_plan_id),
    CONSTRAINT in_charge_pk PRIMARY KEY (id)
);

-- Table: on_project
CREATE TABLE on_project (
    id int NOT NULL AUTO_INCREMENT,
    team_id int NOT NULL,
    project_id int NOT NULL,
    start_date date NOT NULL,
    end_date date NULL,
    CONSTRAINT on_project_pk PRIMARY KEY (id)
);

-- Table: phase_catalog
CREATE TABLE phase_catalog (
    id int NOT NULL AUTO_INCREMENT,
    phase_catalog_name varchar(255) NOT NULL,
    project_outcome_id int NULL,
    UNIQUE INDEX phase_catalog_ak_1 (phase_catalog_name),
    CONSTRAINT phase_catalog_pk PRIMARY KEY (id)
);

-- Table: phase_history
CREATE TABLE phase_history (
    id int NOT NULL AUTO_INCREMENT,
    freelancer_id int NULL,
    customer_id int NULL,
    project_id int NOT NULL,
    phase_catalog_id int NOT NULL,
    start_time timestamp NOT NULL,
    end_time timestamp NOT NULL,
    comment text NULL,
    CONSTRAINT phase_history_pk PRIMARY KEY (id)
);

-- Table: phase_plan
CREATE TABLE phase_plan (
    id int NOT NULL AUTO_INCREMENT,
    project_id int NOT NULL,
    phase_catalog_id int NOT NULL,
    start_time_planned timestamp NOT NULL,
    end_time_planned timestamp NOT NULL,
    comment text NULL,
    freelancer_id int NOT NULL,
    CONSTRAINT phase_plan_pk PRIMARY KEY (id)
);

-- Table: project
CREATE TABLE project (
    id int NOT NULL AUTO_INCREMENT,
    customer_id int NOT NULL,
    project_name varchar(255) NOT NULL,
    description text NOT NULL,
    budget_plan decimal(12,2) NOT NULL COMMENT 'client plan',
    budget_estimate decimal(12,2) NOT NULL COMMENT 'team estimate',
    budget_actual decimal(12,2) NOT NULL,
    amount_paid decimal(12,2) NOT NULL,
    project_outcome_id int NOT NULL,
    CONSTRAINT project_pk PRIMARY KEY (id)
);

-- Table: project_outcome
CREATE TABLE project_outcome (
    id int NOT NULL AUTO_INCREMENT,
    outcome_name varchar(255) NOT NULL,
    ongoing bool NOT NULL,
    on_hold bool NOT NULL,
    is_completed_successfully bool NOT NULL,
    is_completed_unsuccessfully bool NOT NULL,
    UNIQUE INDEX project_outcome_ak_1 (outcome_name),
    CONSTRAINT project_outcome_pk PRIMARY KEY (id)
);

-- Table: project_status_history
CREATE TABLE project_status_history (
    id int NOT NULL AUTO_INCREMENT,
    project_id int NOT NULL,
    project_outcome_id int NOT NULL,
    details text NOT NULL,
    ts timestamp NOT NULL,
    CONSTRAINT project_status_history_pk PRIMARY KEY (id)
);

-- Table: skill
CREATE TABLE skill (
    id int NOT NULL AUTO_INCREMENT,
    skill_name varchar(64) NOT NULL,
    UNIQUE INDEX skill_ak_1 (skill_name),
    CONSTRAINT skill_pk PRIMARY KEY (id)
);

-- Table: skill_level
CREATE TABLE skill_level (
    id int NOT NULL,
    level varchar(32) NOT NULL,
    UNIQUE INDEX skill_level_ak_1 (level),
    CONSTRAINT skill_level_pk PRIMARY KEY (id)
) COMMENT 'e.g. - basic, advanced, expert';

-- Table: skill_required
CREATE TABLE skill_required (
    id int NOT NULL AUTO_INCREMENT,
    project_id int NOT NULL,
    skill_id int NOT NULL,
    UNIQUE INDEX skill_required_ak_1 (project_id,skill_id),
    CONSTRAINT skill_required_pk PRIMARY KEY (id)
);

-- Table: team
CREATE TABLE team (
    id int NOT NULL AUTO_INCREMENT,
    team_name varchar(128) NOT NULL,
    description text NOT NULL,
    CONSTRAINT team_pk PRIMARY KEY (id)
) COMMENT 'teams are created for each project separately; project could have more than 1 team involved;';

-- Table: team_member
CREATE TABLE team_member (
    id int NOT NULL AUTO_INCREMENT,
    team_id int NOT NULL,
    freelancer_id int NOT NULL,
    hours_worked int NOT NULL,
    UNIQUE INDEX team_member_ak_1 (team_id,freelancer_id),
    CONSTRAINT team_member_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: freelancer_availability (table: freelancer)
ALTER TABLE freelancer ADD CONSTRAINT freelancer_availability FOREIGN KEY freelancer_availability (current_availability_id)
    REFERENCES availability (id);

-- Reference: has_skill_freelancer (table: has_skill)
ALTER TABLE has_skill ADD CONSTRAINT has_skill_freelancer FOREIGN KEY has_skill_freelancer (freelancer_id)
    REFERENCES freelancer (id);

-- Reference: has_skill_skill (table: has_skill)
ALTER TABLE has_skill ADD CONSTRAINT has_skill_skill FOREIGN KEY has_skill_skill (skill_id)
    REFERENCES skill (id);

-- Reference: has_skill_skill_level (table: has_skill)
ALTER TABLE has_skill ADD CONSTRAINT has_skill_skill_level FOREIGN KEY has_skill_skill_level (skill_level_id)
    REFERENCES skill_level (id);

-- Reference: in_charge_phase_plan (table: in_charge)
ALTER TABLE in_charge ADD CONSTRAINT in_charge_phase_plan FOREIGN KEY in_charge_phase_plan (phase_plan_id)
    REFERENCES phase_plan (id);

-- Reference: in_charge_team (table: in_charge)
ALTER TABLE in_charge ADD CONSTRAINT in_charge_team FOREIGN KEY in_charge_team (team_id)
    REFERENCES team (id);

-- Reference: on_project_project (table: on_project)
ALTER TABLE on_project ADD CONSTRAINT on_project_project FOREIGN KEY on_project_project (project_id)
    REFERENCES project (id);

-- Reference: on_project_team (table: on_project)
ALTER TABLE on_project ADD CONSTRAINT on_project_team FOREIGN KEY on_project_team (team_id)
    REFERENCES team (id);

-- Reference: phase_catalog_project_outcome (table: phase_catalog)
ALTER TABLE phase_catalog ADD CONSTRAINT phase_catalog_project_outcome FOREIGN KEY phase_catalog_project_outcome (project_outcome_id)
    REFERENCES project_outcome (id);

-- Reference: phase_history_customer (table: phase_history)
ALTER TABLE phase_history ADD CONSTRAINT phase_history_customer FOREIGN KEY phase_history_customer (customer_id)
    REFERENCES customer (id);

-- Reference: phase_history_freelancer (table: phase_history)
ALTER TABLE phase_history ADD CONSTRAINT phase_history_freelancer FOREIGN KEY phase_history_freelancer (freelancer_id)
    REFERENCES freelancer (id);

-- Reference: phase_history_phase_catalog (table: phase_history)
ALTER TABLE phase_history ADD CONSTRAINT phase_history_phase_catalog FOREIGN KEY phase_history_phase_catalog (phase_catalog_id)
    REFERENCES phase_catalog (id);

-- Reference: phase_history_project (table: phase_history)
ALTER TABLE phase_history ADD CONSTRAINT phase_history_project FOREIGN KEY phase_history_project (project_id)
    REFERENCES project (id);

-- Reference: phase_plan_freelancer (table: phase_plan)
ALTER TABLE phase_plan ADD CONSTRAINT phase_plan_freelancer FOREIGN KEY phase_plan_freelancer (freelancer_id)
    REFERENCES freelancer (id);

-- Reference: phase_plan_phase_catalog (table: phase_plan)
ALTER TABLE phase_plan ADD CONSTRAINT phase_plan_phase_catalog FOREIGN KEY phase_plan_phase_catalog (phase_catalog_id)
    REFERENCES phase_catalog (id);

-- Reference: phase_plan_project (table: phase_plan)
ALTER TABLE phase_plan ADD CONSTRAINT phase_plan_project FOREIGN KEY phase_plan_project (project_id)
    REFERENCES project (id);

-- Reference: project_customer (table: project)
ALTER TABLE project ADD CONSTRAINT project_customer FOREIGN KEY project_customer (customer_id)
    REFERENCES customer (id);

-- Reference: project_project_outcome (table: project)
ALTER TABLE project ADD CONSTRAINT project_project_outcome FOREIGN KEY project_project_outcome (project_outcome_id)
    REFERENCES project_outcome (id);

-- Reference: project_status_history_project (table: project_status_history)
ALTER TABLE project_status_history ADD CONSTRAINT project_status_history_project FOREIGN KEY project_status_history_project (project_id)
    REFERENCES project (id);

-- Reference: project_status_history_project_outcome (table: project_status_history)
ALTER TABLE project_status_history ADD CONSTRAINT project_status_history_project_outcome FOREIGN KEY project_status_history_project_outcome (project_outcome_id)
    REFERENCES project_outcome (id);

-- Reference: skill_required_project (table: skill_required)
ALTER TABLE skill_required ADD CONSTRAINT skill_required_project FOREIGN KEY skill_required_project (project_id)
    REFERENCES project (id);

-- Reference: skill_required_skill (table: skill_required)
ALTER TABLE skill_required ADD CONSTRAINT skill_required_skill FOREIGN KEY skill_required_skill (skill_id)
    REFERENCES skill (id);

-- Reference: team_member_freelancer (table: team_member)
ALTER TABLE team_member ADD CONSTRAINT team_member_freelancer FOREIGN KEY team_member_freelancer (freelancer_id)
    REFERENCES freelancer (id);

-- Reference: team_member_team (table: team_member)
ALTER TABLE team_member ADD CONSTRAINT team_member_team FOREIGN KEY team_member_team (team_id)
    REFERENCES team (id);

-- End of file.


-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:07:01.693

-- tables
-- Table: comment
CREATE TABLE comment (
    id int NOT NULL AUTO_INCREMENT,
    project_id int NOT NULL,
    user_account_id int NOT NULL,
    comment_text text NOT NULL,
    ts timestamp NOT NULL,
    CONSTRAINT comment_pk PRIMARY KEY (id)
) COMMENT 'all comments related with projects';

-- Table: country
CREATE TABLE country (
    id int NOT NULL AUTO_INCREMENT,
    country_name varchar(255) NOT NULL,
    UNIQUE INDEX country_ak_1 (country_name),
    CONSTRAINT country_pk PRIMARY KEY (id)
);

-- Table: investment_option_catalog
CREATE TABLE investment_option_catalog (
    id int NOT NULL AUTO_INCREMENT,
    option_name varchar(255) NOT NULL,
    funds_min decimal(12,2) NOT NULL,
    funds_max decimal(12,2) NOT NULL,
    UNIQUE INDEX investment_option_catalog_ak_1 (option_name),
    CONSTRAINT investment_option_catalog_pk PRIMARY KEY (id)
) COMMENT 'list of predefined project investment options';

-- Table: material
CREATE TABLE material (
    id int NOT NULL AUTO_INCREMENT,
    project_id int NOT NULL,
    material_type_id int NOT NULL,
    description text NULL,
    link text NOT NULL,
    CONSTRAINT material_pk PRIMARY KEY (id)
) COMMENT 'all materials (videos, texts, charts, infographics,etc.) related with the project description';

-- Table: material_type
CREATE TABLE material_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(32) NOT NULL,
    UNIQUE INDEX material_type_ak_1 (type_name),
    CONSTRAINT material_type_pk PRIMARY KEY (id)
) COMMENT 'video, project info video, infographics, chart, text, document...';

-- Table: organization
CREATE TABLE organization (
    id int NOT NULL AUTO_INCREMENT,
    organization_name varchar(255) NOT NULL,
    details text NULL,
    CONSTRAINT organization_pk PRIMARY KEY (id)
) COMMENT 'list of all organizations related with projects';

-- Table: parameters
CREATE TABLE parameters (
    id int NOT NULL AUTO_INCREMENT,
    project_id int NOT NULL,
    end_date date NOT NULL,
    goal decimal(12,2) NOT NULL,
    ts timestamp NOT NULL,
    CONSTRAINT parameters_pk PRIMARY KEY (id)
) COMMENT 'history of project parameters changes';

-- Table: participant
CREATE TABLE participant (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    title varchar(64) NOT NULL,
    description text NOT NULL,
    user_account_id int NULL,
    organization_id int NULL,
    participated_in int NOT NULL COMMENT 'number of projects where this participant was in the team',
    CONSTRAINT participant_pk PRIMARY KEY (id)
);

-- Table: project
CREATE TABLE project (
    id int NOT NULL AUTO_INCREMENT,
    project_name varchar(255) NOT NULL,
    organization_id int NOT NULL,
    user_account_id int NOT NULL,
    project_description text NOT NULL COMMENT 'detailed description of  the project',
    project_location text NOT NULL COMMENT 'e.g. NY, USA',
    start_date date NOT NULL,
    end_date date NOT NULL COMMENT 'current project end_date (if we make a change we''''ll insert new record to the parameters table)',
    goal decimal(12,2) NOT NULL COMMENT 'current project goal (if we make a change we''''ll insert new record to the parameters table)',
    pledged decimal(12,2) NOT NULL COMMENT 'funds currently pledged to the project',
    investors int NOT NULL COMMENT 'current # of investors',
    project_status_id int NOT NULL,
    CONSTRAINT project_pk PRIMARY KEY (id)
) COMMENT 'list of all projects';

-- Table: project_investment_option
CREATE TABLE project_investment_option (
    id int NOT NULL AUTO_INCREMENT,
    project_id int NOT NULL,
    investment_option_catalog_id int NOT NULL,
    option_name varchar(255) NOT NULL COMMENT 'same as investment_option_catalog.option_name (generic) or more specific one we''''ve chosen',
    option_description text NOT NULL COMMENT 'includes..., estimated delivery..., shipping details...',
    CONSTRAINT project_investment_option_pk PRIMARY KEY (id)
) COMMENT 'list of selected investment options for projects';

-- Table: project_investor
CREATE TABLE project_investor (
    id int NOT NULL AUTO_INCREMENT,
    project_id int NOT NULL,
    user_account_id int NOT NULL,
    project_investment_option_id int NOT NULL,
    pledged decimal(12,2) NOT NULL,
    ts timestamp NOT NULL COMMENT 'timestamp when this investment happened',
    CONSTRAINT project_investor_pk PRIMARY KEY (id)
) COMMENT 'list of all investors/backers related with this project';

-- Table: project_status
CREATE TABLE project_status (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(64) NOT NULL,
    UNIQUE INDEX project_status_ak_1 (status_name),
    CONSTRAINT project_status_pk PRIMARY KEY (id)
) COMMENT 'project status catalog';

-- Table: project_status_history
CREATE TABLE project_status_history (
    id int NOT NULL AUTO_INCREMENT,
    project_id int NOT NULL,
    project_status_id int NOT NULL,
    ts timestamp NOT NULL,
    CONSTRAINT project_status_history_pk PRIMARY KEY (id)
) COMMENT 'list pf all statuses for all projects';

-- Table: project_team
CREATE TABLE project_team (
    id int NOT NULL AUTO_INCREMENT,
    project_id int NOT NULL,
    role_id int NOT NULL,
    participant_id int NOT NULL,
    participant_responsibilities text NULL COMMENT 'description of participant''''s responsibilities on this project',
    UNIQUE INDEX project_team_ak_1 (project_id,role_id),
    CONSTRAINT project_team_pk PRIMARY KEY (id)
) COMMENT 'project team members';

-- Table: role
CREATE TABLE role (
    id int NOT NULL AUTO_INCREMENT,
    role_name varchar(64) NOT NULL,
    UNIQUE INDEX role_ak_1 (role_name),
    CONSTRAINT role_pk PRIMARY KEY (id)
) COMMENT 'list of all possible roles on any project';

-- Table: update
CREATE TABLE `update` (
    id int NOT NULL AUTO_INCREMENT,
    project_id int NOT NULL,
    user_account_id int NOT NULL,
    update_text text NOT NULL,
    ts timestamp NOT NULL,
    CONSTRAINT update_pk PRIMARY KEY (id)
) COMMENT 'all updates related with projects';

-- Table: user_account
CREATE TABLE user_account (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    user_name varchar(128) NOT NULL,
    password varchar(255) NOT NULL,
    email varchar(128) NOT NULL,
    projects_supported int NOT NULL COMMENT 'number of projects this user invested in',
    total_amount decimal(12,2) NOT NULL COMMENT 'amount sum for all projects user invested in',
    country_id int NOT NULL COMMENT 'important for shipping',
    UNIQUE INDEX user_account_ak_1 (user_name),
    UNIQUE INDEX user_account_ak_2 (email),
    CONSTRAINT user_account_pk PRIMARY KEY (id)
) COMMENT 'all registered user on our site';

-- foreign keys
-- Reference: comments_project (table: comment)
ALTER TABLE comment ADD CONSTRAINT comments_project FOREIGN KEY comments_project (project_id)
    REFERENCES project (id);

-- Reference: comments_user_account (table: comment)
ALTER TABLE comment ADD CONSTRAINT comments_user_account FOREIGN KEY comments_user_account (user_account_id)
    REFERENCES user_account (id);

-- Reference: material_material_type (table: material)
ALTER TABLE material ADD CONSTRAINT material_material_type FOREIGN KEY material_material_type (material_type_id)
    REFERENCES material_type (id);

-- Reference: material_project (table: material)
ALTER TABLE material ADD CONSTRAINT material_project FOREIGN KEY material_project (project_id)
    REFERENCES project (id);

-- Reference: parameters_project (table: parameters)
ALTER TABLE parameters ADD CONSTRAINT parameters_project FOREIGN KEY parameters_project (project_id)
    REFERENCES project (id);

-- Reference: participant_organization (table: participant)
ALTER TABLE participant ADD CONSTRAINT participant_organization FOREIGN KEY participant_organization (organization_id)
    REFERENCES organization (id);

-- Reference: participant_user_account (table: participant)
ALTER TABLE participant ADD CONSTRAINT participant_user_account FOREIGN KEY participant_user_account (user_account_id)
    REFERENCES user_account (id);

-- Reference: project_investment_option_investment_option_catalog (table: project_investment_option)
ALTER TABLE project_investment_option ADD CONSTRAINT project_investment_option_investment_option_catalog FOREIGN KEY project_investment_option_investment_option_catalog (investment_option_catalog_id)
    REFERENCES investment_option_catalog (id);

-- Reference: project_investment_option_project (table: project_investment_option)
ALTER TABLE project_investment_option ADD CONSTRAINT project_investment_option_project FOREIGN KEY project_investment_option_project (project_id)
    REFERENCES project (id);

-- Reference: project_investor_project (table: project_investor)
ALTER TABLE project_investor ADD CONSTRAINT project_investor_project FOREIGN KEY project_investor_project (project_id)
    REFERENCES project (id);

-- Reference: project_investor_project_investment_option (table: project_investor)
ALTER TABLE project_investor ADD CONSTRAINT project_investor_project_investment_option FOREIGN KEY project_investor_project_investment_option (project_investment_option_id)
    REFERENCES project_investment_option (id);

-- Reference: project_investor_user_account (table: project_investor)
ALTER TABLE project_investor ADD CONSTRAINT project_investor_user_account FOREIGN KEY project_investor_user_account (user_account_id)
    REFERENCES user_account (id);

-- Reference: project_organization (table: project)
ALTER TABLE project ADD CONSTRAINT project_organization FOREIGN KEY project_organization (organization_id)
    REFERENCES organization (id);

-- Reference: project_project_status (table: project)
ALTER TABLE project ADD CONSTRAINT project_project_status FOREIGN KEY project_project_status (project_status_id)
    REFERENCES project_status (id);

-- Reference: project_status_history_project (table: project_status_history)
ALTER TABLE project_status_history ADD CONSTRAINT project_status_history_project FOREIGN KEY project_status_history_project (project_id)
    REFERENCES project (id);

-- Reference: project_status_history_project_status (table: project_status_history)
ALTER TABLE project_status_history ADD CONSTRAINT project_status_history_project_status FOREIGN KEY project_status_history_project_status (project_status_id)
    REFERENCES project_status (id);

-- Reference: project_team_participant (table: project_team)
ALTER TABLE project_team ADD CONSTRAINT project_team_participant FOREIGN KEY project_team_participant (participant_id)
    REFERENCES participant (id);

-- Reference: project_team_project (table: project_team)
ALTER TABLE project_team ADD CONSTRAINT project_team_project FOREIGN KEY project_team_project (project_id)
    REFERENCES project (id);

-- Reference: project_team_role (table: project_team)
ALTER TABLE project_team ADD CONSTRAINT project_team_role FOREIGN KEY project_team_role (role_id)
    REFERENCES role (id);

-- Reference: project_user_account (table: project)
ALTER TABLE project ADD CONSTRAINT project_user_account FOREIGN KEY project_user_account (user_account_id)
    REFERENCES user_account (id);

-- Reference: updates_project (table: update)
ALTER TABLE `update` ADD CONSTRAINT updates_project FOREIGN KEY updates_project (project_id)
    REFERENCES project (id);

-- Reference: updates_user_account (table: update)
ALTER TABLE `update` ADD CONSTRAINT updates_user_account FOREIGN KEY updates_user_account (user_account_id)
    REFERENCES user_account (id);

-- Reference: user_account_country (table: user_account)
ALTER TABLE user_account ADD CONSTRAINT user_account_country FOREIGN KEY user_account_country (country_id)
    REFERENCES country (id);

-- End of file.


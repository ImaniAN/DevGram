-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:13:36.846

-- tables
-- Table: activity
CREATE TABLE activity (
    id int NOT NULL ,
    activity_name varchar(255) NOT NULL,
    task_id int NOT NULL,
    priority int NOT NULL COMMENT 'e.g. 1 to 5',
    description text NULL,
    planned_start_date date NOT NULL,
    planned_end_date date NOT NULL,
    planned_budget decimal(8,2) NOT NULL,
    actual_start_time date NULL,
    actual_end_time date NULL,
    actual_budget decimal(8,2) NULL,
    CONSTRAINT activity_pk PRIMARY KEY (id)
);

-- Table: assigned
CREATE TABLE assigned (
    id int NOT NULL ,
    activity_id int NOT NULL,
    employee_id int NOT NULL,
    role_id int NOT NULL,
    UNIQUE INDEX assigned_ak_1 (activity_id,employee_id,role_id),
    CONSTRAINT assigned_pk PRIMARY KEY (id)
);

-- Table: client_partner
CREATE TABLE client_partner (
    id int NOT NULL ,
    cp_name varchar(255) NOT NULL,
    cp_address varchar(255) NOT NULL,
    cp_details text NOT NULL,
    CONSTRAINT client_partner_pk PRIMARY KEY (id)
) COMMENT 'list of business entities we work with on a project';

-- Table: employee
CREATE TABLE employee (
    id int NOT NULL ,
    employee_code varchar(128) NOT NULL COMMENT 'external unique id',
    employee_name varchar(128) NOT NULL,
    user_account_id int NULL,
    UNIQUE INDEX employee_ak_1 (employee_code),
    CONSTRAINT employee_pk PRIMARY KEY (id)
) COMMENT 'list of all employees that could take part on projects';

-- Table: on_project
CREATE TABLE on_project (
    id int NOT NULL ,
    project_id int NOT NULL,
    client_partner_id int NOT NULL,
    date_start date NOT NULL,
    date_end date NULL,
    is_client bool NOT NULL,
    is_partner bool NOT NULL,
    description text NOT NULL,
    CONSTRAINT on_project_pk PRIMARY KEY (id)
) COMMENT 'list of all clients and partners related with projects';

-- Table: preceding_activity
CREATE TABLE preceding_activity (
    id int NOT NULL ,
    activity_id int NOT NULL,
    preceding_activity_id int NOT NULL COMMENT 'id of activity that has to be completed first',
    UNIQUE INDEX preceding_activity_ak_1 (activity_id,preceding_activity_id),
    CONSTRAINT preceding_activity_pk PRIMARY KEY (id)
);

-- Table: preceding_task
CREATE TABLE preceding_task (
    id int NOT NULL ,
    task_id int NOT NULL,
    preceding_task_id int NOT NULL,
    UNIQUE INDEX preceding_task_ak_1 (task_id,preceding_task_id),
    CONSTRAINT preceding_task_pk PRIMARY KEY (id)
);

-- Table: project
CREATE TABLE project (
    id int NOT NULL ,
    project_name varchar(128) NOT NULL,
    planned_start_date date NOT NULL,
    planned_end_date date NOT NULL,
    actual_start_date date NULL,
    actual_end_date date NULL,
    project_description text NOT NULL,
    CONSTRAINT project_pk PRIMARY KEY (id)
);

-- Table: project_manager
CREATE TABLE project_manager (
    id int NOT NULL ,
    project_id int NOT NULL,
    user_account_id int NOT NULL,
    UNIQUE INDEX project_manager_ak_1 (project_id,user_account_id),
    CONSTRAINT project_manager_pk PRIMARY KEY (id)
);

-- Table: role
CREATE TABLE role (
    id int NOT NULL ,
    role_name varchar(128) NOT NULL,
    UNIQUE INDEX role_ak_1 (role_name),
    CONSTRAINT role_pk PRIMARY KEY (id)
) COMMENT 'e.g. project manager, developer, electrician';

-- Table: task
CREATE TABLE task (
    id int NOT NULL ,
    task_name varchar(255) NOT NULL,
    project_id int NOT NULL,
    priority int NOT NULL COMMENT 'e.g. 1 to 5',
    description text NULL,
    planned_start_date date NOT NULL,
    planned_end_date date NOT NULL,
    planned_budget decimal(8,2) NOT NULL,
    actual_start_time date NULL,
    actual_end_time date NULL,
    actual_budget decimal(8,2) NULL,
    CONSTRAINT task_pk PRIMARY KEY (id)
) COMMENT 'list of all takss (group of activities) on projects';

-- Table: team
CREATE TABLE team (
    id int NOT NULL ,
    team_name varchar(128) NOT NULL,
    UNIQUE INDEX team_ak_1 (team_name),
    CONSTRAINT team_pk PRIMARY KEY (id)
);

-- Table: team_member
CREATE TABLE team_member (
    id int NOT NULL ,
    team_id int NOT NULL,
    employee_id int NOT NULL,
    role_id int NOT NULL,
    UNIQUE INDEX team_member_ak_1 (team_id,employee_id),
    CONSTRAINT team_member_pk PRIMARY KEY (id)
) COMMENT 'grouping employees in team in case we want to assign whole team to a task';

-- Table: user_account
CREATE TABLE user_account (
    id int NOT NULL ,
    username varchar(64) NOT NULL,
    password varchar(64) NOT NULL,
    email varchar(255) NOT NULL,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    is_project_manager bool NOT NULL,
    registration_time timestamp NOT NULL,
    UNIQUE INDEX user_account_ak_1 (username),
    UNIQUE INDEX user_account_ak_2 (email),
    CONSTRAINT user_account_pk PRIMARY KEY (id)
) COMMENT 'list of all users that will have access to the database';

-- foreign keys
-- Reference: activity_task (table: activity)
ALTER TABLE activity ADD CONSTRAINT activity_task FOREIGN KEY activity_task (task_id)
    REFERENCES task (id);

-- Reference: assigned_activity (table: assigned)
ALTER TABLE assigned ADD CONSTRAINT assigned_activity FOREIGN KEY assigned_activity (activity_id)
    REFERENCES activity (id);

-- Reference: assigned_employee (table: assigned)
ALTER TABLE assigned ADD CONSTRAINT assigned_employee FOREIGN KEY assigned_employee (employee_id)
    REFERENCES employee (id);

-- Reference: assigned_role (table: assigned)
ALTER TABLE assigned ADD CONSTRAINT assigned_role FOREIGN KEY assigned_role (role_id)
    REFERENCES role (id);

-- Reference: employee_user_account (table: employee)
ALTER TABLE employee ADD CONSTRAINT employee_user_account FOREIGN KEY employee_user_account (user_account_id)
    REFERENCES user_account (id);

-- Reference: on_project_client_partner (table: on_project)
ALTER TABLE on_project ADD CONSTRAINT on_project_client_partner FOREIGN KEY on_project_client_partner (client_partner_id)
    REFERENCES client_partner (id);

-- Reference: on_project_project (table: on_project)
ALTER TABLE on_project ADD CONSTRAINT on_project_project FOREIGN KEY on_project_project (project_id)
    REFERENCES project (id);

-- Reference: preceding_activity_activity1 (table: preceding_activity)
ALTER TABLE preceding_activity ADD CONSTRAINT preceding_activity_activity1 FOREIGN KEY preceding_activity_activity1 (activity_id)
    REFERENCES activity (id);

-- Reference: preceding_activity_activity2 (table: preceding_activity)
ALTER TABLE preceding_activity ADD CONSTRAINT preceding_activity_activity2 FOREIGN KEY preceding_activity_activity2 (preceding_activity_id)
    REFERENCES activity (id);

-- Reference: preceding_task_task1 (table: preceding_task)
ALTER TABLE preceding_task ADD CONSTRAINT preceding_task_task1 FOREIGN KEY preceding_task_task1 (task_id)
    REFERENCES task (id);

-- Reference: preceding_task_task2 (table: preceding_task)
ALTER TABLE preceding_task ADD CONSTRAINT preceding_task_task2 FOREIGN KEY preceding_task_task2 (preceding_task_id)
    REFERENCES task (id);

-- Reference: project_manager_project (table: project_manager)
ALTER TABLE project_manager ADD CONSTRAINT project_manager_project FOREIGN KEY project_manager_project (project_id)
    REFERENCES project (id);

-- Reference: project_manager_user_account (table: project_manager)
ALTER TABLE project_manager ADD CONSTRAINT project_manager_user_account FOREIGN KEY project_manager_user_account (user_account_id)
    REFERENCES user_account (id);

-- Reference: task_project (table: task)
ALTER TABLE task ADD CONSTRAINT task_project FOREIGN KEY task_project (project_id)
    REFERENCES project (id);

-- Reference: team_member_employee (table: team_member)
ALTER TABLE team_member ADD CONSTRAINT team_member_employee FOREIGN KEY team_member_employee (employee_id)
    REFERENCES employee (id);

-- Reference: team_member_role (table: team_member)
ALTER TABLE team_member ADD CONSTRAINT team_member_role FOREIGN KEY team_member_role (role_id)
    REFERENCES role (id);

-- Reference: team_member_team (table: team_member)
ALTER TABLE team_member ADD CONSTRAINT team_member_team FOREIGN KEY team_member_team (team_id)
    REFERENCES team (id);

-- End of file.


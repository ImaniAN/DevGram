-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:40:29.369

-- tables
-- Table: conditional_order
CREATE TABLE conditional_order (
    id int NOT NULL,
    question_order_id int NOT NULL,
    response_question_id int NOT NULL,
    positive_response_question_order_id int NULL,
    negative_response_question_order_id int NULL,
    CONSTRAINT conditional_order_pk PRIMARY KEY (id)
);

-- Table: group
CREATE TABLE `group` (
    id int NOT NULL,
    name varchar(100) NOT NULL,
    description varchar(1000) NOT NULL,
    CONSTRAINT group_pk PRIMARY KEY (id)
);

-- Table: permission
CREATE TABLE permission (
    id int NOT NULL,
    name varchar(100) NOT NULL,
    CONSTRAINT permission_pk PRIMARY KEY (id)
);

-- Table: question
CREATE TABLE question (
    id int NOT NULL,
    text varchar(1000) NOT NULL,
    updated timestamp NOT NULL,
    question_type_id int NOT NULL,
    CONSTRAINT question_pk PRIMARY KEY (id)
);

-- Table: question_order
CREATE TABLE question_order (
    id int NOT NULL,
    question_id int NOT NULL,
    survey_id int NOT NULL,
    `order` int NOT NULL,
    conditional_order_id int NOT NULL,
    UNIQUE INDEX question_order_ak_1 (survey_id,question_id),
    CONSTRAINT question_order_pk PRIMARY KEY (id)
);

-- Table: question_type
CREATE TABLE question_type (
    id int NOT NULL,
    name varchar(30) NOT NULL,
    CONSTRAINT question_type_pk PRIMARY KEY (id)
);

-- Table: respondent
CREATE TABLE respondent (
    id int NOT NULL,
    first_name varchar(100) NULL,
    last_name varchar(100) NULL,
    email varchar(254) NULL,
    created timestamp NOT NULL,
    ip_address varchar(45) NOT NULL,
    CONSTRAINT respondent_pk PRIMARY KEY (id)
);

-- Table: response
CREATE TABLE response (
    survey_response_id int NOT NULL,
    question_id int NOT NULL,
    respondent_id int NOT NULL,
    answer varchar(1000) NOT NULL,
    CONSTRAINT response_pk PRIMARY KEY (survey_response_id,question_id,respondent_id)
);

-- Table: response_choice
CREATE TABLE response_choice (
    id int NOT NULL,
    question_id int NOT NULL,
    text varchar(1000) NOT NULL,
    CONSTRAINT response_choice_pk PRIMARY KEY (id)
);

-- Table: role_permission
CREATE TABLE role_permission (
    id int NOT NULL,
    permission_id int NOT NULL,
    CONSTRAINT role_permission_pk PRIMARY KEY (id)
);

-- Table: survey
CREATE TABLE survey (
    id int NOT NULL,
    name varchar(100) NOT NULL,
    description varchar(1000) NULL,
    updated timestamp NOT NULL,
    opening_time timestamp NOT NULL,
    closing_time timestamp NOT NULL,
    group_id int NOT NULL,
    CONSTRAINT survey_pk PRIMARY KEY (id)
);

-- Table: survey_response
CREATE TABLE survey_response (
    id int NOT NULL,
    survey_id int NOT NULL,
    respondent_id int NOT NULL,
    updated timestamp NOT NULL,
    started_at timestamp NOT NULL,
    completed_at timestamp NOT NULL,
    CONSTRAINT survey_response_pk PRIMARY KEY (id)
);

-- Table: user
CREATE TABLE user (
    id int NOT NULL,
    hashed_password varchar(100) NOT NULL,
    first_name varchar(100) NOT NULL,
    last_name varchar(100) NOT NULL,
    email varchar(254) NOT NULL,
    created timestamp NOT NULL,
    group_id int NOT NULL,
    user_role_id int NOT NULL,
    CONSTRAINT user_pk PRIMARY KEY (id)
);

-- Table: user_role
CREATE TABLE user_role (
    id int NOT NULL,
    name varchar(100) NOT NULL,
    description varchar(1000) NOT NULL,
    CONSTRAINT user_role_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: conditional_order_question_order (table: conditional_order)
ALTER TABLE conditional_order ADD CONSTRAINT conditional_order_question_order FOREIGN KEY conditional_order_question_order (question_order_id)
    REFERENCES question_order (id);

-- Reference: question_order_conditional_order_3 (table: conditional_order)
ALTER TABLE conditional_order ADD CONSTRAINT question_order_conditional_order_3 FOREIGN KEY question_order_conditional_order_3 (response_question_id)
    REFERENCES question_order (id);

-- Reference: question_order_conditional_order_negative (table: conditional_order)
ALTER TABLE conditional_order ADD CONSTRAINT question_order_conditional_order_negative FOREIGN KEY question_order_conditional_order_negative (negative_response_question_order_id)
    REFERENCES question_order (id);

-- Reference: question_order_conditional_order_postive (table: conditional_order)
ALTER TABLE conditional_order ADD CONSTRAINT question_order_conditional_order_postive FOREIGN KEY question_order_conditional_order_postive (positive_response_question_order_id)
    REFERENCES question_order (id);

-- Reference: question_order_question (table: question_order)
ALTER TABLE question_order ADD CONSTRAINT question_order_question FOREIGN KEY question_order_question (question_id)
    REFERENCES question (id);

-- Reference: question_order_survey (table: question_order)
ALTER TABLE question_order ADD CONSTRAINT question_order_survey FOREIGN KEY question_order_survey (survey_id)
    REFERENCES survey (id);

-- Reference: question_question_type (table: question)
ALTER TABLE question ADD CONSTRAINT question_question_type FOREIGN KEY question_question_type (question_type_id)
    REFERENCES question_type (id);

-- Reference: response_choice_question (table: response_choice)
ALTER TABLE response_choice ADD CONSTRAINT response_choice_question FOREIGN KEY response_choice_question (question_id)
    REFERENCES question (id);

-- Reference: response_question (table: response)
ALTER TABLE response ADD CONSTRAINT response_question FOREIGN KEY response_question (question_id)
    REFERENCES question (id);

-- Reference: response_respondent (table: response)
ALTER TABLE response ADD CONSTRAINT response_respondent FOREIGN KEY response_respondent (respondent_id)
    REFERENCES respondent (id);

-- Reference: response_survey_response (table: response)
ALTER TABLE response ADD CONSTRAINT response_survey_response FOREIGN KEY response_survey_response (survey_response_id)
    REFERENCES survey_response (id);

-- Reference: role_permission_permission (table: role_permission)
ALTER TABLE role_permission ADD CONSTRAINT role_permission_permission FOREIGN KEY role_permission_permission (permission_id)
    REFERENCES permission (id);

-- Reference: role_permission_user_role (table: role_permission)
ALTER TABLE role_permission ADD CONSTRAINT role_permission_user_role FOREIGN KEY role_permission_user_role (id)
    REFERENCES user_role (id);

-- Reference: survey_group (table: survey)
ALTER TABLE survey ADD CONSTRAINT survey_group FOREIGN KEY survey_group (group_id)
    REFERENCES `group` (id);

-- Reference: survey_response_respondent (table: survey_response)
ALTER TABLE survey_response ADD CONSTRAINT survey_response_respondent FOREIGN KEY survey_response_respondent (respondent_id)
    REFERENCES respondent (id);

-- Reference: survey_response_survey (table: survey_response)
ALTER TABLE survey_response ADD CONSTRAINT survey_response_survey FOREIGN KEY survey_response_survey (survey_id)
    REFERENCES survey (id);

-- Reference: user_group (table: user)
ALTER TABLE user ADD CONSTRAINT user_group FOREIGN KEY user_group (group_id)
    REFERENCES `group` (id);

-- Reference: user_user_role (table: user)
ALTER TABLE user ADD CONSTRAINT user_user_role FOREIGN KEY user_user_role (user_role_id)
    REFERENCES user_role (id);

-- End of file.


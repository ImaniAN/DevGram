-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:51:50.927

-- tables
-- Table: answer
CREATE TABLE answer (
    id int NOT NULL AUTO_INCREMENT,
    question_id int NOT NULL,
    answer_text varchar(128) NOT NULL,
    ordinal_position int NOT NULL,
    UNIQUE INDEX answer_ak_1 (question_id,answer_text),
    UNIQUE INDEX answer_ak_2 (question_id,ordinal_position),
    CONSTRAINT answer_pk PRIMARY KEY (id)
) COMMENT 'list of all possible answers';

-- Table: answer_type
CREATE TABLE answer_type (
    id int NOT NULL AUTO_INCREMENT,
    answer_type_name varchar(128) NOT NULL,
    UNIQUE INDEX answer_type_ak_1 (answer_type_name),
    CONSTRAINT answer_type_pk PRIMARY KEY (id)
) COMMENT 'open, list, checkbox, multiple';

-- Table: contact_type
CREATE TABLE contact_type (
    id int NOT NULL AUTO_INCREMENT,
    contact_type_name varchar(128) NOT NULL,
    UNIQUE INDEX contact_type_ak_1 (contact_type_name),
    CONSTRAINT contact_type_pk PRIMARY KEY (id)
);

-- Table: poll
CREATE TABLE poll (
    id int NOT NULL AUTO_INCREMENT,
    poll_type_id int NOT NULL,
    description text NOT NULL,
    start_time timestamp NOT NULL,
    end_time timestamp NOT NULL,
    time_created timestamp NOT NULL,
    CONSTRAINT poll_pk PRIMARY KEY (id)
) COMMENT 'all poll details (polls instance)';

-- Table: poll_type
CREATE TABLE poll_type (
    id int NOT NULL AUTO_INCREMENT,
    poll_type_name varchar(128) NOT NULL,
    description text NOT NULL,
    politics bool NOT NULL,
    ecomony bool NOT NULL,
    sport bool NOT NULL,
    hobby bool NOT NULL,
    time_created timestamp NOT NULL,
    UNIQUE INDEX poll_type_ak_1 (poll_type_name),
    CONSTRAINT poll_type_pk PRIMARY KEY (id)
) COMMENT 'poll (type)';

-- Table: pollster
CREATE TABLE pollster (
    id int NOT NULL AUTO_INCREMENT,
    email varchar(128) NOT NULL,
    first_name varchar(128) NOT NULL,
    last_name varchar(128) NOT NULL,
    UNIQUE INDEX pollster_ak_1 (email),
    CONSTRAINT pollster_pk PRIMARY KEY (id)
);

-- Table: question
CREATE TABLE question (
    id int NOT NULL AUTO_INCREMENT,
    question_text text NOT NULL,
    questionnaire_id int NOT NULL,
    question_type_id int NOT NULL,
    answer_type_id int NOT NULL,
    ordinal_position int NOT NULL,
    UNIQUE INDEX question_ak_1 (questionnaire_id,ordinal_position),
    CONSTRAINT question_pk PRIMARY KEY (id)
);

-- Table: question_type
CREATE TABLE question_type (
    id int NOT NULL AUTO_INCREMENT,
    question_type_name varchar(128) NOT NULL,
    UNIQUE INDEX question_type_ak_1 (question_type_name),
    CONSTRAINT question_type_pk PRIMARY KEY (id)
) COMMENT 'demographics, opinion';

-- Table: questionnaire
CREATE TABLE questionnaire (
    id int NOT NULL AUTO_INCREMENT,
    poll_id int NOT NULL,
    introduction text NOT NULL,
    time_created timestamp NOT NULL,
    CONSTRAINT questionnaire_pk PRIMARY KEY (id)
);

-- Table: related_poll
CREATE TABLE related_poll (
    id int NOT NULL AUTO_INCREMENT,
    poll_id int NOT NULL,
    related_poll_id int NOT NULL,
    UNIQUE INDEX related_poll_ak_1 (poll_id,related_poll_id),
    CONSTRAINT related_poll_pk PRIMARY KEY (id)
);

-- Table: result_answer
CREATE TABLE result_answer (
    id int NOT NULL AUTO_INCREMENT,
    result_questionnaire_id int NOT NULL,
    question_id int NOT NULL,
    answer_id int NULL,
    answer_text text NULL,
    time_created timestamp NOT NULL,
    CONSTRAINT result_answer_pk PRIMARY KEY (id)
);

-- Table: result_questionnaire
CREATE TABLE result_questionnaire (
    id int NOT NULL AUTO_INCREMENT,
    questionnaire_id int NOT NULL,
    contact_type_id int NOT NULL,
    pollster_id int NULL,
    time_created timestamp NOT NULL,
    time_completed timestamp NULL,
    CONSTRAINT result_questionnaire_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: actual_answer_actual_questionnaire (table: result_answer)
ALTER TABLE result_answer ADD CONSTRAINT actual_answer_actual_questionnaire FOREIGN KEY actual_answer_actual_questionnaire (result_questionnaire_id)
    REFERENCES result_questionnaire (id);

-- Reference: actual_answer_answer (table: result_answer)
ALTER TABLE result_answer ADD CONSTRAINT actual_answer_answer FOREIGN KEY actual_answer_answer (answer_id)
    REFERENCES answer (id);

-- Reference: actual_answer_question (table: result_answer)
ALTER TABLE result_answer ADD CONSTRAINT actual_answer_question FOREIGN KEY actual_answer_question (question_id)
    REFERENCES question (id);

-- Reference: actual_questionnaire_contact_type (table: result_questionnaire)
ALTER TABLE result_questionnaire ADD CONSTRAINT actual_questionnaire_contact_type FOREIGN KEY actual_questionnaire_contact_type (contact_type_id)
    REFERENCES contact_type (id);

-- Reference: actual_questionnaire_pollster (table: result_questionnaire)
ALTER TABLE result_questionnaire ADD CONSTRAINT actual_questionnaire_pollster FOREIGN KEY actual_questionnaire_pollster (pollster_id)
    REFERENCES pollster (id);

-- Reference: actual_questionnaire_questionnaire (table: result_questionnaire)
ALTER TABLE result_questionnaire ADD CONSTRAINT actual_questionnaire_questionnaire FOREIGN KEY actual_questionnaire_questionnaire (questionnaire_id)
    REFERENCES questionnaire (id);

-- Reference: answer_question (table: answer)
ALTER TABLE answer ADD CONSTRAINT answer_question FOREIGN KEY answer_question (question_id)
    REFERENCES question (id);

-- Reference: poll_poll_type (table: poll)
ALTER TABLE poll ADD CONSTRAINT poll_poll_type FOREIGN KEY poll_poll_type (poll_type_id)
    REFERENCES poll_type (id);

-- Reference: question_answer_type (table: question)
ALTER TABLE question ADD CONSTRAINT question_answer_type FOREIGN KEY question_answer_type (answer_type_id)
    REFERENCES answer_type (id);

-- Reference: question_question_type (table: question)
ALTER TABLE question ADD CONSTRAINT question_question_type FOREIGN KEY question_question_type (question_type_id)
    REFERENCES question_type (id);

-- Reference: question_questionnaire (table: question)
ALTER TABLE question ADD CONSTRAINT question_questionnaire FOREIGN KEY question_questionnaire (questionnaire_id)
    REFERENCES questionnaire (id);

-- Reference: questionnaire_poll (table: questionnaire)
ALTER TABLE questionnaire ADD CONSTRAINT questionnaire_poll FOREIGN KEY questionnaire_poll (poll_id)
    REFERENCES poll (id);

-- Reference: related_poll_poll (table: related_poll)
ALTER TABLE related_poll ADD CONSTRAINT related_poll_poll FOREIGN KEY related_poll_poll (poll_id)
    REFERENCES poll (id);

-- Reference: related_poll_related_poll (table: related_poll)
ALTER TABLE related_poll ADD CONSTRAINT related_poll_related_poll FOREIGN KEY related_poll_related_poll (related_poll_id)
    REFERENCES poll (id);

-- End of file.


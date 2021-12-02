-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:42:52.093

-- tables
-- Table: question
CREATE TABLE question (
    id int NOT NULL,
    text varchar(200) NOT NULL,
    updated timestamp NOT NULL,
    CONSTRAINT question_pk PRIMARY KEY (id)
);

-- Table: question_order
CREATE TABLE question_order (
    question_id int NOT NULL,
    survey_id int NOT NULL,
    `order` int NOT NULL,
    UNIQUE INDEX question_order_ak_1 (survey_id,question_id),
    CONSTRAINT question_order_pk PRIMARY KEY (question_id,survey_id)
);

-- Table: respondent
CREATE TABLE respondent (
    id int NOT NULL,
    name varchar(50) NOT NULL,
    hashedpassword varchar(100) NOT NULL,
    email varchar(254) NOT NULL,
    created timestamp NOT NULL,
    CONSTRAINT respondent_pk PRIMARY KEY (id)
);

-- Table: response
CREATE TABLE response (
    survey_response_id int NOT NULL,
    question_id int NOT NULL,
    respondent_id int NOT NULL,
    answer varchar(100) NOT NULL,
    CONSTRAINT response_pk PRIMARY KEY (survey_response_id,question_id,respondent_id)
);

-- Table: survey
CREATE TABLE survey (
    id int NOT NULL,
    name varchar(50) NOT NULL,
    description varchar(1000) NULL,
    updated timestamp NOT NULL,
    CONSTRAINT survey_pk PRIMARY KEY (id)
);

-- Table: survey_response
CREATE TABLE survey_response (
    id int NOT NULL,
    survey_id int NOT NULL,
    respondent_id int NOT NULL,
    updated timestamp NOT NULL,
    CONSTRAINT survey_response_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: question_order_question (table: question_order)
ALTER TABLE question_order ADD CONSTRAINT question_order_question FOREIGN KEY question_order_question (question_id)
    REFERENCES question (id);

-- Reference: question_order_survey (table: question_order)
ALTER TABLE question_order ADD CONSTRAINT question_order_survey FOREIGN KEY question_order_survey (survey_id)
    REFERENCES survey (id);

-- Reference: response_question (table: response)
ALTER TABLE response ADD CONSTRAINT response_question FOREIGN KEY response_question (question_id)
    REFERENCES question (id);

-- Reference: response_respondent (table: response)
ALTER TABLE response ADD CONSTRAINT response_respondent FOREIGN KEY response_respondent (respondent_id)
    REFERENCES respondent (id);

-- Reference: response_survey_response (table: response)
ALTER TABLE response ADD CONSTRAINT response_survey_response FOREIGN KEY response_survey_response (survey_response_id)
    REFERENCES survey_response (id);

-- Reference: survey_response_respondent (table: survey_response)
ALTER TABLE survey_response ADD CONSTRAINT survey_response_respondent FOREIGN KEY survey_response_respondent (respondent_id)
    REFERENCES respondent (id);

-- Reference: survey_response_survey (table: survey_response)
ALTER TABLE survey_response ADD CONSTRAINT survey_response_survey FOREIGN KEY survey_response_survey (survey_id)
    REFERENCES survey (id);

-- End of file.


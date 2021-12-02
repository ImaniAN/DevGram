-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:07:15.554

-- tables
-- Table: applicant
CREATE TABLE applicant (
    id int NOT NULL AUTO_INCREMENT,
    code varchar(32) NOT NULL COMMENT 'internal code used uniquely for that applicant',
    first_name varchar(128) NOT NULL,
    last_name varchar(128) NOT NULL,
    phone varchar(64) NULL,
    email varchar(128) NULL,
    summary text NULL,
    UNIQUE INDEX applicant_ak_1 (code),
    CONSTRAINT applicant_pk PRIMARY KEY (id)
) COMMENT 'list of all applicants';

-- Table: application
CREATE TABLE application (
    id int NOT NULL AUTO_INCREMENT,
    applicant_id int NOT NULL,
    recruiter_id int NOT NULL,
    application_status_id int NOT NULL COMMENT 'current application status',
    application_date date NOT NULL,
    application_details text NULL,
    process_id int NOT NULL,
    CONSTRAINT application_pk PRIMARY KEY (id)
);

-- Table: application_status
CREATE TABLE application_status (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(255) NOT NULL,
    UNIQUE INDEX application_status_ak_1 (status_name),
    CONSTRAINT application_status_pk PRIMARY KEY (id)
) COMMENT 'list of all possible statuses application could be in; e.g. "applied", "CV reviewed", "chosen for the test", "rejected after CV review", "passed the test", "invited to an interview", "terminated by applicant"';

-- Table: application_status_history
CREATE TABLE application_status_history (
    id int NOT NULL AUTO_INCREMENT,
    application_id int NOT NULL,
    application_status_id int NOT NULL,
    status_time timestamp NOT NULL,
    UNIQUE INDEX application_status_history_ak_1 (application_id,status_time),
    CONSTRAINT application_status_history_pk PRIMARY KEY (id)
) COMMENT 'history of all statuses assigned to applications';

-- Table: applied_for
CREATE TABLE applied_for (
    id int NOT NULL AUTO_INCREMENT,
    application_id int NOT NULL,
    job_id int NOT NULL,
    selected bool NOT NULL COMMENT 'is this applicant selected for this job or not',
    UNIQUE INDEX applied_for_ak_1 (application_id,job_id),
    CONSTRAINT applied_for_pk PRIMARY KEY (id)
);

-- Table: company
CREATE TABLE company (
    id int NOT NULL AUTO_INCREMENT,
    code varchar(32) NOT NULL COMMENT 'internal UNIQUE ID',
    details text NOT NULL,
    UNIQUE INDEX company_ak_1 (code),
    CONSTRAINT company_pk PRIMARY KEY (id)
) COMMENT 'list of companies we work for';

-- Table: document
CREATE TABLE document (
    id int NOT NULL AUTO_INCREMENT,
    document_name varchar(255) NOT NULL,
    document_location text NOT NULL,
    last_updated date NOT NULL,
    CONSTRAINT document_pk PRIMARY KEY (id)
);

-- Table: job
CREATE TABLE job (
    id int NOT NULL AUTO_INCREMENT,
    code varchar(32) NOT NULL COMMENT 'internal UNIQUE ID',
    job_type_id int NOT NULL,
    posted_date date NOT NULL,
    start_date date NOT NULL,
    employees_needed int NOT NULL,
    description text NOT NULL,
    company_id int NOT NULL,
    date_process_started date NULL COMMENT 'initial date when we plan to start the selection process for this job - could be NULL until the time we decide the actual date and define whole process',
    UNIQUE INDEX job_ak_1 (code),
    CONSTRAINT job_pk PRIMARY KEY (id)
) COMMENT 'list of all opened jobs/positions in a company';

-- Table: job_type
CREATE TABLE job_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(255) NOT NULL,
    type_description text NULL,
    UNIQUE INDEX job_type_ak_1 (type_name),
    CONSTRAINT job_type_pk PRIMARY KEY (id)
) COMMENT 'dictionary of all possible job types (e.g. database administrator, IT journalist)';

-- Table: notes
CREATE TABLE notes (
    id int NOT NULL AUTO_INCREMENT,
    applicant_id int NOT NULL,
    recruiter_id int NULL,
    note_text text NOT NULL,
    ts timestamp NOT NULL,
    CONSTRAINT notes_pk PRIMARY KEY (id)
);

-- Table: posted_on
CREATE TABLE posted_on (
    id int NOT NULL AUTO_INCREMENT,
    job_id int NOT NULL,
    description text NULL,
    link text NULL COMMENT 'if the job was posted online',
    CONSTRAINT posted_on_pk PRIMARY KEY (id)
) COMMENT 'where the job was posted/advertised';

-- Table: process
CREATE TABLE process (
    id int NOT NULL AUTO_INCREMENT,
    process_name varchar(255) NOT NULL,
    UNIQUE INDEX process_ak_1 (process_name),
    CONSTRAINT process_pk PRIMARY KEY (id)
) COMMENT 'related with ordered list of all tests during the recruitment process for a certain position';

-- Table: process_avaliable
CREATE TABLE process_avaliable (
    id int NOT NULL AUTO_INCREMENT,
    job_type_id int NOT NULL,
    process_id int NOT NULL,
    UNIQUE INDEX process_avaliable_ak_1 (job_type_id,process_id),
    CONSTRAINT process_avaliable_pk PRIMARY KEY (id)
) COMMENT 'list all processes we could use for specific job type';

-- Table: recruiter
CREATE TABLE recruiter (
    id int NOT NULL AUTO_INCREMENT,
    code varchar(32) NOT NULL,
    first_name varchar(128) NOT NULL,
    last_name varchar(128) NOT NULL,
    summary text NOT NULL,
    CONSTRAINT recruiter_pk PRIMARY KEY (id)
) COMMENT 'list of all recruiters';

-- Table: recruiter_graded
CREATE TABLE recruiter_graded (
    id int NOT NULL AUTO_INCREMENT,
    recruiter_id int NOT NULL,
    test_taken_id int NOT NULL,
    score int NOT NULL,
    notes text NULL,
    UNIQUE INDEX recruiter_graded_ak_1 (recruiter_id,test_taken_id),
    CONSTRAINT recruiter_graded_pk PRIMARY KEY (id)
);

-- Table: related_document
CREATE TABLE related_document (
    id int NOT NULL AUTO_INCREMENT,
    document_id int NOT NULL,
    applicant_Id int NOT NULL,
    UNIQUE INDEX related_document_ak_1 (document_id,applicant_Id),
    CONSTRAINT related_document_pk PRIMARY KEY (id)
);

-- Table: test
CREATE TABLE test (
    id int NOT NULL AUTO_INCREMENT,
    test_name varchar(255) NOT NULL,
    test_type_id int NOT NULL,
    date_created date NOT NULL,
    max_score int NOT NULL,
    max_duration int NOT NULL,
    test_link text NULL COMMENT 'link to the test location',
    is_active bool NOT NULL,
    UNIQUE INDEX test_ak_1 (test_name),
    CONSTRAINT test_pk PRIMARY KEY (id)
) COMMENT 'list of all tests (online, paper tests, interviews)';

-- Table: test_in_process
CREATE TABLE test_in_process (
    id int NOT NULL AUTO_INCREMENT,
    process_id int NOT NULL,
    test_id int NOT NULL,
    test_order int NOT NULL COMMENT 'order # of that test when used during that process',
    UNIQUE INDEX test_in_process_ak_1 (process_id,test_order),
    CONSTRAINT test_in_process_pk PRIMARY KEY (id)
) COMMENT 'position of a certain test in a certain process';

-- Table: test_status
CREATE TABLE test_status (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(255) NOT NULL,
    UNIQUE INDEX test_status_ak_1 (status_name),
    CONSTRAINT test_status_pk PRIMARY KEY (id)
) COMMENT 'list of all possible statuses test could be in; e.g. "not started", "in progress", "completed successfully", "completed unsuccessfully", "postponed", "canceled", "applicant canceled"';

-- Table: test_taken
CREATE TABLE test_taken (
    id int NOT NULL AUTO_INCREMENT,
    application_id int NOT NULL,
    test_id int NOT NULL,
    time_created timestamp NOT NULL,
    expected_test_start_time timestamp NOT NULL,
    expected_test_end_time timestamp NOT NULL,
    test_start_time timestamp NULL COMMENT 'when the test really started',
    test_end_time timestamp NULL COMMENT 'when the test really ended',
    test_status_id int NOT NULL,
    test_link text NULL COMMENT 'link where the test containing all answers is stored',
    score int NULL COMMENT 'score is updated when test is completed and graded',
    max_score int NOT NULL COMMENT 'we need to store max_score from the test table because test and score could change during time',
    notes text NULL,
    UNIQUE INDEX test_taken_ak_1 (test_id,application_id,expected_test_start_time),
    CONSTRAINT test_taken_pk PRIMARY KEY (id)
) COMMENT 'list of all tests (and CV reviews) taken by applicants';

-- Table: test_type
CREATE TABLE test_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(255) NOT NULL,
    UNIQUE INDEX test_type_ak_1 (type_name),
    CONSTRAINT test_type_pk PRIMARY KEY (id)
) COMMENT 'CV review, online skill test, "paper" skill test, interview';

-- foreign keys
-- Reference: application_applicant (table: application)
ALTER TABLE application ADD CONSTRAINT application_applicant FOREIGN KEY application_applicant (applicant_id)
    REFERENCES applicant (id);

-- Reference: application_application_status (table: application)
ALTER TABLE application ADD CONSTRAINT application_application_status FOREIGN KEY application_application_status (application_status_id)
    REFERENCES application_status (id);

-- Reference: application_process (table: application)
ALTER TABLE application ADD CONSTRAINT application_process FOREIGN KEY application_process (process_id)
    REFERENCES process (id);

-- Reference: application_recruiter (table: application)
ALTER TABLE application ADD CONSTRAINT application_recruiter FOREIGN KEY application_recruiter (recruiter_id)
    REFERENCES recruiter (id);

-- Reference: application_status_history_application (table: application_status_history)
ALTER TABLE application_status_history ADD CONSTRAINT application_status_history_application FOREIGN KEY application_status_history_application (application_id)
    REFERENCES application (id);

-- Reference: application_status_history_application_status (table: application_status_history)
ALTER TABLE application_status_history ADD CONSTRAINT application_status_history_application_status FOREIGN KEY application_status_history_application_status (application_status_id)
    REFERENCES application_status (id);

-- Reference: applied_for_application (table: applied_for)
ALTER TABLE applied_for ADD CONSTRAINT applied_for_application FOREIGN KEY applied_for_application (application_id)
    REFERENCES application (id);

-- Reference: applied_for_job (table: applied_for)
ALTER TABLE applied_for ADD CONSTRAINT applied_for_job FOREIGN KEY applied_for_job (job_id)
    REFERENCES job (id);

-- Reference: job_company (table: job)
ALTER TABLE job ADD CONSTRAINT job_company FOREIGN KEY job_company (company_id)
    REFERENCES company (id);

-- Reference: job_job_type (table: job)
ALTER TABLE job ADD CONSTRAINT job_job_type FOREIGN KEY job_job_type (job_type_id)
    REFERENCES job_type (id);

-- Reference: notes_applicant (table: notes)
ALTER TABLE notes ADD CONSTRAINT notes_applicant FOREIGN KEY notes_applicant (applicant_id)
    REFERENCES applicant (id);

-- Reference: notes_recruiter (table: notes)
ALTER TABLE notes ADD CONSTRAINT notes_recruiter FOREIGN KEY notes_recruiter (recruiter_id)
    REFERENCES recruiter (id);

-- Reference: posted_on_job (table: posted_on)
ALTER TABLE posted_on ADD CONSTRAINT posted_on_job FOREIGN KEY posted_on_job (job_id)
    REFERENCES job (id);

-- Reference: process_avaliable_job_type (table: process_avaliable)
ALTER TABLE process_avaliable ADD CONSTRAINT process_avaliable_job_type FOREIGN KEY process_avaliable_job_type (job_type_id)
    REFERENCES job_type (id);

-- Reference: process_avaliable_process (table: process_avaliable)
ALTER TABLE process_avaliable ADD CONSTRAINT process_avaliable_process FOREIGN KEY process_avaliable_process (process_id)
    REFERENCES process (id);

-- Reference: recruiter_graded_recruiter (table: recruiter_graded)
ALTER TABLE recruiter_graded ADD CONSTRAINT recruiter_graded_recruiter FOREIGN KEY recruiter_graded_recruiter (recruiter_id)
    REFERENCES recruiter (id);

-- Reference: recruiter_graded_test_taken (table: recruiter_graded)
ALTER TABLE recruiter_graded ADD CONSTRAINT recruiter_graded_test_taken FOREIGN KEY recruiter_graded_test_taken (test_taken_id)
    REFERENCES test_taken (id);

-- Reference: related_document_applicant (table: related_document)
ALTER TABLE related_document ADD CONSTRAINT related_document_applicant FOREIGN KEY related_document_applicant (applicant_Id)
    REFERENCES applicant (id);

-- Reference: related_document_document (table: related_document)
ALTER TABLE related_document ADD CONSTRAINT related_document_document FOREIGN KEY related_document_document (document_id)
    REFERENCES document (id);

-- Reference: test_in_process_process (table: test_in_process)
ALTER TABLE test_in_process ADD CONSTRAINT test_in_process_process FOREIGN KEY test_in_process_process (process_id)
    REFERENCES process (id);

-- Reference: test_in_process_test (table: test_in_process)
ALTER TABLE test_in_process ADD CONSTRAINT test_in_process_test FOREIGN KEY test_in_process_test (test_id)
    REFERENCES test (id);

-- Reference: test_taken_application (table: test_taken)
ALTER TABLE test_taken ADD CONSTRAINT test_taken_application FOREIGN KEY test_taken_application (application_id)
    REFERENCES application (id);

-- Reference: test_taken_test (table: test_taken)
ALTER TABLE test_taken ADD CONSTRAINT test_taken_test FOREIGN KEY test_taken_test (test_id)
    REFERENCES test (id);

-- Reference: test_taken_test_status (table: test_taken)
ALTER TABLE test_taken ADD CONSTRAINT test_taken_test_status FOREIGN KEY test_taken_test_status (test_status_id)
    REFERENCES test_status (id);

-- Reference: test_test_type (table: test)
ALTER TABLE test ADD CONSTRAINT test_test_type FOREIGN KEY test_test_type (test_type_id)
    REFERENCES test_type (id);

-- End of file.


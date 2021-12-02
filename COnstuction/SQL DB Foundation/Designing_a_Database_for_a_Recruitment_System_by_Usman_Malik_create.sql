-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:53:05.434

-- tables
-- Table: answers
CREATE TABLE answers (
    id int  NOT NULL,
    application_test_id int  NOT NULL,
    recruiter_id int  NOT NULL,
    total_grades nvarchar(10)  NULL,
    pass bit  NULL,
    answer_details nvarchar(max)  NULL,
    CONSTRAINT answers_pk PRIMARY KEY  (id)
);

-- Table: applicant
CREATE TABLE applicant (
    id int  NOT NULL,
    first_name varchar(100)  NOT NULL,
    last_name varchar(100)  NOT NULL,
    email nvarchar(100)  NOT NULL,
    phone nvarchar(100)  NOT NULL,
    summary nvarchar(max)  NOT NULL,
    CONSTRAINT applicant_pk PRIMARY KEY  (id)
);

-- Table: applicant_evaluation
CREATE TABLE applicant_evaluation (
    id int  NOT NULL,
    notes nvarchar(max)  NOT NULL,
    recruiter_id int  NOT NULL,
    application_id int  NOT NULL,
    hired bit  NULL,
    CONSTRAINT applicant_evaluation_pk PRIMARY KEY  (id)
);

-- Table: application
CREATE TABLE application (
    id int  NOT NULL,
    date_of_application datetime  NOT NULL,
    education nvarchar(max)  NOT NULL,
    experience nvarchar(max)  NOT NULL,
    other_info nvarchar(max)  NOT NULL,
    jobs_id int  NOT NULL,
    applicant_id int  NOT NULL,
    CONSTRAINT application_pk PRIMARY KEY  (id)
);

-- Table: application_document
CREATE TABLE application_document (
    id int  NOT NULL,
    document_id int  NOT NULL,
    application_id int  NOT NULL,
    CONSTRAINT application_document_pk PRIMARY KEY  (id)
);

-- Table: application_status
CREATE TABLE application_status (
    id int  NOT NULL,
    status nvarchar(100)  NOT NULL,
    CONSTRAINT application_status_pk PRIMARY KEY  (id)
);

-- Table: application_status_change
CREATE TABLE application_status_change (
    id int  NOT NULL,
    date_changed datetime  NOT NULL,
    application_status_id int  NOT NULL,
    application_id int  NOT NULL,
    CONSTRAINT application_status_change_pk PRIMARY KEY  (id)
);

-- Table: application_test
CREATE TABLE application_test (
    id int  NOT NULL,
    test_id int  NOT NULL,
    application_id int  NOT NULL,
    start_time datetime  NULL,
    end_time datetime  NULL,
    CONSTRAINT application_test_pk PRIMARY KEY  (id)
);

-- Table: document
CREATE TABLE document (
    id int  NOT NULL,
    name nvarchar(100)  NOT NULL,
    document binary(1000)  NULL,
    url nvarchar(200)  NULL,
    last_update datetime  NOT NULL,
    CONSTRAINT document_pk PRIMARY KEY  (id)
);

-- Table: interview
CREATE TABLE interview (
    id int  NOT NULL,
    start_time datetime  NOT NULL,
    end_time datetime  NOT NULL,
    application_id int  NOT NULL,
    CONSTRAINT interview_pk PRIMARY KEY  (id)
);

-- Table: interview_note
CREATE TABLE interview_note (
    id int  NOT NULL,
    notes nvarchar(max)  NULL,
    interview_id int  NOT NULL,
    recruiter_id int  NOT NULL,
    pass bit  NULL,
    CONSTRAINT interview_note_pk PRIMARY KEY  (id)
);

-- Table: job
CREATE TABLE job (
    id int  NOT NULL,
    code nvarchar(10)  NOT NULL,
    name nvarchar(100)  NOT NULL,
    description nvarchar(max)  NOT NULL,
    date_published datetime  NOT NULL,
    job_start_date datetime  NOT NULL,
    no_of_vacancies int  NOT NULL,
    job_category_id int  NOT NULL,
    job_position_id int  NOT NULL,
    job_platform_id int  NOT NULL,
    organizations_id int  NOT NULL,
    process_id int  NOT NULL,
    CONSTRAINT job_pk PRIMARY KEY  (id)
);

-- Table: job_category
CREATE TABLE job_category (
    id int  NOT NULL,
    code nvarchar(10)  NOT NULL,
    name nvarchar(100)  NOT NULL,
    description nvarchar(max)  NOT NULL,
    CONSTRAINT job_category_pk PRIMARY KEY  (id)
);

-- Table: job_platform
CREATE TABLE job_platform (
    id int  NOT NULL,
    code varchar(10)  NOT NULL,
    name nvarchar(100)  NOT NULL,
    description nvarchar(max)  NOT NULL,
    CONSTRAINT job_platform_pk PRIMARY KEY  (id)
);

-- Table: job_position
CREATE TABLE job_position (
    id int  NOT NULL,
    code nvarchar(10)  NOT NULL,
    name varchar(100)  NOT NULL,
    description nvarchar(max)  NOT NULL,
    CONSTRAINT job_position_pk PRIMARY KEY  (id)
);

-- Table: organization
CREATE TABLE organization (
    id int  NOT NULL,
    code nvarchar(10)  NOT NULL,
    name nvarchar(100)  NOT NULL,
    description nvarchar(max)  NOT NULL,
    CONSTRAINT organization_pk PRIMARY KEY  (id)
);

-- Table: process
CREATE TABLE process (
    id int  NOT NULL,
    code nvarchar(10)  NOT NULL,
    description nvarchar(max)  NOT NULL,
    recruiter_id int  NOT NULL,
    CONSTRAINT process_pk PRIMARY KEY  (id)
);

-- Table: process_step
CREATE TABLE process_step (
    id int  NOT NULL,
    step_id int  NOT NULL,
    process_id int  NOT NULL,
    status varchar  NULL,
    priority int  NOT NULL,
    CONSTRAINT process_step_pk PRIMARY KEY  (id)
);

-- Table: recruiter
CREATE TABLE recruiter (
    id int  NOT NULL,
    first_name nvarchar(100)  NOT NULL,
    last_name nvarchar(100)  NOT NULL,
    CONSTRAINT recruiter_pk PRIMARY KEY  (id)
);

-- Table: step
CREATE TABLE step (
    id int  NOT NULL,
    code varchar(10)  NOT NULL,
    name nvarchar(100)  NOT NULL,
    CONSTRAINT step_pk PRIMARY KEY  (id)
);

-- Table: test
CREATE TABLE test (
    id int  NOT NULL,
    code nvarchar(10)  NOT NULL,
    duration int  NULL,
    max_score int  NOT NULL,
    CONSTRAINT test_pk PRIMARY KEY  (id)
);

-- foreign keys
-- Reference: applicant_evaluations_applications (table: applicant_evaluation)
ALTER TABLE applicant_evaluation ADD CONSTRAINT applicant_evaluations_applications
    FOREIGN KEY (application_id)
    REFERENCES application (id);

-- Reference: applicant_evaluations_recruiters (table: applicant_evaluation)
ALTER TABLE applicant_evaluation ADD CONSTRAINT applicant_evaluations_recruiters
    FOREIGN KEY (recruiter_id)
    REFERENCES recruiter (id);

-- Reference: application_document_applications (table: application_document)
ALTER TABLE application_document ADD CONSTRAINT application_document_applications
    FOREIGN KEY (application_id)
    REFERENCES application (id);

-- Reference: application_document_documents (table: application_document)
ALTER TABLE application_document ADD CONSTRAINT application_document_documents
    FOREIGN KEY (document_id)
    REFERENCES document (id);

-- Reference: application_status_changes_application_status (table: application_status_change)
ALTER TABLE application_status_change ADD CONSTRAINT application_status_changes_application_status
    FOREIGN KEY (application_status_id)
    REFERENCES application_status (id);

-- Reference: application_status_changes_applications (table: application_status_change)
ALTER TABLE application_status_change ADD CONSTRAINT application_status_changes_applications
    FOREIGN KEY (application_id)
    REFERENCES application (id);

-- Reference: application_test_applications (table: application_test)
ALTER TABLE application_test ADD CONSTRAINT application_test_applications
    FOREIGN KEY (application_id)
    REFERENCES application (id);

-- Reference: application_test_tests (table: application_test)
ALTER TABLE application_test ADD CONSTRAINT application_test_tests
    FOREIGN KEY (test_id)
    REFERENCES test (id);

-- Reference: applications_applicants (table: application)
ALTER TABLE application ADD CONSTRAINT applications_applicants
    FOREIGN KEY (applicant_id)
    REFERENCES applicant (id);

-- Reference: applications_jobs (table: application)
ALTER TABLE application ADD CONSTRAINT applications_jobs
    FOREIGN KEY (jobs_id)
    REFERENCES job (id);

-- Reference: interview_application (table: interview)
ALTER TABLE interview ADD CONSTRAINT interview_application
    FOREIGN KEY (application_id)
    REFERENCES application (id);

-- Reference: interview_notes_interview (table: interview_note)
ALTER TABLE interview_note ADD CONSTRAINT interview_notes_interview
    FOREIGN KEY (interview_id)
    REFERENCES interview (id);

-- Reference: interview_notes_recruiter (table: interview_note)
ALTER TABLE interview_note ADD CONSTRAINT interview_notes_recruiter
    FOREIGN KEY (recruiter_id)
    REFERENCES recruiter (id);

-- Reference: job_process (table: job)
ALTER TABLE job ADD CONSTRAINT job_process
    FOREIGN KEY (process_id)
    REFERENCES process (id);

-- Reference: jobs_job_categories (table: job)
ALTER TABLE job ADD CONSTRAINT jobs_job_categories
    FOREIGN KEY (job_category_id)
    REFERENCES job_category (id);

-- Reference: jobs_job_platforms (table: job)
ALTER TABLE job ADD CONSTRAINT jobs_job_platforms
    FOREIGN KEY (job_platform_id)
    REFERENCES job_platform (id);

-- Reference: jobs_job_positions (table: job)
ALTER TABLE job ADD CONSTRAINT jobs_job_positions
    FOREIGN KEY (job_position_id)
    REFERENCES job_position (id);

-- Reference: jobs_organizations (table: job)
ALTER TABLE job ADD CONSTRAINT jobs_organizations
    FOREIGN KEY (organizations_id)
    REFERENCES organization (id);

-- Reference: process_recruiter (table: process)
ALTER TABLE process ADD CONSTRAINT process_recruiter
    FOREIGN KEY (recruiter_id)
    REFERENCES recruiter (id);

-- Reference: process_step_process (table: process_step)
ALTER TABLE process_step ADD CONSTRAINT process_step_process
    FOREIGN KEY (process_id)
    REFERENCES process (id);

-- Reference: process_step_step (table: process_step)
ALTER TABLE process_step ADD CONSTRAINT process_step_step
    FOREIGN KEY (step_id)
    REFERENCES step (id);

-- Reference: test_grades_application_test (table: answers)
ALTER TABLE answers ADD CONSTRAINT test_grades_application_test
    FOREIGN KEY (application_test_id)
    REFERENCES application_test (id);

-- Reference: test_grades_recruiters (table: answers)
ALTER TABLE answers ADD CONSTRAINT test_grades_recruiters
    FOREIGN KEY (recruiter_id)
    REFERENCES recruiter (id);

-- End of file.


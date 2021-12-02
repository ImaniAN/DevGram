-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:17:53.945

-- tables
-- Table: attachment
CREATE TABLE attachment (
    id int NOT NULL,
    message_id int NOT NULL,
    attachment_link text NOT NULL,
    CONSTRAINT attachment_pk PRIMARY KEY (id)
);

-- Table: certification
CREATE TABLE certification (
    id int NOT NULL AUTO_INCREMENT,
    freelancer_id int NOT NULL,
    certification_name varchar(255) NOT NULL,
    provider varchar(255) NOT NULL,
    description text NOT NULL,
    date_earned date NOT NULL,
    certification_link text NULL,
    CONSTRAINT certification_pk PRIMARY KEY (id)
) COMMENT 'all certifications related with user';

-- Table: company
CREATE TABLE company (
    id int NOT NULL AUTO_INCREMENT,
    company_name varchar(128) NOT NULL,
    company_location varchar(255) NOT NULL,
    CONSTRAINT company_pk PRIMARY KEY (id)
);

-- Table: complexity
CREATE TABLE complexity (
    id int NOT NULL AUTO_INCREMENT,
    complexity_text varchar(255) NOT NULL,
    CONSTRAINT complexity_pk PRIMARY KEY (id)
) COMMENT 'easy, intermediate, hard';

-- Table: contract
CREATE TABLE contract (
    id int NOT NULL AUTO_INCREMENT,
    proposal_id int NOT NULL,
    company_id int NOT NULL,
    freelancer_id int NOT NULL,
    start_time timestamp NOT NULL,
    end_time timestamp NULL,
    payment_type_id int NOT NULL,
    payment_amount decimal(8,2) NOT NULL,
    CONSTRAINT contract_pk PRIMARY KEY (id)
);

-- Table: expected_duration
CREATE TABLE expected_duration (
    id int NOT NULL AUTO_INCREMENT,
    duration_text varchar(255) NOT NULL,
    UNIQUE INDEX expected_duration_ak_1 (duration_text),
    CONSTRAINT expected_duration_pk PRIMARY KEY (id)
) COMMENT 'predefined intervals, e.g. 1 day, 2-5 days, 5-10 days, less than 1 month, 1-3 months, 3-6 months, 6 or more months';

-- Table: freelancer
CREATE TABLE freelancer (
    id int NOT NULL AUTO_INCREMENT,
    user_account_id int NOT NULL,
    registration_date date NOT NULL,
    location varchar(255) NOT NULL,
    overview text NOT NULL,
    UNIQUE INDEX freelancer_ak_1 (user_account_id),
    CONSTRAINT freelancer_pk PRIMARY KEY (id)
);

-- Table: has_skill
CREATE TABLE has_skill (
    id int NOT NULL AUTO_INCREMENT,
    freelancer_id int NOT NULL,
    skill_id int NOT NULL,
    UNIQUE INDEX has_skill_ak_1 (freelancer_id,skill_id),
    CONSTRAINT has_skill_pk PRIMARY KEY (id)
);

-- Table: hire_manager
CREATE TABLE hire_manager (
    id int NOT NULL AUTO_INCREMENT,
    user_account_id int NOT NULL,
    registration_date date NOT NULL,
    location varchar(255) NOT NULL,
    company_id int NULL,
    UNIQUE INDEX hire_manager_ak_1 (user_account_id),
    CONSTRAINT hire_manager_pk PRIMARY KEY (id)
);

-- Table: job
CREATE TABLE job (
    id int NOT NULL AUTO_INCREMENT,
    hire_manager_id int NOT NULL,
    expected_duration_id int NOT NULL,
    complexity_id int NOT NULL,
    description text NOT NULL,
    main_skill_id int NOT NULL,
    payment_type_id int NOT NULL,
    payment_amount decimal(8,2) NOT NULL,
    CONSTRAINT job_pk PRIMARY KEY (id)
);

-- Table: message
CREATE TABLE message (
    id int NOT NULL AUTO_INCREMENT,
    freelancer_id int NULL,
    hire_manager_id int NULL,
    message_time timestamp NOT NULL,
    message_text text NOT NULL,
    proposal_id int NOT NULL,
    proposal_status_catalog_id int NULL COMMENT 'hire manager or freelancer can set status with each message',
    CONSTRAINT message_pk PRIMARY KEY (id)
) COMMENT 'sender is either freelancer, either hire manager';

-- Table: other_skills
CREATE TABLE other_skills (
    id int NOT NULL AUTO_INCREMENT,
    job_id int NOT NULL,
    skill_id int NOT NULL,
    UNIQUE INDEX other_skills_ak_1 (job_id,skill_id),
    CONSTRAINT other_skills_pk PRIMARY KEY (id)
);

-- Table: payment_type
CREATE TABLE payment_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(128) NOT NULL,
    UNIQUE INDEX payment_type_ak_1 (type_name),
    CONSTRAINT payment_type_pk PRIMARY KEY (id)
) COMMENT 'per hour, fixed price';

-- Table: proposal
CREATE TABLE proposal (
    id int NOT NULL AUTO_INCREMENT,
    job_id int NOT NULL,
    freelancer_id int NOT NULL,
    proposal_time timestamp NOT NULL,
    payment_type_id int NOT NULL,
    payment_amount decimal(8,2) NOT NULL,
    current_proposal_status int NOT NULL,
    client_grade int NULL,
    client_comment text NULL,
    freelancer_grade int NULL,
    freelancer_comment text NULL,
    CONSTRAINT proposal_pk PRIMARY KEY (id)
);

-- Table: proposal_status_catalog
CREATE TABLE proposal_status_catalog (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(128) NOT NULL,
    UNIQUE INDEX proposal_status_catalog_ak_1 (status_name),
    CONSTRAINT proposal_status_catalog_pk PRIMARY KEY (id)
) COMMENT 'proposal sent, negotiation phase, proposal withdrawn, proposal rejected/accepted, job started, job finished (successfully), job finished (unsuccessfully)';

-- Table: skill
CREATE TABLE skill (
    id int NOT NULL AUTO_INCREMENT,
    skill_name varchar(128) NOT NULL,
    UNIQUE INDEX skill_ak_1 (skill_name),
    CONSTRAINT skill_pk PRIMARY KEY (id)
) COMMENT 'list of all skills - used to describe freelancers and jobs';

-- Table: test
CREATE TABLE test (
    id int NOT NULL AUTO_INCREMENT,
    test_name varchar(128) NOT NULL,
    test_link text NOT NULL,
    UNIQUE INDEX test_ak_1 (test_name),
    CONSTRAINT test_pk PRIMARY KEY (id)
) COMMENT 'list of all possible tests';

-- Table: test_result
CREATE TABLE test_result (
    id int NOT NULL AUTO_INCREMENT,
    freelancer_id int NOT NULL,
    test_id int NOT NULL,
    start_time timestamp NOT NULL,
    end_time timestamp NULL,
    test_result_link text NULL,
    score decimal(5,2) NULL,
    display_on_profile bool NULL,
    CONSTRAINT test_result_pk PRIMARY KEY (id)
);

-- Table: user_account
CREATE TABLE user_account (
    id int NOT NULL AUTO_INCREMENT,
    user_name varchar(128) NOT NULL,
    password varchar(32) NOT NULL,
    email varchar(128) NOT NULL,
    first_name varchar(128) NOT NULL,
    last_name varchar(128) NOT NULL,
    UNIQUE INDEX user_account_ak_1 (user_name),
    UNIQUE INDEX user_account_ak_2 (email),
    CONSTRAINT user_account_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: attachment_message (table: attachment)
ALTER TABLE attachment ADD CONSTRAINT attachment_message FOREIGN KEY attachment_message (message_id)
    REFERENCES message (id);

-- Reference: certification_freelancer (table: certification)
ALTER TABLE certification ADD CONSTRAINT certification_freelancer FOREIGN KEY certification_freelancer (freelancer_id)
    REFERENCES freelancer (id);

-- Reference: contract_company (table: contract)
ALTER TABLE contract ADD CONSTRAINT contract_company FOREIGN KEY contract_company (company_id)
    REFERENCES company (id);

-- Reference: contract_freelancer (table: contract)
ALTER TABLE contract ADD CONSTRAINT contract_freelancer FOREIGN KEY contract_freelancer (freelancer_id)
    REFERENCES freelancer (id);

-- Reference: contract_payment_type (table: contract)
ALTER TABLE contract ADD CONSTRAINT contract_payment_type FOREIGN KEY contract_payment_type (payment_type_id)
    REFERENCES payment_type (id);

-- Reference: contract_proposal (table: contract)
ALTER TABLE contract ADD CONSTRAINT contract_proposal FOREIGN KEY contract_proposal (proposal_id)
    REFERENCES proposal (id);

-- Reference: freelancer_user_account (table: freelancer)
ALTER TABLE freelancer ADD CONSTRAINT freelancer_user_account FOREIGN KEY freelancer_user_account (user_account_id)
    REFERENCES user_account (id);

-- Reference: has_skill_freelancer (table: has_skill)
ALTER TABLE has_skill ADD CONSTRAINT has_skill_freelancer FOREIGN KEY has_skill_freelancer (freelancer_id)
    REFERENCES freelancer (id);

-- Reference: has_skill_skill (table: has_skill)
ALTER TABLE has_skill ADD CONSTRAINT has_skill_skill FOREIGN KEY has_skill_skill (skill_id)
    REFERENCES skill (id);

-- Reference: hire_manager_company (table: hire_manager)
ALTER TABLE hire_manager ADD CONSTRAINT hire_manager_company FOREIGN KEY hire_manager_company (company_id)
    REFERENCES company (id);

-- Reference: hire_manager_user_account (table: hire_manager)
ALTER TABLE hire_manager ADD CONSTRAINT hire_manager_user_account FOREIGN KEY hire_manager_user_account (user_account_id)
    REFERENCES user_account (id);

-- Reference: job_complexity (table: job)
ALTER TABLE job ADD CONSTRAINT job_complexity FOREIGN KEY job_complexity (complexity_id)
    REFERENCES complexity (id);

-- Reference: job_expected_duration (table: job)
ALTER TABLE job ADD CONSTRAINT job_expected_duration FOREIGN KEY job_expected_duration (expected_duration_id)
    REFERENCES expected_duration (id);

-- Reference: job_hire_manager (table: job)
ALTER TABLE job ADD CONSTRAINT job_hire_manager FOREIGN KEY job_hire_manager (hire_manager_id)
    REFERENCES hire_manager (id);

-- Reference: job_payment_type (table: job)
ALTER TABLE job ADD CONSTRAINT job_payment_type FOREIGN KEY job_payment_type (payment_type_id)
    REFERENCES payment_type (id);

-- Reference: job_skill (table: job)
ALTER TABLE job ADD CONSTRAINT job_skill FOREIGN KEY job_skill (main_skill_id)
    REFERENCES skill (id);

-- Reference: message_freelancer (table: message)
ALTER TABLE message ADD CONSTRAINT message_freelancer FOREIGN KEY message_freelancer (freelancer_id)
    REFERENCES freelancer (id);

-- Reference: message_hire_manager (table: message)
ALTER TABLE message ADD CONSTRAINT message_hire_manager FOREIGN KEY message_hire_manager (hire_manager_id)
    REFERENCES hire_manager (id);

-- Reference: message_proposal (table: message)
ALTER TABLE message ADD CONSTRAINT message_proposal FOREIGN KEY message_proposal (proposal_id)
    REFERENCES proposal (id);

-- Reference: message_proposal_status_catalog (table: message)
ALTER TABLE message ADD CONSTRAINT message_proposal_status_catalog FOREIGN KEY message_proposal_status_catalog (proposal_status_catalog_id)
    REFERENCES proposal_status_catalog (id);

-- Reference: other_skills_job (table: other_skills)
ALTER TABLE other_skills ADD CONSTRAINT other_skills_job FOREIGN KEY other_skills_job (job_id)
    REFERENCES job (id);

-- Reference: other_skills_skill (table: other_skills)
ALTER TABLE other_skills ADD CONSTRAINT other_skills_skill FOREIGN KEY other_skills_skill (skill_id)
    REFERENCES skill (id);

-- Reference: proposal_freelancer (table: proposal)
ALTER TABLE proposal ADD CONSTRAINT proposal_freelancer FOREIGN KEY proposal_freelancer (freelancer_id)
    REFERENCES freelancer (id);

-- Reference: proposal_job (table: proposal)
ALTER TABLE proposal ADD CONSTRAINT proposal_job FOREIGN KEY proposal_job (job_id)
    REFERENCES job (id);

-- Reference: proposal_payment_type (table: proposal)
ALTER TABLE proposal ADD CONSTRAINT proposal_payment_type FOREIGN KEY proposal_payment_type (payment_type_id)
    REFERENCES payment_type (id);

-- Reference: proposal_proposal_status_catalog (table: proposal)
ALTER TABLE proposal ADD CONSTRAINT proposal_proposal_status_catalog FOREIGN KEY proposal_proposal_status_catalog (current_proposal_status)
    REFERENCES proposal_status_catalog (id);

-- Reference: test_result_freelancer (table: test_result)
ALTER TABLE test_result ADD CONSTRAINT test_result_freelancer FOREIGN KEY test_result_freelancer (freelancer_id)
    REFERENCES freelancer (id);

-- Reference: test_result_test (table: test_result)
ALTER TABLE test_result ADD CONSTRAINT test_result_test FOREIGN KEY test_result_test (test_id)
    REFERENCES test (id);

-- End of file.


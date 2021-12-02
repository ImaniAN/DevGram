-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:51:40.3

-- tables
-- Table: adjustment
CREATE TABLE adjustment (
    id int NOT NULL AUTO_INCREMENT,
    adjustment_name varchar(255) NOT NULL,
    adjustment_percentage decimal(10,2) NOT NULL,
    is_working_hours_adjustment bool NOT NULL,
    is_other_adjustment bool NOT NULL,
    CONSTRAINT adjustment_pk PRIMARY KEY (id)
);

-- Table: adjustment_amount
CREATE TABLE adjustment_amount (
    id int NOT NULL AUTO_INCREMENT,
    salary_payment_id int NOT NULL,
    adjustment_id int NOT NULL,
    adjustment_amount decimal(10,2) NOT NULL,
    adjustment_percentage decimal(10,2) NOT NULL,
    CONSTRAINT adjustment_amount_pk PRIMARY KEY (id)
);

-- Table: city
CREATE TABLE city (
    id int NOT NULL AUTO_INCREMENT,
    city_name varchar(255) NOT NULL,
    country_id int NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (id)
);

-- Table: country
CREATE TABLE country (
    id int NOT NULL AUTO_INCREMENT,
    country_name varchar(255) NOT NULL,
    UNIQUE INDEX country_ak_1 (country_name),
    CONSTRAINT country_pk PRIMARY KEY (id)
);

-- Table: department
CREATE TABLE department (
    id int NOT NULL AUTO_INCREMENT,
    department_name varchar(255) NOT NULL,
    UNIQUE INDEX department_ak_1 (department_name),
    CONSTRAINT department_pk PRIMARY KEY (id)
);

-- Table: department_history
CREATE TABLE department_history (
    id int NOT NULL AUTO_INCREMENT,
    department_id int NOT NULL,
    employee_id int NOT NULL AUTO_INCREMENT,
    start_date date NOT NULL,
    end_date date NULL,
    UNIQUE INDEX department_history_ak_1 (employee_id,department_id,start_date),
    CONSTRAINT department_history_pk PRIMARY KEY (id)
);

-- Table: employee
CREATE TABLE employee (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    date_of_birth date NOT NULL,
    job_title_id int NOT NULL,
    department_id int NOT NULL,
    gender_id int NOT NULL,
    address varchar(255) NOT NULL,
    city_id int NOT NULL,
    email varchar(255) NOT NULL,
    employment_start date NOT NULL,
    salary decimal(10,2) NOT NULL,
    CONSTRAINT employee_pk PRIMARY KEY (id)
);

-- Table: employment_terms
CREATE TABLE employment_terms (
    id int NOT NULL AUTO_INCREMENT,
    employee_id int NOT NULL,
    agreed_salary decimal(10,2) NOT NULL,
    salary_start_date date NOT NULL,
    salary_end_date date NULL,
    CONSTRAINT employment_terms_pk PRIMARY KEY (id)
);

-- Table: gender
CREATE TABLE gender (
    id int NOT NULL AUTO_INCREMENT,
    gender_name varchar(64) NOT NULL,
    UNIQUE INDEX gender_ak_1 (gender_name),
    CONSTRAINT gender_pk PRIMARY KEY (id)
);

-- Table: job_title
CREATE TABLE job_title (
    id int NOT NULL AUTO_INCREMENT,
    job_title varchar(255) NOT NULL,
    UNIQUE INDEX job_title_ak_1 (job_title),
    CONSTRAINT job_title_pk PRIMARY KEY (id)
);

-- Table: job_title_history
CREATE TABLE job_title_history (
    id int NOT NULL AUTO_INCREMENT,
    job_title_id int NOT NULL AUTO_INCREMENT,
    employee_id int NOT NULL,
    start_date date NOT NULL,
    end_date date NULL,
    UNIQUE INDEX job_title_history_ak_1 (job_title_id,employee_id,start_date),
    CONSTRAINT job_title_history_pk PRIMARY KEY (id)
);

-- Table: salary_payment
CREATE TABLE salary_payment (
    id int NOT NULL AUTO_INCREMENT,
    employee_id int NOT NULL AUTO_INCREMENT,
    gross_salary varchar(255) NOT NULL,
    net_salary varchar(255) NOT NULL,
    salary_period date NOT NULL,
    CONSTRAINT salary_payment_pk PRIMARY KEY (id)
);

-- Table: working_hours_adjustment
CREATE TABLE working_hours_adjustment (
    id int NOT NULL AUTO_INCREMENT,
    working_hours_log_id int NOT NULL,
    adjustment_id int NOT NULL,
    salary_payment_id int NULL,
    adjustment_amount int NOT NULL,
    adjustment_percentage decimal(10,2) NOT NULL,
    CONSTRAINT working_hours_adjustment_pk PRIMARY KEY (id)
);

-- Table: working_hours_log
CREATE TABLE working_hours_log (
    id int NOT NULL AUTO_INCREMENT,
    employee_id int NOT NULL,
    start_time timestamp NOT NULL,
    end_time timestamp NULL,
    CONSTRAINT working_hours_log_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: Table_18_department (table: department_history)
ALTER TABLE department_history ADD CONSTRAINT Table_18_department FOREIGN KEY Table_18_department (department_id)
    REFERENCES department (id);

-- Reference: Table_18_employee (table: department_history)
ALTER TABLE department_history ADD CONSTRAINT Table_18_employee FOREIGN KEY Table_18_employee (employee_id)
    REFERENCES employee (id);

-- Reference: adjustment_amounts_adjustments (table: adjustment_amount)
ALTER TABLE adjustment_amount ADD CONSTRAINT adjustment_amounts_adjustments FOREIGN KEY adjustment_amounts_adjustments (adjustment_id)
    REFERENCES adjustment (id);

-- Reference: city_country (table: city)
ALTER TABLE city ADD CONSTRAINT city_country FOREIGN KEY city_country (country_id)
    REFERENCES country (id);

-- Reference: employee_city (table: employee)
ALTER TABLE employee ADD CONSTRAINT employee_city FOREIGN KEY employee_city (city_id)
    REFERENCES city (id);

-- Reference: employee_department (table: employee)
ALTER TABLE employee ADD CONSTRAINT employee_department FOREIGN KEY employee_department (department_id)
    REFERENCES department (id);

-- Reference: employee_gender (table: employee)
ALTER TABLE employee ADD CONSTRAINT employee_gender FOREIGN KEY employee_gender (gender_id)
    REFERENCES gender (id);

-- Reference: employee_job_title (table: employee)
ALTER TABLE employee ADD CONSTRAINT employee_job_title FOREIGN KEY employee_job_title (job_title_id)
    REFERENCES job_title (id);

-- Reference: employment_terms_employee (table: employment_terms)
ALTER TABLE employment_terms ADD CONSTRAINT employment_terms_employee FOREIGN KEY employment_terms_employee (employee_id)
    REFERENCES employee (id);

-- Reference: job_title_history_employee (table: job_title_history)
ALTER TABLE job_title_history ADD CONSTRAINT job_title_history_employee FOREIGN KEY job_title_history_employee (employee_id)
    REFERENCES employee (id);

-- Reference: job_title_history_job_title (table: job_title_history)
ALTER TABLE job_title_history ADD CONSTRAINT job_title_history_job_title FOREIGN KEY job_title_history_job_title (job_title_id)
    REFERENCES job_title (id);

-- Reference: other_adjustment_adjustment (table: working_hours_adjustment)
ALTER TABLE working_hours_adjustment ADD CONSTRAINT other_adjustment_adjustment FOREIGN KEY other_adjustment_adjustment (adjustment_id)
    REFERENCES adjustment (id);

-- Reference: other_adjustment_salary (table: working_hours_adjustment)
ALTER TABLE working_hours_adjustment ADD CONSTRAINT other_adjustment_salary FOREIGN KEY other_adjustment_salary (salary_payment_id)
    REFERENCES salary_payment (id);

-- Reference: other_adjustment_working_hours_log (table: working_hours_adjustment)
ALTER TABLE working_hours_adjustment ADD CONSTRAINT other_adjustment_working_hours_log FOREIGN KEY other_adjustment_working_hours_log (working_hours_log_id)
    REFERENCES working_hours_log (id);

-- Reference: salary_adjustment_salary (table: adjustment_amount)
ALTER TABLE adjustment_amount ADD CONSTRAINT salary_adjustment_salary FOREIGN KEY salary_adjustment_salary (salary_payment_id)
    REFERENCES salary_payment (id);

-- Reference: salary_employee (table: salary_payment)
ALTER TABLE salary_payment ADD CONSTRAINT salary_employee FOREIGN KEY salary_employee (employee_id)
    REFERENCES employee (id);

-- Reference: working_hours_employee (table: working_hours_log)
ALTER TABLE working_hours_log ADD CONSTRAINT working_hours_employee FOREIGN KEY working_hours_employee (employee_id)
    REFERENCES employee (id);

-- End of file.


-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:07:47.902

-- tables
-- Table: app_booking_channel
CREATE TABLE app_booking_channel (
    id number  NOT NULL,
    app_booking_channel_name varchar2(50)  NOT NULL,
    CONSTRAINT app_booking_channel_pk PRIMARY KEY (id)
);

-- Table: appointment
CREATE TABLE appointment (
    id number  NOT NULL,
    user_account_id number  NOT NULL,
    office_id number  NOT NULL,
    probable_start_time timestamp  NOT NULL,
    actual_end_time timestamp  NULL,
    appointment_status_id number  NOT NULL,
    appointment_taken_date date  NOT NULL,
    app_booking_channel_id number  NOT NULL,
    CONSTRAINT appointment_pk PRIMARY KEY (id)
);

-- Table: appointment_status
CREATE TABLE appointment_status (
    id number  NOT NULL,
    status varchar2(10)  NOT NULL,
    CONSTRAINT appointment_status_pk PRIMARY KEY (id)
);

-- Table: client_account
CREATE TABLE client_account (
    id number  NOT NULL,
    first_name varchar2(50)  NOT NULL,
    last_name varchar2(50)  NOT NULL,
    contact_number number  NOT NULL,
    email varchar2(255)  NOT NULL,
    CONSTRAINT client_account_pk PRIMARY KEY (id)
);

-- Table: client_review
CREATE TABLE client_review (
    id number  NOT NULL,
    user_account_id number  NOT NULL,
    doctor_id number  NOT NULL,
    is_review_anonymous char(1)  NOT NULL,
    wait_time_rating number  NOT NULL,
    bedside_manner_rating number  NOT NULL,
    overall_rating number  NOT NULL,
    review varchar2(2000)  NULL,
    is_doctor_recommended char(1)  NOT NULL,
    review_date date  NOT NULL,
    CONSTRAINT client_review_pk PRIMARY KEY (id)
);

-- Table: doctor
CREATE TABLE doctor (
    id number  NOT NULL,
    first_name varchar2(50)  NOT NULL,
    last_name varchar2(50)  NOT NULL,
    professional_statement varchar2(4000)  NOT NULL,
    practicing_from date  NOT NULL,
    CONSTRAINT doctor_pk PRIMARY KEY (id)
);

-- Table: doctor_specialization
CREATE TABLE doctor_specialization (
    id number  NOT NULL,
    doctor_id number  NOT NULL,
    specialization_id number  NOT NULL,
    CONSTRAINT doctor_specialization_pk PRIMARY KEY (id)
);

-- Table: hospital_affiliation
CREATE TABLE hospital_affiliation (
    id number  NOT NULL,
    doctor_id number  NOT NULL,
    hospital_name varchar2(100)  NOT NULL,
    city varchar2(50)  NOT NULL,
    country varchar2(50)  NOT NULL,
    start_date date  NOT NULL,
    end_date date  NULL,
    CONSTRAINT hospital_affiliation_pk PRIMARY KEY (id)
);

-- Table: in_network_insurance
CREATE TABLE in_network_insurance (
    id number  NOT NULL,
    insurance_name varchar2(200)  NOT NULL,
    office_id number  NOT NULL,
    CONSTRAINT in_network_insurance_pk PRIMARY KEY (id)
);

-- Table: office
CREATE TABLE office (
    id number  NOT NULL,
    doctor_id number  NOT NULL,
    hospital_affiliation_id number  NULL,
    time_slot_per_client_in_min number  NOT NULL,
    first_consultation_fee number  NOT NULL,
    followup_consultation_fee number  NOT NULL,
    street_address varchar2(500)  NOT NULL,
    city varchar2(100)  NOT NULL,
    state varchar2(100)  NOT NULL,
    country varchar2(100)  NOT NULL,
    zip varchar2(50)  NOT NULL,
    CONSTRAINT office_pk PRIMARY KEY (id)
);

-- Table: office_doctor_availability
CREATE TABLE office_doctor_availability (
    id number  NOT NULL,
    office_id number  NOT NULL,
    day_of_week varchar2(10)  NOT NULL,
    start_time timestamp  NOT NULL,
    end_time timestamp  NOT NULL,
    is_available char(1)  NOT NULL,
    reason_of_unavailability varchar2(500)  NULL,
    CONSTRAINT office_doctor_availability_pk PRIMARY KEY (id)
);

-- Table: qualification
CREATE TABLE qualification (
    id number  NOT NULL,
    doctor_id number  NOT NULL,
    qualification_name varchar2(200)  NOT NULL,
    institute_name varchar2(200)  NULL,
    procurement_year date  NOT NULL,
    CONSTRAINT qualification_pk PRIMARY KEY (id)
);

-- Table: specialization
CREATE TABLE specialization (
    id number  NOT NULL,
    specialization_name varchar2(100)  NOT NULL,
    CONSTRAINT specialization_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: Table_10_opd (table: office_doctor_availability)
ALTER TABLE office_doctor_availability ADD CONSTRAINT Table_10_opd
    FOREIGN KEY (office_id)
    REFERENCES office (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Table_6_opd (table: appointment)
ALTER TABLE appointment ADD CONSTRAINT Table_6_opd
    FOREIGN KEY (office_id)
    REFERENCES office (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Table_6_user_account (table: appointment)
ALTER TABLE appointment ADD CONSTRAINT Table_6_user_account
    FOREIGN KEY (user_account_id)
    REFERENCES client_account (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: app_app_booking_channel (table: appointment)
ALTER TABLE appointment ADD CONSTRAINT app_app_booking_channel
    FOREIGN KEY (app_booking_channel_id)
    REFERENCES app_booking_channel (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: appointment_appointment_status (table: appointment)
ALTER TABLE appointment ADD CONSTRAINT appointment_appointment_status
    FOREIGN KEY (appointment_status_id)
    REFERENCES appointment_status (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: client_review_doctor (table: client_review)
ALTER TABLE client_review ADD CONSTRAINT client_review_doctor
    FOREIGN KEY (doctor_id)
    REFERENCES doctor (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: client_review_user_account (table: client_review)
ALTER TABLE client_review ADD CONSTRAINT client_review_user_account
    FOREIGN KEY (user_account_id)
    REFERENCES client_account (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: doctor_spec_spec (table: doctor_specialization)
ALTER TABLE doctor_specialization ADD CONSTRAINT doctor_spec_spec
    FOREIGN KEY (specialization_id)
    REFERENCES specialization (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: doctor_specialization_doctor (table: doctor_specialization)
ALTER TABLE doctor_specialization ADD CONSTRAINT doctor_specialization_doctor
    FOREIGN KEY (doctor_id)
    REFERENCES doctor (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: education_doctor (table: qualification)
ALTER TABLE qualification ADD CONSTRAINT education_doctor
    FOREIGN KEY (doctor_id)
    REFERENCES doctor (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: hospital_affiliation_doctor (table: hospital_affiliation)
ALTER TABLE hospital_affiliation ADD CONSTRAINT hospital_affiliation_doctor
    FOREIGN KEY (doctor_id)
    REFERENCES doctor (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: in_ntw_ins_out_patient_dept (table: in_network_insurance)
ALTER TABLE in_network_insurance ADD CONSTRAINT in_ntw_ins_out_patient_dept
    FOREIGN KEY (office_id)
    REFERENCES office (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: opd_doctor (table: office)
ALTER TABLE office ADD CONSTRAINT opd_doctor
    FOREIGN KEY (doctor_id)
    REFERENCES doctor (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: opd_hospital_affiliation (table: office)
ALTER TABLE office ADD CONSTRAINT opd_hospital_affiliation
    FOREIGN KEY (hospital_affiliation_id)
    REFERENCES hospital_affiliation (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.


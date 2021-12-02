-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:08:50.33

-- tables
-- Table: activity
CREATE TABLE activity (
    id number  NOT NULL,
    activity_name varchar2(50)  NOT NULL,
    activity_multiplier number  NOT NULL,
    CONSTRAINT activity_pk PRIMARY KEY (id)
);

-- Table: activity_log
CREATE TABLE activity_log (
    id number  NOT NULL,
    user_profile_id number  NOT NULL,
    activity_id number  NOT NULL,
    start_time date  NOT NULL,
    end_time date  NULL,
    distance_covered number  NULL,
    steps_count number  NULL,
    calories_burnt number  NULL,
    CONSTRAINT activity_log_pk PRIMARY KEY (id)
);

-- Table: allergy
CREATE TABLE allergy (
    id number  NOT NULL,
    user_profile_id number  NOT NULL,
    allergy_type_id number  NOT NULL,
    allergy_reaction_id number  NOT NULL,
    first_observed date  NOT NULL,
    consulting_doctor_name varchar2(50)  NOT NULL,
    treatment_brief varchar2(2000)  NULL,
    does_treatement_cure_allergy char(1)  NOT NULL,
    CONSTRAINT allergy_pk PRIMARY KEY (id)
);

-- Table: allergy_reaction
CREATE TABLE allergy_reaction (
    id number  NOT NULL,
    allergy_reaction varchar2(100)  NOT NULL,
    CONSTRAINT allergy_reaction_pk PRIMARY KEY (id)
);

-- Table: allergy_type
CREATE TABLE allergy_type (
    id number  NOT NULL,
    allergy_type varchar2(30)  NOT NULL,
    CONSTRAINT allergy_type_pk PRIMARY KEY (id)
);

-- Table: blood_cholesterol
CREATE TABLE blood_cholesterol (
    id number  NOT NULL,
    cholesterol_ldl number  NOT NULL,
    cholesterol_hdl number  NOT NULL,
    cholesterol_Triglycerides number  NOT NULL,
    cholesterol_total number  NOT NULL,
    cholesterol_unit_id number  NOT NULL,
    measure_method_id number  NOT NULL,
    compare_to_normal_id number  NOT NULL,
    CONSTRAINT blood_cholesterol_pk PRIMARY KEY (id)
);

-- Table: blood_glucose
CREATE TABLE blood_glucose (
    id number  NOT NULL,
    measurement number  NOT NULL,
    measurement_unit_id number  NOT NULL,
    measurement_context varchar2(50)  NOT NULL,
    measurement_type varchar2(20)  NOT NULL,
    comparison_to_normal_id number  NOT NULL,
    CONSTRAINT blood_glucose_pk PRIMARY KEY (id)
);

-- Table: blood_pressure
CREATE TABLE blood_pressure (
    id number  NOT NULL,
    systolic number  NOT NULL,
    diastolic number  NOT NULL,
    pulse_beats_per_minute number  NULL,
    is_irregular_pulse_detected char(1)  NULL,
    measurement_context varchar2(50)  NOT NULL,
    comparison_to_normal_id number  NOT NULL,
    CONSTRAINT blood_pressure_pk PRIMARY KEY (id)
);

-- Table: body_area
CREATE TABLE body_area (
    id number  NOT NULL,
    body_area_name varchar2(30)  NOT NULL,
    CONSTRAINT body_area_pk PRIMARY KEY (id)
);

-- Table: body_composition
CREATE TABLE body_composition (
    id number  NOT NULL,
    body_fat_percentage number  NOT NULL,
    body_bone_percentage number  NOT NULL,
    lean_tissue_percentage number  NOT NULL,
    body_muscle_percentage number  NOT NULL,
    body_water_percentage number  NOT NULL,
    body_mass_index number  NOT NULL,
    measurement_method_id number  NOT NULL,
    compare_to_normal_id number  NOT NULL,
    measurement_context varchar2(50)  NOT NULL,
    CONSTRAINT body_composition_pk PRIMARY KEY (id)
);

-- Table: body_dimension
CREATE TABLE body_dimension (
    id number  NOT NULL,
    body_area_id number  NOT NULL,
    measurement number  NOT NULL,
    measurement_unit_id number  NOT NULL,
    CONSTRAINT body_dimension_pk PRIMARY KEY (id,body_area_id)
);

-- Table: body_height
CREATE TABLE body_height (
    id number  NOT NULL,
    height number  NOT NULL,
    measurement_unit_id number  NOT NULL,
    CONSTRAINT body_height_pk PRIMARY KEY (id)
);

-- Table: body_vitals_log
CREATE TABLE body_vitals_log (
    user_profile_id number  NOT NULL,
    dt_created date  NOT NULL,
    data_source_id number  NOT NULL,
    blood_glucose_id number  NULL,
    blood_pressure_id number  NULL,
    body_composition_id number  NULL,
    blood_cholesterol_id number  NULL,
    body_weight_id number  NULL,
    body_dimension_id number  NULL,
    body_dimension_body_area_id number  NULL,
    body_height_id number  NULL,
    CONSTRAINT body_vitals_log_pk PRIMARY KEY (user_profile_id,dt_created)
);

-- Table: body_weight
CREATE TABLE body_weight (
    id number  NOT NULL,
    weight number  NOT NULL,
    measurement_unit_id number  NOT NULL,
    CONSTRAINT body_weight_pk PRIMARY KEY (id)
);

-- Table: characteristic_data
CREATE TABLE characteristic_data (
    user_profile_id number  NOT NULL,
    date_of_birth date  NOT NULL,
    biological_gender char(1)  NOT NULL,
    current_gender char(1)  NULL,
    blood_type char(2)  NOT NULL,
    blood_rh_factor char(1)  NOT NULL,
    fitzpatrick_skin_type char(2)  NOT NULL,
    CONSTRAINT characteristic_data_pk PRIMARY KEY (user_profile_id)
);

-- Table: comparison_to_normal
CREATE TABLE comparison_to_normal (
    id number  NOT NULL,
    text varchar2(50)  NOT NULL,
    CONSTRAINT comparison_to_normal_pk PRIMARY KEY (id)
);

-- Table: data_source
CREATE TABLE data_source (
    id number  NOT NULL,
    source_name varchar2(50)  NOT NULL,
    CONSTRAINT data_source_pk PRIMARY KEY (id)
);

-- Table: family_history
CREATE TABLE family_history (
    id number  NOT NULL,
    user_profile_id number  NOT NULL,
    relationship_id number  NOT NULL,
    relative_name varchar2(100)  NOT NULL,
    date_of_birth date  NOT NULL,
    date_of_death date  NULL,
    condition_brief varchar2(1000)  NULL,
    current_status char(1)  NOT NULL,
    how_it_ended varchar2(100)  NULL,
    CONSTRAINT family_history_pk PRIMARY KEY (id)
);

-- Table: immunization
CREATE TABLE immunization (
    id number  NOT NULL,
    user_profile_id number  NOT NULL,
    vaccination_name varchar2(100)  NOT NULL,
    dt_received date  NOT NULL,
    number_in_sequence number  NULL,
    provider_name varchar2(100)  NOT NULL,
    how_administered varchar2(10)  NOT NULL,
    manufacturer varchar2(100)  NOT NULL,
    body_area_id number  NOT NULL,
    CONSTRAINT immunization_pk PRIMARY KEY (id)
);

-- Table: measurement_method
CREATE TABLE measurement_method (
    id number  NOT NULL,
    method_name varchar2(100)  NOT NULL,
    CONSTRAINT measurement_method_pk PRIMARY KEY (id)
);

-- Table: measurement_unit_type
CREATE TABLE measurement_unit_type (
    id number  NOT NULL,
    measurement_parameter varchar2(50)  NOT NULL,
    unit_name varchar2(10)  NOT NULL,
    CONSTRAINT measurement_unit_type_pk PRIMARY KEY (id)
);

-- Table: profile_dashboard_config
CREATE TABLE profile_dashboard_config (
    user_profile_id number  NOT NULL,
    is_blood_glucose_shown char(1)  NOT NULL,
    is_blood_pressure_shown char(1)  NOT NULL,
    is_body_composition_shown char(1)  NOT NULL,
    is_blood_choleserol_shown char(1)  NOT NULL,
    is_body_height_shown char(1)  NOT NULL,
    is_body_weight_shown char(1)  NOT NULL,
    is_body_dimension_shown char(1)  NOT NULL,
    is_calories_burnt_shown char(1)  NOT NULL,
    CONSTRAINT profile_dashboard_config_pk PRIMARY KEY (user_profile_id)
);

-- Table: relationship
CREATE TABLE relationship (
    id number  NOT NULL,
    relationship_name varchar2(50)  NOT NULL,
    CONSTRAINT relationship_pk PRIMARY KEY (id)
);

-- Table: user_account
CREATE TABLE user_account (
    id number  NOT NULL,
    login_name varchar2(100)  NOT NULL,
    enc_password varchar2(500)  NOT NULL,
    street_address varchar2(500)  NULL,
    city varchar2(100)  NULL,
    state varchar2(100)  NULL,
    country varchar2(100)  NULL,
    zip varchar2(20)  NULL,
    contact_number number  NOT NULL,
    email varchar2(255)  NOT NULL,
    is_active char(1)  NOT NULL,
    account_image blob  NULL,
    CONSTRAINT user_account_pk PRIMARY KEY (id)
);

-- Table: user_bmr
CREATE TABLE user_bmr (
    user_profile_id number  NOT NULL,
    id_version number  NOT NULL,
    basal_metabolic_rate number  NOT NULL,
    dt_created date  NOT NULL,
    dt_modified date  NOT NULL,
    CONSTRAINT user_bmr_pk PRIMARY KEY (user_profile_id,id_version)
);

-- Table: user_bmr_archive
CREATE TABLE user_bmr_archive (
    user_bmr_user_profile_id number  NOT NULL,
    user_bmr_id_version number  NOT NULL,
    basal_metabolic_rate number  NOT NULL,
    dt_expired date  NOT NULL,
    CONSTRAINT user_bmr_archive_pk PRIMARY KEY (user_bmr_user_profile_id,user_bmr_id_version)
);

-- Table: user_profile
CREATE TABLE user_profile (
    id number  NOT NULL,
    user_account_id number  NOT NULL,
    user_profile_name varchar2(200)  NOT NULL,
    relationship_id number  NOT NULL,
    email varchar2(255)  NOT NULL,
    is_report_sharing_enabled char(1)  NOT NULL,
    is_active char(1)  NOT NULL,
    profile_image blob  NULL,
    CONSTRAINT user_profile_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: activity_log_activity (table: activity_log)
ALTER TABLE activity_log ADD CONSTRAINT activity_log_activity
    FOREIGN KEY (activity_id)
    REFERENCES activity (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: activity_log_user_profile (table: activity_log)
ALTER TABLE activity_log ADD CONSTRAINT activity_log_user_profile
    FOREIGN KEY (user_profile_id)
    REFERENCES user_profile (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: allergy_allergy_reaction (table: allergy)
ALTER TABLE allergy ADD CONSTRAINT allergy_allergy_reaction
    FOREIGN KEY (allergy_reaction_id)
    REFERENCES allergy_reaction (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: allergy_allergy_type (table: allergy)
ALTER TABLE allergy ADD CONSTRAINT allergy_allergy_type
    FOREIGN KEY (allergy_type_id)
    REFERENCES allergy_type (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: allergy_user_profile (table: allergy)
ALTER TABLE allergy ADD CONSTRAINT allergy_user_profile
    FOREIGN KEY (user_profile_id)
    REFERENCES user_profile (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: body_dimension_body_area (table: body_dimension)
ALTER TABLE body_dimension ADD CONSTRAINT body_dimension_body_area
    FOREIGN KEY (body_area_id)
    REFERENCES body_area (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: body_vitals_log_blood_chol (table: body_vitals_log)
ALTER TABLE body_vitals_log ADD CONSTRAINT body_vitals_log_blood_chol
    FOREIGN KEY (blood_cholesterol_id)
    REFERENCES blood_cholesterol (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: body_vitals_log_blood_glucose (table: body_vitals_log)
ALTER TABLE body_vitals_log ADD CONSTRAINT body_vitals_log_blood_glucose
    FOREIGN KEY (blood_glucose_id)
    REFERENCES blood_glucose (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: body_vitals_log_blood_pressure (table: body_vitals_log)
ALTER TABLE body_vitals_log ADD CONSTRAINT body_vitals_log_blood_pressure
    FOREIGN KEY (blood_pressure_id)
    REFERENCES blood_pressure (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: body_vitals_log_body_comp (table: body_vitals_log)
ALTER TABLE body_vitals_log ADD CONSTRAINT body_vitals_log_body_comp
    FOREIGN KEY (body_composition_id)
    REFERENCES body_composition (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: body_vitals_log_body_dimension (table: body_vitals_log)
ALTER TABLE body_vitals_log ADD CONSTRAINT body_vitals_log_body_dimension
    FOREIGN KEY (body_dimension_id, body_dimension_body_area_id)
    REFERENCES body_dimension (id, body_area_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: body_vitals_log_body_height (table: body_vitals_log)
ALTER TABLE body_vitals_log ADD CONSTRAINT body_vitals_log_body_height
    FOREIGN KEY (body_height_id)
    REFERENCES body_height (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: body_vitals_log_body_weight (table: body_vitals_log)
ALTER TABLE body_vitals_log ADD CONSTRAINT body_vitals_log_body_weight
    FOREIGN KEY (body_weight_id)
    REFERENCES body_weight (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: body_vitals_log_data_source (table: body_vitals_log)
ALTER TABLE body_vitals_log ADD CONSTRAINT body_vitals_log_data_source
    FOREIGN KEY (data_source_id)
    REFERENCES data_source (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: body_vitals_log_user_profile (table: body_vitals_log)
ALTER TABLE body_vitals_log ADD CONSTRAINT body_vitals_log_user_profile
    FOREIGN KEY (user_profile_id)
    REFERENCES user_profile (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: char_data_user_profile (table: characteristic_data)
ALTER TABLE characteristic_data ADD CONSTRAINT char_data_user_profile
    FOREIGN KEY (user_profile_id)
    REFERENCES user_profile (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: family_history_relationship (table: family_history)
ALTER TABLE family_history ADD CONSTRAINT family_history_relationship
    FOREIGN KEY (relationship_id)
    REFERENCES relationship (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: family_history_user_profile (table: family_history)
ALTER TABLE family_history ADD CONSTRAINT family_history_user_profile
    FOREIGN KEY (user_profile_id)
    REFERENCES user_profile (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: immunization_body_area (table: immunization)
ALTER TABLE immunization ADD CONSTRAINT immunization_body_area
    FOREIGN KEY (body_area_id)
    REFERENCES body_area (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: immunization_user_profile (table: immunization)
ALTER TABLE immunization ADD CONSTRAINT immunization_user_profile
    FOREIGN KEY (user_profile_id)
    REFERENCES user_profile (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: profile_dash_config_user_prf (table: profile_dashboard_config)
ALTER TABLE profile_dashboard_config ADD CONSTRAINT profile_dash_config_user_prf
    FOREIGN KEY (user_profile_id)
    REFERENCES user_profile (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: user_bmr_archive_user_bmr (table: user_bmr_archive)
ALTER TABLE user_bmr_archive ADD CONSTRAINT user_bmr_archive_user_bmr
    FOREIGN KEY (user_bmr_user_profile_id, user_bmr_id_version)
    REFERENCES user_bmr (user_profile_id, id_version)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: user_bmr_user_profile (table: user_bmr)
ALTER TABLE user_bmr ADD CONSTRAINT user_bmr_user_profile
    FOREIGN KEY (user_profile_id)
    REFERENCES user_profile (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: user_profile_relationship (table: user_profile)
ALTER TABLE user_profile ADD CONSTRAINT user_profile_relationship
    FOREIGN KEY (relationship_id)
    REFERENCES relationship (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: user_profile_user_account (table: user_profile)
ALTER TABLE user_profile ADD CONSTRAINT user_profile_user_account
    FOREIGN KEY (user_account_id)
    REFERENCES user_account (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.


-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:01:57.091

-- tables
-- Table: address
CREATE TABLE address (
    id number  NOT NULL,
    street_address varchar2(100)  NOT NULL,
    city varchar2(50)  NOT NULL,
    state varchar2(20)  NOT NULL,
    country varchar2(20)  NOT NULL,
    zip varchar2(10)  NOT NULL,
    CONSTRAINT address_pk PRIMARY KEY (id)
) ;

-- Table: application
CREATE TABLE application (
    id number  NOT NULL,
    renter_id number  NOT NULL,
    requirement varchar2(100)  NULL,
    submit_date date  NOT NULL,
    processing_date date  NOT NULL,
    processing_status varchar2(20)  NOT NULL,
    unit_id number  NULL,
    unit_reservation_fee number  NULL,
    staff_id number  NOT NULL,
    CONSTRAINT application_pk PRIMARY KEY (id)
) ;

-- Table: community
CREATE TABLE community (
    id number  NOT NULL,
    community_name varchar2(100)  NOT NULL,
    address_id number  NOT NULL,
    CONSTRAINT community_pk PRIMARY KEY (id)
) ;

-- Table: leasing_info
CREATE TABLE leasing_info (
    id number  NOT NULL,
    leasing_type varchar2(50)  NOT NULL,
    is_sub_leasing_allowed char(1)  NOT NULL,
    application_fee number  NOT NULL,
    security_deposit number  NOT NULL,
    monthly_rent_1month_lease number  NOT NULL,
    monthly_rent_6months_lease number  NOT NULL,
    monthly_rent_12months_lease number  NOT NULL,
    is_lease_termination_allowed char(1)  NOT NULL,
    lease_termination_cost number  NOT NULL,
    additional_leasing_clauses varchar2(2000)  NOT NULL,
    CONSTRAINT leasing_info_pk PRIMARY KEY (id)
) ;

-- Table: rent_payment_log
CREATE TABLE rent_payment_log (
    id number  NOT NULL,
    unit_leasing_log_id number  NOT NULL,
    amount_paid number  NOT NULL,
    payment_date number  NOT NULL,
    payment_medium varchar2(20)  NOT NULL,
    cheque_number number  NULL,
    online_transaction_number number  NULL,
    payment_accepted_by number  NULL,
    CONSTRAINT rent_payment_log_pk PRIMARY KEY (id)
) ;

-- Table: renter
CREATE TABLE renter (
    id number  NOT NULL,
    first_name varchar2(50)  NOT NULL,
    last_name varchar2(50)  NOT NULL,
    identity_proof_document varchar2(50)  NOT NULL,
    identity_proof_doc_id varchar2(50)  NOT NULL,
    permanent_address varchar2(1000)  NOT NULL,
    CONSTRAINT renter_pk PRIMARY KEY (id)
) ;

-- Table: service_category
CREATE TABLE service_category (
    id number  NOT NULL,
    service_category varchar2(20)  NOT NULL,
    CONSTRAINT service_category_pk PRIMARY KEY (id)
) ;

-- Table: service_request
CREATE TABLE service_request (
    id number  NOT NULL,
    unit_leasing_log_id number  NOT NULL,
    service_category_id number  NOT NULL,
    problem_description varchar2(2000)  NOT NULL,
    log_date date  NOT NULL,
    sr_assigned_to number  NULL,
    closure_date date  NULL,
    CONSTRAINT service_request_pk PRIMARY KEY (id)
) ;

-- Table: staff
CREATE TABLE staff (
    id number  NOT NULL,
    first_name varchar2(50)  NOT NULL,
    last_name varchar2(50)  NOT NULL,
    staff_role varchar2(20)  NOT NULL,
    employment_start_date date  NOT NULL,
    employement_end_date date  NULL,
    CONSTRAINT staff_pk PRIMARY KEY (id)
) ;

-- Table: unit
CREATE TABLE unit (
    id number  NOT NULL,
    unit_type_id number  NOT NULL,
    community_id number  NOT NULL,
    address_id number  NOT NULL,
    number_of_berdroom number  NOT NULL,
    number_of_bathroom number  NOT NULL,
    number_of_balcony number  NOT NULL,
    is_available char(1)  NOT NULL,
    is_reserved char(1)  NOT NULL,
    unit_available_from date  NULL,
    leasing_info_id number  NOT NULL,
    unit_description varchar2(4000)  NOT NULL,
    carpet_area number  NOT NULL,
    unit_number number  NOT NULL,
    unit_at_floor number  NOT NULL,
    CONSTRAINT unit_pk PRIMARY KEY (id)
) ;

-- Table: unit_lease
CREATE TABLE unit_lease (
    id number  NOT NULL,
    application_id number  NOT NULL,
    unit_id number  NOT NULL,
    lease_tanure_in_months number  NOT NULL,
    monthly_rent number  NOT NULL,
    discount_in_rent number  NOT NULL,
    lease_starting_from date  NOT NULL,
    lease_ending_on date  NOT NULL,
    CONSTRAINT unit_lease_pk PRIMARY KEY (id)
) ;

-- Table: unit_type
CREATE TABLE unit_type (
    id number  NOT NULL,
    unit_type varchar2(50)  NOT NULL,
    CONSTRAINT unit_type_pk PRIMARY KEY (id)
) ;

-- foreign keys
-- Reference: application_renter (table: application)
ALTER TABLE application ADD CONSTRAINT application_renter
    FOREIGN KEY (renter_id)
    REFERENCES renter (id);

-- Reference: application_staff (table: application)
ALTER TABLE application ADD CONSTRAINT application_staff
    FOREIGN KEY (staff_id)
    REFERENCES staff (id);

-- Reference: application_unit (table: application)
ALTER TABLE application ADD CONSTRAINT application_unit
    FOREIGN KEY (unit_id)
    REFERENCES unit (id);

-- Reference: community_address (table: community)
ALTER TABLE community ADD CONSTRAINT community_address
    FOREIGN KEY (address_id)
    REFERENCES address (id);

-- Reference: rent_payment_log_staff (table: rent_payment_log)
ALTER TABLE rent_payment_log ADD CONSTRAINT rent_payment_log_staff
    FOREIGN KEY (payment_accepted_by)
    REFERENCES staff (id);

-- Reference: rent_pym_log_unit_leasing_log (table: rent_payment_log)
ALTER TABLE rent_payment_log ADD CONSTRAINT rent_pym_log_unit_leasing_log
    FOREIGN KEY (unit_leasing_log_id)
    REFERENCES unit_lease (id);

-- Reference: service_request_staff (table: service_request)
ALTER TABLE service_request ADD CONSTRAINT service_request_staff
    FOREIGN KEY (sr_assigned_to)
    REFERENCES staff (id);

-- Reference: srv_req_unit_leasing_log (table: service_request)
ALTER TABLE service_request ADD CONSTRAINT srv_req_unit_leasing_log
    FOREIGN KEY (unit_leasing_log_id)
    REFERENCES unit_lease (id);

-- Reference: srv_request_srv_cat (table: service_request)
ALTER TABLE service_request ADD CONSTRAINT srv_request_srv_cat
    FOREIGN KEY (service_category_id)
    REFERENCES service_category (id);

-- Reference: unit_address (table: unit)
ALTER TABLE unit ADD CONSTRAINT unit_address
    FOREIGN KEY (address_id)
    REFERENCES address (id);

-- Reference: unit_leasing_info (table: unit)
ALTER TABLE unit ADD CONSTRAINT unit_leasing_info
    FOREIGN KEY (leasing_info_id)
    REFERENCES leasing_info (id);

-- Reference: unit_leasing_log_application (table: unit_lease)
ALTER TABLE unit_lease ADD CONSTRAINT unit_leasing_log_application
    FOREIGN KEY (application_id)
    REFERENCES application (id);

-- Reference: unit_leasing_log_unit (table: unit_lease)
ALTER TABLE unit_lease ADD CONSTRAINT unit_leasing_log_unit
    FOREIGN KEY (unit_id)
    REFERENCES unit (id);

-- Reference: unit_parent_unit (table: unit)
ALTER TABLE unit ADD CONSTRAINT unit_parent_unit
    FOREIGN KEY (community_id)
    REFERENCES community (id);

-- Reference: unit_unit_type (table: unit)
ALTER TABLE unit ADD CONSTRAINT unit_unit_type
    FOREIGN KEY (unit_type_id)
    REFERENCES unit_type (id);

-- End of file.


-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:57:32.837

-- tables
-- Table: block
CREATE TABLE block (
    id number  NOT NULL,
    parking_lot_id number  NOT NULL,
    block_code varchar2(3)  NOT NULL,
    number_of_floors number  NOT NULL,
    is_block_full char(1)  NOT NULL,
    CONSTRAINT block_pk PRIMARY KEY (id)
) ;

-- Table: customer
CREATE TABLE customer (
    id number  NOT NULL,
    vehicle_number varchar2(20)  NOT NULL,
    registration_date date  NOT NULL,
    is_regular_customer char(1)  NOT NULL,
    contact_number number  NULL,
    CONSTRAINT customer_pk PRIMARY KEY (id)
) ;

-- Table: floor
CREATE TABLE floor (
    id number  NOT NULL,
    block_id number  NOT NULL,
    floor_number number  NOT NULL,
    max_height_in_inch number  NOT NULL,
    number_of_wings number  NOT NULL,
    number_of_slots number  NOT NULL,
    is_covered char(1)  NOT NULL,
    is_accessible char(1)  NOT NULL,
    is_floor_full char(1)  NOT NULL,
    is_reserved_reg_cust char(1)  NOT NULL,
    CONSTRAINT floor_pk PRIMARY KEY (id)
) ;

-- Table: parking_lot
CREATE TABLE parking_lot (
    id number  NOT NULL,
    number_of_blocks number  NOT NULL,
    is_slot_available char(1)  NOT NULL,
    address varchar2(500)  NOT NULL,
    zip varchar2(10)  NOT NULL,
    is_reentry_allowed char(1)  NOT NULL,
    operating_company_name varchar2(100)  NOT NULL,
    is_valet_parking_available char(1)  NOT NULL,
    CONSTRAINT parking_lot_pk PRIMARY KEY (id)
) ;

-- Table: parking_slip
CREATE TABLE parking_slip (
    id number  NOT NULL,
    parking_slot_reservation_id number  NOT NULL,
    actual_entry_time timestamp  NOT NULL,
    actual_exit_time timestamp  NULL,
    basic_cost number(10,2)  NOT NULL,
    penalty number(10,2)  NULL,
    total_cost number(10,2)  NOT NULL,
    is_paid char(1)  NOT NULL,
    CONSTRAINT parking_slip_pk PRIMARY KEY (id)
) ;

-- Table: parking_slot
CREATE TABLE parking_slot (
    id number  NOT NULL,
    floor_id number  NOT NULL,
    slot_number number  NOT NULL,
    wing_code char(1)  NOT NULL,
    CONSTRAINT parking_slot_pk PRIMARY KEY (id)
) ;

-- Table: parking_slot_reservation
CREATE TABLE parking_slot_reservation (
    id number  NOT NULL,
    customer_id number  NOT NULL,
    start_timestamp timestamp  NOT NULL,
    duration_in_minutes number  NOT NULL,
    booking_date date  NOT NULL,
    parking_slot_id number  NOT NULL,
    CONSTRAINT parking_slot_reservation_pk PRIMARY KEY (id)
) ;

-- Table: regular_pass
CREATE TABLE regular_pass (
    id number  NOT NULL,
    customer_id number  NOT NULL,
    purchase_date date  NOT NULL,
    start_date date  NOT NULL,
    duration_in_days number  NOT NULL,
    cost number(10,2)  NOT NULL,
    CONSTRAINT regular_pass_pk PRIMARY KEY (id)
) ;

-- foreign keys
-- Reference: block_parking_lot (table: block)
ALTER TABLE block ADD CONSTRAINT block_parking_lot
    FOREIGN KEY (parking_lot_id)
    REFERENCES parking_lot (id);

-- Reference: floor_block (table: floor)
ALTER TABLE floor ADD CONSTRAINT floor_block
    FOREIGN KEY (block_id)
    REFERENCES block (id);

-- Reference: parking_slip_parking_slot_res (table: parking_slip)
ALTER TABLE parking_slip ADD CONSTRAINT parking_slip_parking_slot_res
    FOREIGN KEY (parking_slot_reservation_id)
    REFERENCES parking_slot_reservation (id);

-- Reference: parking_slot_floor (table: parking_slot)
ALTER TABLE parking_slot ADD CONSTRAINT parking_slot_floor
    FOREIGN KEY (floor_id)
    REFERENCES floor (id);

-- Reference: parking_slot_res_customer (table: parking_slot_reservation)
ALTER TABLE parking_slot_reservation ADD CONSTRAINT parking_slot_res_customer
    FOREIGN KEY (customer_id)
    REFERENCES customer (id);

-- Reference: parking_slot_res_parking_slot (table: parking_slot_reservation)
ALTER TABLE parking_slot_reservation ADD CONSTRAINT parking_slot_res_parking_slot
    FOREIGN KEY (parking_slot_id)
    REFERENCES parking_slot (id);

-- Reference: regular_pass_customer (table: regular_pass)
ALTER TABLE regular_pass ADD CONSTRAINT regular_pass_customer
    FOREIGN KEY (customer_id)
    REFERENCES customer (id);

-- End of file.


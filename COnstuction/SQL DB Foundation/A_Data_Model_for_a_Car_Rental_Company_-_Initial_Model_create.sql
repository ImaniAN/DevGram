-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:33:16.539

-- tables
-- Table: car
CREATE TABLE car (
    id int  NOT NULL,
    category_id int  NOT NULL,
    brand varchar(255)  NOT NULL,
    model varchar(255)  NOT NULL,
    production_year int  NOT NULL,
    mileage int  NOT NULL,
    color varchar(255)  NOT NULL,
    CONSTRAINT car_pk PRIMARY KEY (id)
);

-- Table: car_equipment
CREATE TABLE car_equipment (
    id int  NOT NULL,
    equipment_id int  NOT NULL,
    car_id int  NOT NULL,
    start_date date  NOT NULL,
    end_date date  NULL,
    CONSTRAINT car_equipment_pk PRIMARY KEY (id)
);

-- Table: category
CREATE TABLE category (
    id int  NOT NULL,
    name varchar(255)  NOT NULL,
    CONSTRAINT category_pk PRIMARY KEY (id)
);

-- Table: city
CREATE TABLE city (
    id int  NOT NULL,
    name varchar(255)  NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (id)
);

-- Table: customer
CREATE TABLE customer (
    id int  NOT NULL,
    name varchar(255)  NOT NULL,
    birth_date date  NOT NULL,
    driving_license_number varchar(255)  NOT NULL,
    CONSTRAINT customer_pk PRIMARY KEY (id)
);

-- Table: equipment
CREATE TABLE equipment (
    id int  NOT NULL,
    name varchar(255)  NOT NULL,
    equipment_category_id int  NOT NULL,
    CONSTRAINT equipment_pk PRIMARY KEY (id)
);

-- Table: equipment_category
CREATE TABLE equipment_category (
    id int  NOT NULL,
    name varchar(255)  NOT NULL,
    CONSTRAINT equipment_category_pk PRIMARY KEY (id)
);

-- Table: insurance
CREATE TABLE insurance (
    id int  NOT NULL,
    name varchar(255)  NOT NULL,
    description text  NOT NULL,
    policy oid  NOT NULL,
    CONSTRAINT insurance_pk PRIMARY KEY (id)
);

-- Table: location
CREATE TABLE location (
    id int  NOT NULL,
    city_id int  NOT NULL,
    CONSTRAINT location_pk PRIMARY KEY (id)
);

-- Table: rental
CREATE TABLE rental (
    id int  NOT NULL,
    customer_id int  NOT NULL,
    car_id int  NOT NULL,
    pick_up_location_id int  NOT NULL,
    drop_off_location_id int  NOT NULL,
    start_date date  NOT NULL,
    end_date date  NULL,
    remarks text  NOT NULL,
    CONSTRAINT rental_pk PRIMARY KEY (id)
);

-- Table: rental_insurance
CREATE TABLE rental_insurance (
    rental_id int  NOT NULL,
    insurance_id int  NOT NULL,
    CONSTRAINT rental_insurance_pk PRIMARY KEY (rental_id,insurance_id)
);

-- Table: reservation
CREATE TABLE reservation (
    id int  NOT NULL,
    pick_up_location_id int  NOT NULL,
    drop_off_location_id int  NOT NULL,
    category_id int  NOT NULL,
    customer_id int  NOT NULL,
    CONSTRAINT reservation_pk PRIMARY KEY (id)
);

-- Table: reservation_equipment
CREATE TABLE reservation_equipment (
    reservation_id int  NOT NULL,
    equipment_category_id int  NOT NULL,
    CONSTRAINT reservation_equipment_pk PRIMARY KEY (reservation_id,equipment_category_id)
);

-- foreign keys
-- Reference: car_category (table: car)
ALTER TABLE car ADD CONSTRAINT car_category
    FOREIGN KEY (category_id)
    REFERENCES category (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: car_equipment_car (table: car_equipment)
ALTER TABLE car_equipment ADD CONSTRAINT car_equipment_car
    FOREIGN KEY (car_id)
    REFERENCES car (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: car_equipment_equipment (table: car_equipment)
ALTER TABLE car_equipment ADD CONSTRAINT car_equipment_equipment
    FOREIGN KEY (equipment_id)
    REFERENCES equipment (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: equipment_equipment_category (table: equipment)
ALTER TABLE equipment ADD CONSTRAINT equipment_equipment_category
    FOREIGN KEY (equipment_category_id)
    REFERENCES equipment_category (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: location_city (table: location)
ALTER TABLE location ADD CONSTRAINT location_city
    FOREIGN KEY (city_id)
    REFERENCES city (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: rental_car (table: rental)
ALTER TABLE rental ADD CONSTRAINT rental_car
    FOREIGN KEY (car_id)
    REFERENCES car (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: rental_customer (table: rental)
ALTER TABLE rental ADD CONSTRAINT rental_customer
    FOREIGN KEY (customer_id)
    REFERENCES customer (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: rental_insurance_insurance (table: rental_insurance)
ALTER TABLE rental_insurance ADD CONSTRAINT rental_insurance_insurance
    FOREIGN KEY (insurance_id)
    REFERENCES insurance (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: rental_insurance_rental (table: rental_insurance)
ALTER TABLE rental_insurance ADD CONSTRAINT rental_insurance_rental
    FOREIGN KEY (rental_id)
    REFERENCES rental (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: rental_location (table: rental)
ALTER TABLE rental ADD CONSTRAINT rental_location
    FOREIGN KEY (drop_off_location_id)
    REFERENCES location (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: rental_pick_up_location (table: rental)
ALTER TABLE rental ADD CONSTRAINT rental_pick_up_location
    FOREIGN KEY (pick_up_location_id)
    REFERENCES location (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: reservation_category (table: reservation)
ALTER TABLE reservation ADD CONSTRAINT reservation_category
    FOREIGN KEY (category_id)
    REFERENCES category (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: reservation_customer (table: reservation)
ALTER TABLE reservation ADD CONSTRAINT reservation_customer
    FOREIGN KEY (customer_id)
    REFERENCES customer (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: reservation_equipment_equipment_category (table: reservation_equipment)
ALTER TABLE reservation_equipment ADD CONSTRAINT reservation_equipment_equipment_category
    FOREIGN KEY (equipment_category_id)
    REFERENCES equipment_category (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: reservation_equipment_reservation (table: reservation_equipment)
ALTER TABLE reservation_equipment ADD CONSTRAINT reservation_equipment_reservation
    FOREIGN KEY (reservation_id)
    REFERENCES reservation (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: reservation_location (table: reservation)
ALTER TABLE reservation ADD CONSTRAINT reservation_location
    FOREIGN KEY (drop_off_location_id)
    REFERENCES location (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: reservation_pick_up_location (table: reservation)
ALTER TABLE reservation ADD CONSTRAINT reservation_pick_up_location
    FOREIGN KEY (pick_up_location_id)
    REFERENCES location (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.


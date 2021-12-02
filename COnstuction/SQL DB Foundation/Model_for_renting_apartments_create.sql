-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:14:53.781

-- tables
-- Table: furnishing_category
CREATE TABLE furnishing_category (
    id number  NOT NULL,
    category_name varchar2(20)  NOT NULL,
    CONSTRAINT furnishing_category_pk PRIMARY KEY (id)
) ;

-- Table: furnishing_item
CREATE TABLE furnishing_item (
    id number  NOT NULL,
    furnishing_item_name varchar2(50)  NOT NULL,
    furnishing_category_id number  NOT NULL,
    CONSTRAINT furnishing_item_pk PRIMARY KEY (id)
) ;

-- Table: furnishing_type
CREATE TABLE furnishing_type (
    id number  NOT NULL,
    furnishing_type varchar2(20)  NOT NULL,
    CONSTRAINT furnishing_type_pk PRIMARY KEY (id)
) ;

-- Table: leasing_info
CREATE TABLE leasing_info (
    id number  NOT NULL,
    leasing_type varchar2(10)  NOT NULL,
    is_sub_leasing_allowed char(1)  NOT NULL,
    admin_fee number  NOT NULL,
    brokerage_fee number  NOT NULL,
    security_deposit number  NOT NULL,
    rent_for_short_term_leasing number  NOT NULL,
    rent_for_long_term_leasing number  NOT NULL,
    is_lease_termination_allowed char(1)  NOT NULL,
    lease_termination_amount number  NOT NULL,
    CONSTRAINT leasing_info_pk PRIMARY KEY (id)
) ;

-- Table: parent_unit
CREATE TABLE parent_unit (
    id number  NOT NULL,
    parent_unit_name varchar2(100)  NOT NULL,
    total_floors number  NULL,
    number_of_units number  NOT NULL,
    has_fitness_center char(1)  NOT NULL,
    has_swimming_pool char(1)  NOT NULL,
    has_laundry char(1)  NOT NULL,
    has_wheelchair_accessibility char(1)  NOT NULL,
    has_intercom_facility char(1)  NOT NULL,
    has_power_backup char(1)  NOT NULL,
    has_main_door_security char(1)  NOT NULL,
    number_of_elevators number  NOT NULL,
    street_name varchar2(50)  NOT NULL,
    city_name varchar2(50)  NOT NULL,
    state_name varchar2(50)  NOT NULL,
    country_name varchar2(50)  NOT NULL,
    zip_code varchar2(20)  NOT NULL,
    CONSTRAINT parent_unit_pk PRIMARY KEY (id)
) ;

-- Table: parent_unit_accessibility
CREATE TABLE parent_unit_accessibility (
    parent_unit_id number  NOT NULL,
    school number  NULL,
    children_park number  NULL,
    bank number  NULL,
    grocery_store number  NULL,
    atm number  NULL,
    subway_station number  NULL,
    bus_stop number  NULL,
    airport number  NULL,
    CONSTRAINT parent_unit_accessibility_pk PRIMARY KEY (parent_unit_id)
) ;

-- Table: parent_unit_image
CREATE TABLE parent_unit_image (
    id number  NOT NULL,
    parent_unit_id number  NOT NULL,
    image blob  NOT NULL,
    CONSTRAINT parent_unit_image_pk PRIMARY KEY (id)
) ;

-- Table: unit
CREATE TABLE unit (
    id number  NOT NULL,
    unit_heading varchar2(50)  NOT NULL,
    unit_type_id number  NOT NULL,
    number_of_bedroom number  NOT NULL,
    number_of_bathroom number  NOT NULL,
    number_of_balcony number  NOT NULL,
    leasing_info_id number  NOT NULL,
    date_of_posting date  NOT NULL,
    date_available_from date  NOT NULL,
    posted_by number  NOT NULL,
    is_active char(1)  NOT NULL,
    unit_description varchar2(500)  NULL,
    carpet_area number  NOT NULL,
    unit_number varchar2(20)  NOT NULL,
    unit_floor_number number  NULL,
    parent_unit_id number  NOT NULL,
    CONSTRAINT unit_pk PRIMARY KEY (id)
) ;

-- Table: unit_feature
CREATE TABLE unit_feature (
    unit_id number  NOT NULL,
    furnishing_type_id number  NOT NULL,
    is_air_conditioning char(1)  NOT NULL,
    num_of_assigned_car_parking number  NOT NULL,
    has_carpet char(1)  NOT NULL,
    has_hardwood_flooring char(1)  NOT NULL,
    is_ceiling_fan_cooling char(1)  NOT NULL,
    is_central_heating char(1)  NOT NULL,
    has_in_unit_fireplace char(1)  NOT NULL,
    has_in_unit_garden char(1)  NOT NULL,
    has_in_unit_laundry char(1)  NOT NULL,
    has_walkin_closet char(1)  NOT NULL,
    are_pets_allowed char(1)  NOT NULL,
    CONSTRAINT unit_feature_pk PRIMARY KEY (unit_id)
) ;

-- Table: unit_furnishing
CREATE TABLE unit_furnishing (
    unit_feature_unit_id number  NOT NULL,
    furnishing_item_id number  NOT NULL,
    number_of_items number  NOT NULL,
    CONSTRAINT unit_furnishing_pk PRIMARY KEY (unit_feature_unit_id,furnishing_item_id)
) ;

-- Table: unit_image
CREATE TABLE unit_image (
    id number  NOT NULL,
    unit_id number  NOT NULL,
    image blob  NOT NULL,
    CONSTRAINT unit_image_pk PRIMARY KEY (id)
) ;

-- Table: unit_type
CREATE TABLE unit_type (
    id number  NOT NULL,
    unit_type varchar2(20)  NOT NULL,
    CONSTRAINT unit_type_pk PRIMARY KEY (id)
) ;

-- Table: user
CREATE TABLE "user" (
    id number  NOT NULL,
    user_type_id number  NOT NULL,
    first_name varchar2(20)  NOT NULL,
    last_name varchar2(20)  NOT NULL,
    address varchar2(100)  NOT NULL,
    contact_number number  NOT NULL,
    email_address varchar2(255)  NOT NULL,
    CONSTRAINT user_pk PRIMARY KEY (id)
) ;

-- Table: user_type
CREATE TABLE user_type (
    id number  NOT NULL,
    user_type varchar2(20)  NOT NULL,
    CONSTRAINT user_type_pk PRIMARY KEY (id)
) ;

-- foreign keys
-- Reference: furn_item_furn_category (table: furnishing_item)
ALTER TABLE furnishing_item ADD CONSTRAINT furn_item_furn_category
    FOREIGN KEY (furnishing_category_id)
    REFERENCES furnishing_category (id);

-- Reference: furn_item_unit_feature (table: unit_furnishing)
ALTER TABLE unit_furnishing ADD CONSTRAINT furn_item_unit_feature
    FOREIGN KEY (unit_feature_unit_id)
    REFERENCES unit_feature (unit_id);

-- Reference: p_unit_access_p_unit (table: parent_unit_accessibility)
ALTER TABLE parent_unit_accessibility ADD CONSTRAINT p_unit_access_p_unit
    FOREIGN KEY (parent_unit_id)
    REFERENCES parent_unit (id);

-- Reference: parent_unit_image_parent_unit (table: parent_unit_image)
ALTER TABLE parent_unit_image ADD CONSTRAINT parent_unit_image_parent_unit
    FOREIGN KEY (parent_unit_id)
    REFERENCES parent_unit (id);

-- Reference: unit_feature_furnishing_type (table: unit_feature)
ALTER TABLE unit_feature ADD CONSTRAINT unit_feature_furnishing_type
    FOREIGN KEY (furnishing_type_id)
    REFERENCES furnishing_type (id);

-- Reference: unit_feature_unit (table: unit_feature)
ALTER TABLE unit_feature ADD CONSTRAINT unit_feature_unit
    FOREIGN KEY (unit_id)
    REFERENCES unit (id);

-- Reference: unit_furn_furn_item (table: unit_furnishing)
ALTER TABLE unit_furnishing ADD CONSTRAINT unit_furn_furn_item
    FOREIGN KEY (furnishing_item_id)
    REFERENCES furnishing_item (id);

-- Reference: unit_image_unit (table: unit_image)
ALTER TABLE unit_image ADD CONSTRAINT unit_image_unit
    FOREIGN KEY (unit_id)
    REFERENCES unit (id);

-- Reference: unit_leasing_info (table: unit)
ALTER TABLE unit ADD CONSTRAINT unit_leasing_info
    FOREIGN KEY (leasing_info_id)
    REFERENCES leasing_info (id);

-- Reference: unit_parent_unit (table: unit)
ALTER TABLE unit ADD CONSTRAINT unit_parent_unit
    FOREIGN KEY (parent_unit_id)
    REFERENCES parent_unit (id);

-- Reference: unit_unit_type (table: unit)
ALTER TABLE unit ADD CONSTRAINT unit_unit_type
    FOREIGN KEY (unit_type_id)
    REFERENCES unit_type (id);

-- Reference: unit_user (table: unit)
ALTER TABLE unit ADD CONSTRAINT unit_user
    FOREIGN KEY (posted_by)
    REFERENCES "user" (id);

-- Reference: user_user_type (table: user)
ALTER TABLE "user" ADD CONSTRAINT user_user_type
    FOREIGN KEY (user_type_id)
    REFERENCES user_type (id);

-- End of file.


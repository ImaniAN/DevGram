-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:32:50.971

-- tables
-- Table: car
CREATE TABLE car (
    id number  NOT NULL,
    name varchar2(50)  NOT NULL,
    make varchar2(50)  NOT NULL,
    model varchar2(50)  NOT NULL,
    make_year number(4)  NOT NULL,
    comfort_level number(1)  NOT NULL,
    CONSTRAINT car_pk PRIMARY KEY (id)
) ;

-- Table: chitchat_preference
CREATE TABLE chitchat_preference (
    id number  NOT NULL,
    description varchar2(50)  NOT NULL,
    CONSTRAINT chitchat_preference_pk PRIMARY KEY (id)
) ;

-- Table: city
CREATE TABLE city (
    id number  NOT NULL,
    city_name varchar2(50)  NOT NULL,
    state varchar2(50)  NOT NULL,
    country varchar2(50)  NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (id)
) ;

-- Table: enroute_city
CREATE TABLE enroute_city (
    id number  NOT NULL,
    ride_id number  NOT NULL,
    city_id number  NOT NULL,
    order_from_source number  NOT NULL,
    prorated_contribution number  NOT NULL,
    CONSTRAINT enroute_city_pk PRIMARY KEY (id)
) ;

-- Table: luggage_size
CREATE TABLE luggage_size (
    id number  NOT NULL,
    description varchar2(50)  NOT NULL,
    CONSTRAINT luggage_size_pk PRIMARY KEY (id)
) ;

-- Table: member
CREATE TABLE member (
    id number  NOT NULL,
    first_name varchar2(50)  NOT NULL,
    last_name varchar2(50)  NOT NULL,
    email varchar2(255)  NOT NULL,
    contact_number number(10)  NOT NULL,
    driving_licence_number varchar2(50)  NULL,
    driving_licence_valid_from date  NULL,
    CONSTRAINT member_pk PRIMARY KEY (id)
) ;

-- Table: member_car
CREATE TABLE member_car (
    id number  NOT NULL,
    member_id number  NOT NULL,
    car_id number  NOT NULL,
    car_registration_number varchar2(50)  NOT NULL,
    car_color varchar2(20)  NOT NULL,
    CONSTRAINT member_car_pk PRIMARY KEY (id)
) ;

-- Table: member_preference
CREATE TABLE member_preference (
    member_id number  NOT NULL,
    is_smoking_allowed char(1)  NOT NULL,
    is_pet_allowed char(1)  NOT NULL,
    music_preference_id number  NOT NULL,
    chitchat_preference_id number  NOT NULL,
    CONSTRAINT member_preference_pk PRIMARY KEY (member_id)
) ;

-- Table: music_preference
CREATE TABLE music_preference (
    id number  NOT NULL,
    description varchar2(50)  NOT NULL,
    CONSTRAINT music_preference_pk PRIMARY KEY (id)
) ;

-- Table: request
CREATE TABLE request (
    id number  NOT NULL,
    requester_id number  NOT NULL,
    ride_id number  NOT NULL,
    enroute_city_id number  NULL,
    created_on date  NOT NULL,
    request_status_id number  NOT NULL,
    CONSTRAINT request_pk PRIMARY KEY (id)
) ;

-- Table: request_status
CREATE TABLE request_status (
    id number  NOT NULL,
    description varchar2(10)  NOT NULL,
    CONSTRAINT request_status_pk PRIMARY KEY (id)
) ;

-- Table: ride
CREATE TABLE ride (
    id number  NOT NULL,
    member_car_id number  NOT NULL,
    created_on date  NOT NULL,
    travel_start_time date  NOT NULL,
    source_city_id number  NOT NULL,
    destination_city_id number  NOT NULL,
    seats_offered number(1)  NOT NULL,
    contribution_per_head number  NOT NULL,
    luggage_size_id number  NOT NULL,
    CONSTRAINT ride_pk PRIMARY KEY (id)
) ;

-- foreign keys
-- Reference: destination_ride_city (table: ride)
ALTER TABLE ride ADD CONSTRAINT destination_ride_city
    FOREIGN KEY (destination_city_id)
    REFERENCES city (id);

-- Reference: enroute_city_city (table: enroute_city)
ALTER TABLE enroute_city ADD CONSTRAINT enroute_city_city
    FOREIGN KEY (city_id)
    REFERENCES city (id);

-- Reference: enroute_city_ride (table: enroute_city)
ALTER TABLE enroute_city ADD CONSTRAINT enroute_city_ride
    FOREIGN KEY (ride_id)
    REFERENCES ride (id);

-- Reference: member_pref_chitchat_pref (table: member_preference)
ALTER TABLE member_preference ADD CONSTRAINT member_pref_chitchat_pref
    FOREIGN KEY (chitchat_preference_id)
    REFERENCES chitchat_preference (id);

-- Reference: request_enroute_city (table: request)
ALTER TABLE request ADD CONSTRAINT request_enroute_city
    FOREIGN KEY (enroute_city_id)
    REFERENCES enroute_city (id);

-- Reference: request_request_status (table: request)
ALTER TABLE request ADD CONSTRAINT request_request_status
    FOREIGN KEY (request_status_id)
    REFERENCES request_status (id);

-- Reference: request_ride (table: request)
ALTER TABLE request ADD CONSTRAINT request_ride
    FOREIGN KEY (ride_id)
    REFERENCES ride (id);

-- Reference: request_user (table: request)
ALTER TABLE request ADD CONSTRAINT request_user
    FOREIGN KEY (requester_id)
    REFERENCES member (id);

-- Reference: ride_luggage_size (table: ride)
ALTER TABLE ride ADD CONSTRAINT ride_luggage_size
    FOREIGN KEY (luggage_size_id)
    REFERENCES luggage_size (id);

-- Reference: ride_user_car (table: ride)
ALTER TABLE ride ADD CONSTRAINT ride_user_car
    FOREIGN KEY (member_car_id)
    REFERENCES member_car (id);

-- Reference: source_ride_city (table: ride)
ALTER TABLE ride ADD CONSTRAINT source_ride_city
    FOREIGN KEY (source_city_id)
    REFERENCES city (id);

-- Reference: user_car_car (table: member_car)
ALTER TABLE member_car ADD CONSTRAINT user_car_car
    FOREIGN KEY (car_id)
    REFERENCES car (id);

-- Reference: user_car_user (table: member_car)
ALTER TABLE member_car ADD CONSTRAINT user_car_user
    FOREIGN KEY (member_id)
    REFERENCES member (id);

-- Reference: user_pref_music_pref (table: member_preference)
ALTER TABLE member_preference ADD CONSTRAINT user_pref_music_pref
    FOREIGN KEY (music_preference_id)
    REFERENCES music_preference (id);

-- Reference: user_preference_user (table: member_preference)
ALTER TABLE member_preference ADD CONSTRAINT user_preference_user
    FOREIGN KEY (member_id)
    REFERENCES member (id);

-- End of file.


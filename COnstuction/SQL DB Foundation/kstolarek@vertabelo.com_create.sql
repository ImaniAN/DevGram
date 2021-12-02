-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:12:55.275

-- tables
-- Table: composition
CREATE TABLE composition (
    id int NOT NULL AUTO_INCREMENT,
    code varchar(64) NOT NULL COMMENT 'unique composition code',
    seats_first_class int NOT NULL COMMENT 'number of 1st class seats in a bus or a train',
    seats_second_class int NOT NULL COMMENT 'number of 2nd class seats in a bus or a train',
    additional_capacity int NOT NULL COMMENT 'e.g. places to stand',
    update_time timestamp NOT NULL COMMENT 'the moment when these values were inserted/updated',
    operator_id int NOT NULL,
    description text NULL COMMENT 'e.g. manufacturer, production date, number of wagons in a train composition',
    UNIQUE INDEX composition_ak_1 (code,operator_id),
    CONSTRAINT composition_pk PRIMARY KEY (id)
) COMMENT 'list of all current compositions';

-- Table: composition_history
CREATE TABLE composition_history (
    composition_id int NOT NULL,
    code varchar(64) NOT NULL,
    seats_first_class int NOT NULL,
    seats_second_class int NOT NULL,
    additional_capacity int NOT NULL,
    update_time timestamp NOT NULL,
    operator_id int NOT NULL,
    CONSTRAINT composition_history_pk PRIMARY KEY (composition_id,update_time)
) COMMENT 'all changes that ever happened in the composition -> when we insert/update data in the "composition" table we''''ll insert the record here';

-- Table: country
CREATE TABLE country (
    id int NOT NULL AUTO_INCREMENT,
    country_name varchar(255) NOT NULL,
    UNIQUE INDEX country_ak_1 (country_name),
    CONSTRAINT country_pk PRIMARY KEY (id)
);

-- Table: line
CREATE TABLE line (
    id int NOT NULL AUTO_INCREMENT,
    line_name varchar(255) NOT NULL,
    operator_id int NOT NULL,
    departure_station int NOT NULL,
    arrival_station int NOT NULL,
    description text NULL,
    UNIQUE INDEX line_ak_1 (line_name,operator_id),
    CONSTRAINT line_pk PRIMARY KEY (id)
) COMMENT 'list of all lines';

-- Table: location
CREATE TABLE location (
    id int NOT NULL AUTO_INCREMENT,
    location_name varchar(255) NOT NULL,
    postal_code varchar(16) NOT NULL,
    country_id int NOT NULL,
    CONSTRAINT location_pk PRIMARY KEY (id)
) COMMENT 'city or village';

-- Table: operates
CREATE TABLE operates (
    id int NOT NULL AUTO_INCREMENT,
    composition_id int NOT NULL,
    trip_id int NOT NULL,
    date_from date NOT NULL,
    date_to date NULL COMMENT 'will be defined at the moment when we know that composition will become inactive',
    CONSTRAINT operates_pk PRIMARY KEY (id)
) COMMENT 'interval when that composition was active on that line_schedule';

-- Table: operational_interval
CREATE TABLE operational_interval (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    start_date text NOT NULL COMMENT 'e.g. 1.1. (without year)',
    end_date text NOT NULL COMMENT 'e.g. 30.6. (without year)',
    monday bool NOT NULL,
    tuesday bool NOT NULL,
    wednesday bool NOT NULL,
    thursday bool NOT NULL,
    friday bool NOT NULL,
    saturday bool NOT NULL,
    sunday bool NOT NULL,
    CONSTRAINT operational_interval_pk PRIMARY KEY (id)
) COMMENT 'we could have different intervals during year (seasons) - for each interval we''''ll define interval and days when line operates';

-- Table: operator
CREATE TABLE operator (
    id int NOT NULL AUTO_INCREMENT,
    operator_name varchar(255) NOT NULL,
    headquarters varchar(255) NOT NULL,
    country_id int NOT NULL,
    UNIQUE INDEX operator_ak_1 (operator_name,country_id),
    CONSTRAINT operator_pk PRIMARY KEY (id)
) COMMENT 'list of all bus/railways operators';

-- Table: schedule
CREATE TABLE schedule (
    id int NOT NULL AUTO_INCREMENT,
    trip_id int NOT NULL,
    station_id int NOT NULL,
    arrival_time time NULL COMMENT 'can be NULL because departure (1st) station won''''t have arrival time',
    departure_time time NULL COMMENT 'can be NULL because arrival (last) station won''''t have departure time',
    description text NULL COMMENT 'e.g. platform where bus/train is located',
    CONSTRAINT schedule_pk PRIMARY KEY (id)
);

-- Table: station
CREATE TABLE station (
    id int NOT NULL AUTO_INCREMENT,
    station_name varchar(255) NOT NULL,
    location_id int NOT NULL,
    UNIQUE INDEX station_ak_1 (station_name,location_id),
    CONSTRAINT station_pk PRIMARY KEY (id)
) COMMENT 'list of all stations';

-- Table: ticket
CREATE TABLE ticket (
    id int NOT NULL AUTO_INCREMENT,
    user_account_id int NULL,
    sales_time timestamp NOT NULL,
    composition_id int NOT NULL,
    journey_date date NOT NULL,
    schedule_departure_station_id int NOT NULL,
    schedule_arrival_station_id int NOT NULL,
    is_first_class bool NOT NULL,
    is_second_class bool NOT NULL,
    seat_reserved varchar(16) NULL COMMENT 'number of the reserved seat',
    price decimal(8,2) NOT NULL,
    CONSTRAINT ticket_pk PRIMARY KEY (id)
);

-- Table: trip
CREATE TABLE trip (
    id int NOT NULL AUTO_INCREMENT,
    line_id int NOT NULL,
    operational_interval_id int NOT NULL,
    departure_time time NOT NULL,
    arrival_time time NOT NULL,
    UNIQUE INDEX schedule_ak_1 (operational_interval_id,departure_time),
    CONSTRAINT trip_pk PRIMARY KEY (id)
) COMMENT 'exact line schedule with arrival and departure time for the station_from and station_to';

-- Table: trip_info
CREATE TABLE trip_info (
    id int NOT NULL AUTO_INCREMENT,
    trip_id int NOT NULL,
    info_time timestamp NOT NULL,
    info_text text NOT NULL,
    CONSTRAINT trip_info_pk PRIMARY KEY (id)
) COMMENT 'e.g. train is late for 15 minutes';

-- Table: user_account
CREATE TABLE user_account (
    id int NOT NULL AUTO_INCREMENT,
    username varchar(64) NOT NULL,
    password varchar(64) NOT NULL,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    registration_time timestamp NOT NULL,
    UNIQUE INDEX user_account_ak_1 (username),
    CONSTRAINT user_account_pk PRIMARY KEY (id)
) COMMENT 'list of all users who can sell tickets';

-- foreign keys
-- Reference: composition_history_composition (table: composition_history)
ALTER TABLE composition_history ADD CONSTRAINT composition_history_composition FOREIGN KEY composition_history_composition (composition_id)
    REFERENCES composition (id);

-- Reference: composition_history_operator (table: composition_history)
ALTER TABLE composition_history ADD CONSTRAINT composition_history_operator FOREIGN KEY composition_history_operator (operator_id)
    REFERENCES operator (id);

-- Reference: composition_operator (table: composition)
ALTER TABLE composition ADD CONSTRAINT composition_operator FOREIGN KEY composition_operator (operator_id)
    REFERENCES operator (id);

-- Reference: line_arrival_station (table: line)
ALTER TABLE line ADD CONSTRAINT line_arrival_station FOREIGN KEY line_arrival_station (arrival_station)
    REFERENCES station (id);

-- Reference: line_departure_station (table: line)
ALTER TABLE line ADD CONSTRAINT line_departure_station FOREIGN KEY line_departure_station (departure_station)
    REFERENCES station (id);

-- Reference: line_info_line_schedule (table: trip_info)
ALTER TABLE trip_info ADD CONSTRAINT line_info_line_schedule FOREIGN KEY line_info_line_schedule (trip_id)
    REFERENCES trip (id);

-- Reference: line_operator (table: line)
ALTER TABLE line ADD CONSTRAINT line_operator FOREIGN KEY line_operator (operator_id)
    REFERENCES operator (id);

-- Reference: line_schedule_line (table: trip)
ALTER TABLE trip ADD CONSTRAINT line_schedule_line FOREIGN KEY line_schedule_line (line_id)
    REFERENCES line (id);

-- Reference: location_country (table: location)
ALTER TABLE location ADD CONSTRAINT location_country FOREIGN KEY location_country (country_id)
    REFERENCES country (id);

-- Reference: operates_composition (table: operates)
ALTER TABLE operates ADD CONSTRAINT operates_composition FOREIGN KEY operates_composition (composition_id)
    REFERENCES composition (id);

-- Reference: operates_trip (table: operates)
ALTER TABLE operates ADD CONSTRAINT operates_trip FOREIGN KEY operates_trip (trip_id)
    REFERENCES trip (id);

-- Reference: operator_country (table: operator)
ALTER TABLE operator ADD CONSTRAINT operator_country FOREIGN KEY operator_country (country_id)
    REFERENCES country (id);

-- Reference: schedule_operational_interval (table: trip)
ALTER TABLE trip ADD CONSTRAINT schedule_operational_interval FOREIGN KEY schedule_operational_interval (operational_interval_id)
    REFERENCES operational_interval (id);

-- Reference: schedule_station (table: schedule)
ALTER TABLE schedule ADD CONSTRAINT schedule_station FOREIGN KEY schedule_station (station_id)
    REFERENCES station (id);

-- Reference: schedule_trip (table: schedule)
ALTER TABLE schedule ADD CONSTRAINT schedule_trip FOREIGN KEY schedule_trip (trip_id)
    REFERENCES trip (id);

-- Reference: station_location (table: station)
ALTER TABLE station ADD CONSTRAINT station_location FOREIGN KEY station_location (location_id)
    REFERENCES location (id);

-- Reference: ticket_composition (table: ticket)
ALTER TABLE ticket ADD CONSTRAINT ticket_composition FOREIGN KEY ticket_composition (composition_id)
    REFERENCES composition (id);

-- Reference: ticket_schedule_arrival (table: ticket)
ALTER TABLE ticket ADD CONSTRAINT ticket_schedule_arrival FOREIGN KEY ticket_schedule_arrival (schedule_arrival_station_id)
    REFERENCES schedule (id);

-- Reference: ticket_schedule_departure (table: ticket)
ALTER TABLE ticket ADD CONSTRAINT ticket_schedule_departure FOREIGN KEY ticket_schedule_departure (schedule_departure_station_id)
    REFERENCES schedule (id);

-- Reference: ticket_user_account (table: ticket)
ALTER TABLE ticket ADD CONSTRAINT ticket_user_account FOREIGN KEY ticket_user_account (user_account_id)
    REFERENCES user_account (id);

-- End of file.


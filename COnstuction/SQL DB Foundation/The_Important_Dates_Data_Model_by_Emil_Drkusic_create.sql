-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:53:08.236

-- tables
-- Table: action
CREATE TABLE action (
    id int NOT NULL AUTO_INCREMENT,
    event_id int NOT NULL,
    action_catalog_id int NOT NULL,
    description text NULL,
    action_code text NOT NULL,
    starts_before int NULL COMMENT 'a moment before event time when it starts recurring',
    send_message bool NOT NULL,
    recurring bool NOT NULL,
    recurrence_interval_id int NULL,
    recurring_frequency int NULL,
    recurring_times int NULL,
    CONSTRAINT action_pk PRIMARY KEY (id)
);

-- Table: action_catalog
CREATE TABLE action_catalog (
    id int NOT NULL AUTO_INCREMENT,
    action_name varchar(64) NOT NULL,
    UNIQUE INDEX action_catalog_ak_1 (action_name),
    CONSTRAINT action_catalog_pk PRIMARY KEY (id)
) COMMENT 'the list of all possible actions';

-- Table: action_instance
CREATE TABLE action_instance (
    id int NOT NULL AUTO_INCREMENT,
    action_id int NOT NULL,
    event_instance_id int NOT NULL,
    action_time varchar(255) NOT NULL,
    insert_ts timestamp NOT NULL,
    action_completed bool NOT NULL,
    UNIQUE INDEX action_instance_ak_1 (action_id,event_instance_id,action_time),
    CONSTRAINT action_instance_pk PRIMARY KEY (id)
);

-- Table: event
CREATE TABLE event (
    id int NOT NULL AUTO_INCREMENT,
    selected_date_id int NOT NULL,
    event_catalog_id int NOT NULL,
    description text NOT NULL,
    recurring bool NOT NULL COMMENT 'does this event repeats itself',
    recurrence_interval_id int NULL,
    recurring_frequency int NULL COMMENT 'if interval = month, and frequency =2, then repeat every two months',
    recurring_times int NULL,
    CONSTRAINT event_pk PRIMARY KEY (id)
) COMMENT 'details related to specific event - e.g. mom''''s birthday';

-- Table: event_catalog
CREATE TABLE event_catalog (
    id int NOT NULL AUTO_INCREMENT,
    event_name varchar(64) NOT NULL,
    UNIQUE INDEX event_catalog_ak_1 (event_name),
    CONSTRAINT event_catalog_pk PRIMARY KEY (id)
) COMMENT 'birthday, public_holidays, anniversary, other...';

-- Table: event_instance
CREATE TABLE event_instance (
    id int NOT NULL AUTO_INCREMENT,
    event_id int NOT NULL,
    event_time varchar(255) NOT NULL,
    insert_ts timestamp NOT NULL,
    event_completed bool NOT NULL,
    UNIQUE INDEX event_instance_ak_1 (event_id,event_time),
    CONSTRAINT event_instance_pk PRIMARY KEY (id)
) COMMENT 'could be generated automatically or inserted manually';

-- Table: message
CREATE TABLE message (
    id int NOT NULL AUTO_INCREMENT,
    action_instance_id int NOT NULL,
    message_title varchar(255) NOT NULL,
    message_text text NOT NULL,
    insert_ts timestamp NOT NULL,
    message_read bool NOT NULL,
    CONSTRAINT message_pk PRIMARY KEY (id)
);

-- Table: person
CREATE TABLE person (
    id int NOT NULL AUTO_INCREMENT,
    full_name varchar(255) NOT NULL,
    details text NULL,
    user_account_id int NOT NULL,
    CONSTRAINT person_pk PRIMARY KEY (id)
);

-- Table: recurrence_interval
CREATE TABLE recurrence_interval (
    id int NOT NULL,
    interval_name varchar(64) NOT NULL,
    UNIQUE INDEX recurrence_interval_ak_1 (interval_name),
    CONSTRAINT recurrence_interval_pk PRIMARY KEY (id)
) COMMENT 'year, month, week, day';

-- Table: related_person
CREATE TABLE related_person (
    id int NOT NULL AUTO_INCREMENT,
    event_id int NOT NULL,
    person_id int NOT NULL,
    details text NULL,
    CONSTRAINT related_person_pk PRIMARY KEY (id)
);

-- Table: selected_date
CREATE TABLE selected_date (
    id int NOT NULL,
    user_account_id int NOT NULL,
    date_year int NULL,
    date_month int NULL,
    date_day int NULL,
    date_weekday varchar(128) NULL,
    CONSTRAINT selected_date_pk PRIMARY KEY (id)
) COMMENT 'starting point';

-- Table: user_account
CREATE TABLE user_account (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    user_name varchar(64) NOT NULL,
    password varchar(255) NOT NULL,
    mobile varchar(64) NOT NULL,
    email varchar(128) NOT NULL,
    confirmation_code text NOT NULL,
    confirmation_time timestamp NULL,
    insert_ts timestamp NOT NULL,
    UNIQUE INDEX user_account_ak_1 (user_name),
    UNIQUE INDEX user_account_ak_2 (email),
    CONSTRAINT user_account_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: action_action_catalog (table: action)
ALTER TABLE action ADD CONSTRAINT action_action_catalog FOREIGN KEY action_action_catalog (action_catalog_id)
    REFERENCES action_catalog (id);

-- Reference: action_event (table: action)
ALTER TABLE action ADD CONSTRAINT action_event FOREIGN KEY action_event (event_id)
    REFERENCES event (id);

-- Reference: action_instance_action (table: action_instance)
ALTER TABLE action_instance ADD CONSTRAINT action_instance_action FOREIGN KEY action_instance_action (action_id)
    REFERENCES action (id);

-- Reference: action_instance_event_instance (table: action_instance)
ALTER TABLE action_instance ADD CONSTRAINT action_instance_event_instance FOREIGN KEY action_instance_event_instance (event_instance_id)
    REFERENCES event_instance (id);

-- Reference: action_recurrence_interval (table: action)
ALTER TABLE action ADD CONSTRAINT action_recurrence_interval FOREIGN KEY action_recurrence_interval (recurrence_interval_id)
    REFERENCES recurrence_interval (id);

-- Reference: details_selected_date (table: event)
ALTER TABLE event ADD CONSTRAINT details_selected_date FOREIGN KEY details_selected_date (selected_date_id)
    REFERENCES selected_date (id);

-- Reference: event_event_catalog (table: event)
ALTER TABLE event ADD CONSTRAINT event_event_catalog FOREIGN KEY event_event_catalog (event_catalog_id)
    REFERENCES event_catalog (id);

-- Reference: event_instance_event (table: event_instance)
ALTER TABLE event_instance ADD CONSTRAINT event_instance_event FOREIGN KEY event_instance_event (event_id)
    REFERENCES event (id);

-- Reference: event_recurrence_interval (table: event)
ALTER TABLE event ADD CONSTRAINT event_recurrence_interval FOREIGN KEY event_recurrence_interval (recurrence_interval_id)
    REFERENCES recurrence_interval (id);

-- Reference: message_action_instance (table: message)
ALTER TABLE message ADD CONSTRAINT message_action_instance FOREIGN KEY message_action_instance (action_instance_id)
    REFERENCES action_instance (id);

-- Reference: person_user_account (table: person)
ALTER TABLE person ADD CONSTRAINT person_user_account FOREIGN KEY person_user_account (user_account_id)
    REFERENCES user_account (id);

-- Reference: related_person_event (table: related_person)
ALTER TABLE related_person ADD CONSTRAINT related_person_event FOREIGN KEY related_person_event (event_id)
    REFERENCES event (id);

-- Reference: related_person_person (table: related_person)
ALTER TABLE related_person ADD CONSTRAINT related_person_person FOREIGN KEY related_person_person (person_id)
    REFERENCES person (id);

-- Reference: selected_date_user_account (table: selected_date)
ALTER TABLE selected_date ADD CONSTRAINT selected_date_user_account FOREIGN KEY selected_date_user_account (user_account_id)
    REFERENCES user_account (id);

-- End of file.


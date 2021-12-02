-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:14:43.392

-- tables
-- Table: event
CREATE TABLE event (
    id number  NOT NULL,
    event_title varchar2(50)  NOT NULL,
    event_description varchar2(500)  NULL,
    start_date date  NOT NULL,
    end_date date  NULL,
    start_time timestamp  NULL,
    end_time timestamp  NULL,
    is_full_day_event char(1)  NOT NULL,
    is_recurring char(1)  NOT NULL,
    created_by varchar2(10)  NOT NULL,
    created_date date  NOT NULL,
    parent_event_id number  NULL,
    CONSTRAINT event_pk PRIMARY KEY (id)
) ;

-- Table: event_instance_exception
CREATE TABLE event_instance_exception (
    id number  NOT NULL,
    event_id number  NOT NULL,
    is_rescheduled char(1)  NOT NULL,
    is_cancelled char(1)  NOT NULL,
    start_date date  NOT NULL,
    end_date date  NOT NULL,
    start_time timestamp  NULL,
    end_time timestamp  NULL,
    is_full_day_event char(1)  NULL,
    created_by varchar2(10)  NOT NULL,
    created_date date  NOT NULL,
    CONSTRAINT event_instance_exception_pk PRIMARY KEY (id)
) ;

-- Table: recurring_pattern
CREATE TABLE recurring_pattern (
    event_id number  NOT NULL,
    recurring_type_id number  NOT NULL,
    separation_count number  DEFAULT 0 NULL,
    max_num_of_occurrences number  NULL,
    day_of_week number  NULL,
    week_of_month number  NULL,
    day_of_month number  NULL,
    month_of_year number  NULL,
    CONSTRAINT recurring_pattern_pk PRIMARY KEY (event_id)
) ;

-- Table: recurring_type
CREATE TABLE recurring_type (
    id number  NOT NULL,
    recurring_type varchar2(20)  NOT NULL,
    CONSTRAINT recurring_type_pk PRIMARY KEY (id)
) ;

-- foreign keys
-- Reference: event_event (table: event)
ALTER TABLE event ADD CONSTRAINT event_event
    FOREIGN KEY (parent_event_id)
    REFERENCES event (id);

-- Reference: event_exception_event (table: event_instance_exception)
ALTER TABLE event_instance_exception ADD CONSTRAINT event_exception_event
    FOREIGN KEY (event_id)
    REFERENCES event (id);

-- Reference: rec_pattern_rec_type (table: recurring_pattern)
ALTER TABLE recurring_pattern ADD CONSTRAINT rec_pattern_rec_type
    FOREIGN KEY (recurring_type_id)
    REFERENCES recurring_type (id);

-- Reference: recurring_pattern_event (table: recurring_pattern)
ALTER TABLE recurring_pattern ADD CONSTRAINT recurring_pattern_event
    FOREIGN KEY (event_id)
    REFERENCES event (id);

-- End of file.


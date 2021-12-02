-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:34:16.037

-- tables
-- Table: group
CREATE TABLE "group" (
    id number(10,0)  NOT NULL,
    name varchar2(50)  NOT NULL,
    create_date date  NOT NULL,
    is_active char(1)  NOT NULL,
    CONSTRAINT group_pk PRIMARY KEY (id)
) ;

-- Table: message
CREATE TABLE message (
    id number(10,0)  NOT NULL,
    subject varchar2(100)  NOT NULL,
    creator_id number(10,0)  NOT NULL,
    message_body clob  NOT NULL,
    create_date date  NOT NULL,
    parent_message_id number(10,0)  NULL,
    expiry_date date  NOT NULL,
    is_reminder number(1,0)  NOT NULL,
    next_remind_date date  NULL,
    reminder_frequency_id number(10,0)  NULL,
    CONSTRAINT message_pk PRIMARY KEY (id)
) ;

-- Table: message_recipient
CREATE TABLE message_recipient (
    id number(10,0)  NOT NULL,
    recipient_id number(10,0)  NULL,
    recipient_group_id number(10,0)  NULL,
    message_id number(10,0)  NOT NULL,
    is_read number(1,0)  NOT NULL,
    CONSTRAINT message_recipient_pk PRIMARY KEY (id)
) ;

-- Table: reminder_frequency
CREATE TABLE reminder_frequency (
    id number(10,0)  NOT NULL,
    title varchar2(25)  NOT NULL,
    frequency number(1,0)  NOT NULL,
    is_active char(1)  NOT NULL,
    CONSTRAINT reminder_frequency_pk PRIMARY KEY (id)
) ;

-- Table: user
CREATE TABLE "user" (
    id number(10,0)  NOT NULL,
    first_name varchar2(50)  NOT NULL,
    last_name varchar2(50)  NOT NULL,
    create_date date  NOT NULL,
    is_active char(1)  NOT NULL,
    CONSTRAINT user_pk PRIMARY KEY (id)
) ;

-- Table: user_group
CREATE TABLE user_group (
    id number(10,0)  NOT NULL,
    user_id number(10,0)  NOT NULL,
    group_id number(10,0)  NOT NULL,
    create_date date  NOT NULL,
    is_active char(1)  NOT NULL,
    CONSTRAINT user_group_pk PRIMARY KEY (id)
) ;

-- foreign keys
-- Reference: message_message (table: message)
ALTER TABLE message ADD CONSTRAINT message_message
    FOREIGN KEY (parent_message_id)
    REFERENCES message (id);

-- Reference: message_recipient_message (table: message_recipient)
ALTER TABLE message_recipient ADD CONSTRAINT message_recipient_message
    FOREIGN KEY (message_id)
    REFERENCES message (id);

-- Reference: message_recipient_user (table: message_recipient)
ALTER TABLE message_recipient ADD CONSTRAINT message_recipient_user
    FOREIGN KEY (recipient_id)
    REFERENCES "user" (id);

-- Reference: message_recipient_user_group (table: message_recipient)
ALTER TABLE message_recipient ADD CONSTRAINT message_recipient_user_group
    FOREIGN KEY (recipient_group_id)
    REFERENCES user_group (id);

-- Reference: message_reminder_frequency (table: message)
ALTER TABLE message ADD CONSTRAINT message_reminder_frequency
    FOREIGN KEY (reminder_frequency_id)
    REFERENCES reminder_frequency (id);

-- Reference: message_user (table: message)
ALTER TABLE message ADD CONSTRAINT message_user
    FOREIGN KEY (creator_id)
    REFERENCES "user" (id);

-- Reference: user_group_group (table: user_group)
ALTER TABLE user_group ADD CONSTRAINT user_group_group
    FOREIGN KEY (group_id)
    REFERENCES "group" (id);

-- Reference: user_group_user (table: user_group)
ALTER TABLE user_group ADD CONSTRAINT user_group_user
    FOREIGN KEY (user_id)
    REFERENCES "user" (id);

-- End of file.


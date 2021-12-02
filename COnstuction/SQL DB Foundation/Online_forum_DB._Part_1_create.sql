-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:41:05.675

-- tables
-- Table: post
CREATE TABLE post (
    id integer  NOT NULL,
    "content" varchar(1000)  NOT NULL,
    created timestamp  NOT NULL,
    thread_id integer  NOT NULL,
    user_account_id integer  NOT NULL,
    CONSTRAINT post_pk PRIMARY KEY (id)
)
;

-- Table: thread
CREATE TABLE thread (
    id integer  NOT NULL,
    subject varchar(100)  NOT NULL,
    created timestamp  NOT NULL,
    user_account_id integer  NOT NULL,
    CONSTRAINT thread_pk PRIMARY KEY (id)
)
;

-- Table: user_account
CREATE TABLE user_account (
    id integer  NOT NULL,
    name varchar(50)  NOT NULL,
    hashed_password varchar(50)  NOT NULL,
    created timestamp  NOT NULL,
    CONSTRAINT user_account_pk PRIMARY KEY (id)
)
;

-- foreign keys
-- Reference: post_thread (table: post)
ALTER TABLE post ADD CONSTRAINT post_thread
    FOREIGN KEY (thread_id)
    REFERENCES thread (id);

-- Reference: post_user (table: post)
ALTER TABLE post ADD CONSTRAINT post_user
    FOREIGN KEY (user_account_id)
    REFERENCES user_account (id);

-- Reference: thread_user (table: thread)
ALTER TABLE thread ADD CONSTRAINT thread_user
    FOREIGN KEY (user_account_id)
    REFERENCES user_account (id);

-- End of file.


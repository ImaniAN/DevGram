-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:39:56.914

-- tables
-- Table: post
CREATE TABLE post (
    id integer  NOT NULL,
    "content" varchar(1000)  NOT NULL,
    created timestamp  NOT NULL,
    thread_id integer  NOT NULL,
    user_account_id integer  NOT NULL,
    "status" integer  NOT NULL,
    CONSTRAINT post_pk PRIMARY KEY (id)
)
;

-- Table: status
CREATE TABLE "status" (
    id integer  NOT NULL,
    name varchar(100)  NOT NULL,
    CONSTRAINT status_pk PRIMARY KEY (id)
)
;

-- Table: thread
CREATE TABLE thread (
    id integer  NOT NULL,
    subject varchar(100)  NOT NULL,
    created timestamp  NOT NULL,
    user_account_id integer  NOT NULL,
    "status" integer  NOT NULL,
    CONSTRAINT thread_pk PRIMARY KEY (id)
)
;

-- Table: user_account
CREATE TABLE user_account (
    id integer  NOT NULL,
    username varchar(100)  NOT NULL,
    hashed_password varchar(100)  NOT NULL,
    first_name varchar(100)  NULL,
    last_name varchar(100)  NULL,
    email varchar(254)  NOT NULL,
    created timestamp  NOT NULL,
    picture blob  NULL,
    last_activity timestamp  NOT NULL,
    is_moderator boolean  NOT NULL DEFAULT false,
    "status" varchar(100)  NOT NULL,
    user_status integer  NOT NULL,
    CONSTRAINT user_account_pk PRIMARY KEY (id)
)
;

-- Table: user_status
CREATE TABLE user_status (
    id integer  NOT NULL,
    name varchar(100)  NOT NULL,
    CONSTRAINT user_status_pk PRIMARY KEY (id)
)
;

-- foreign keys
-- Reference: post_status (table: post)
ALTER TABLE post ADD CONSTRAINT post_status
    FOREIGN KEY ("status")
    REFERENCES "status" (id);

-- Reference: post_thread (table: post)
ALTER TABLE post ADD CONSTRAINT post_thread
    FOREIGN KEY (thread_id)
    REFERENCES thread (id);

-- Reference: post_user (table: post)
ALTER TABLE post ADD CONSTRAINT post_user
    FOREIGN KEY (user_account_id)
    REFERENCES user_account (id);

-- Reference: thread_status (table: thread)
ALTER TABLE thread ADD CONSTRAINT thread_status
    FOREIGN KEY ("status")
    REFERENCES "status" (id);

-- Reference: thread_user (table: thread)
ALTER TABLE thread ADD CONSTRAINT thread_user
    FOREIGN KEY (user_account_id)
    REFERENCES user_account (id);

-- Reference: user_user_status (table: user_account)
ALTER TABLE user_account ADD CONSTRAINT user_user_status
    FOREIGN KEY (user_status)
    REFERENCES user_status (id);

-- End of file.


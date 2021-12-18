-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:37:54.969

-- tables
-- Table: category
CREATE TABLE category (
    id integer  NOT NULL,
    name varchar(100)  NOT NULL,
    description varchar(1000)  NOT NULL,
    creator integer  NOT NULL,
    created timestamp  NOT NULL,
    status_id integer  NOT NULL,
    category_id integer  NULL,
    CONSTRAINT category_pk PRIMARY KEY (id)
)
;

-- Table: groups
CREATE TABLE groups (
    id integer  NOT NULL,
    name varchar(100)  NOT NULL,
    category_id integer  NOT NULL,
    user_group_id integer  NOT NULL,
    CONSTRAINT groups_pk PRIMARY KEY (id)
)
;

-- Table: post
CREATE TABLE post (
    id integer  NOT NULL,
    subject varchar(100)  NOT NULL,
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

-- Table: user_group
CREATE TABLE user_group (
    user_id integer  NOT NULL,
    groups_id integer  NOT NULL,
    CONSTRAINT user_group_pk PRIMARY KEY (user_id,groups_id)
)
;

-- Table: user_status
CREATE TABLE user_status (
    id integer  NOT NULL,
    name varchar(100)  NOT NULL,
    CONSTRAINT user_status_pk PRIMARY KEY (id)
)
;

-- Table: votes
CREATE TABLE votes (
    id integer  NOT NULL,
    up_count integer  NOT NULL,
    down_count integer  NOT NULL,
    thread_id integer  NULL,
    post_id integer  NULL,
    CONSTRAINT votes_pk PRIMARY KEY (id)
)
;

-- foreign keys
-- Reference: category_category (table: category)
ALTER TABLE category ADD CONSTRAINT category_category
    FOREIGN KEY (category_id)
    REFERENCES category (id);

-- Reference: category_status (table: category)
ALTER TABLE category ADD CONSTRAINT category_status
    FOREIGN KEY (status_id)
    REFERENCES "status" (id);

-- Reference: category_user (table: category)
ALTER TABLE category ADD CONSTRAINT category_user
    FOREIGN KEY (creator)
    REFERENCES user_account (id);

-- Reference: group_users_user (table: user_group)
ALTER TABLE user_group ADD CONSTRAINT group_users_user
    FOREIGN KEY (user_id)
    REFERENCES user_account (id);

-- Reference: groups_category (table: groups)
ALTER TABLE groups ADD CONSTRAINT groups_category
    FOREIGN KEY (category_id)
    REFERENCES category (id);

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

-- Reference: user_group_groups (table: user_group)
ALTER TABLE user_group ADD CONSTRAINT user_group_groups
    FOREIGN KEY (groups_id)
    REFERENCES groups (id);

-- Reference: user_user_status (table: user_account)
ALTER TABLE user_account ADD CONSTRAINT user_user_status
    FOREIGN KEY (user_status)
    REFERENCES user_status (id);

-- Reference: votes_post (table: votes)
ALTER TABLE votes ADD CONSTRAINT votes_post
    FOREIGN KEY (post_id)
    REFERENCES post (id);

-- Reference: votes_thread (table: votes)
ALTER TABLE votes ADD CONSTRAINT votes_thread
    FOREIGN KEY (thread_id)
    REFERENCES thread (id);

-- End of file.


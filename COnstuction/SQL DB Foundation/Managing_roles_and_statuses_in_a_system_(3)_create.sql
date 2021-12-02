-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:35:45.517

-- tables
-- Table: role
CREATE TABLE role (
    id int NOT NULL AUTO_INCREMENT,
    role_name varchar(100) NOT NULL,
    CONSTRAINT role_pk PRIMARY KEY (id)
);

-- Table: status
CREATE TABLE status (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(100) NOT NULL,
    is_user_working bool NOT NULL,
    CONSTRAINT status_pk PRIMARY KEY (id)
);

-- Table: user_account
CREATE TABLE user_account (
    id int NOT NULL AUTO_INCREMENT,
    user_name varchar(100) NOT NULL,
    email varchar(254) NOT NULL,
    password varchar(200) NOT NULL,
    password_salt varchar(50) NULL,
    password_hash_algorithm varchar(50) NOT NULL,
    current_status_id int NULL,
    CONSTRAINT user_account_pk PRIMARY KEY (id)
);

-- Table: user_has_role
CREATE TABLE user_has_role (
    id int NOT NULL AUTO_INCREMENT,
    role_start_time timestamp NOT NULL,
    role_end_time timestamp NULL,
    user_account_id int NOT NULL,
    role_id int NOT NULL,
    UNIQUE INDEX user_has_role_ak_1 (role_start_time,role_id,user_account_id),
    CONSTRAINT user_has_role_pk PRIMARY KEY (id)
);

-- Table: user_has_status
CREATE TABLE user_has_status (
    id int NOT NULL AUTO_INCREMENT,
    status_start_time timestamp NOT NULL,
    status_end_time timestamp NULL,
    user_account_id int NOT NULL,
    status_id int NOT NULL,
    UNIQUE INDEX user_has_status_ak_1 (status_start_time,user_account_id),
    CONSTRAINT user_has_status_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: user_account_status (table: user_account)
ALTER TABLE user_account ADD CONSTRAINT user_account_status FOREIGN KEY user_account_status (current_status_id)
    REFERENCES status (id);

-- Reference: user_has_role_role (table: user_has_role)
ALTER TABLE user_has_role ADD CONSTRAINT user_has_role_role FOREIGN KEY user_has_role_role (role_id)
    REFERENCES role (id);

-- Reference: user_has_role_user_account (table: user_has_role)
ALTER TABLE user_has_role ADD CONSTRAINT user_has_role_user_account FOREIGN KEY user_has_role_user_account (user_account_id)
    REFERENCES user_account (id);

-- Reference: user_has_status_status (table: user_has_status)
ALTER TABLE user_has_status ADD CONSTRAINT user_has_status_status FOREIGN KEY user_has_status_status (status_id)
    REFERENCES status (id);

-- Reference: user_has_status_user_account (table: user_has_status)
ALTER TABLE user_has_status ADD CONSTRAINT user_has_status_user_account FOREIGN KEY user_has_status_user_account (user_account_id)
    REFERENCES user_account (id);

-- End of file.


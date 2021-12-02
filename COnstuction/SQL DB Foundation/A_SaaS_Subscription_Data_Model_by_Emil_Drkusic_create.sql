-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:53:07.686

-- tables
-- Table: in_group
CREATE TABLE in_group (
    id int NOT NULL AUTO_INCREMENT,
    user_group_id int NOT NULL,
    user_account_id int NOT NULL,
    time_added timestamp NOT NULL,
    time_removed timestamp NULL,
    group_admin bool NOT NULL,
    UNIQUE INDEX in_group_ak_1 (user_group_id,user_account_id,time_added),
    CONSTRAINT in_group_pk PRIMARY KEY (id)
);

-- Table: include
CREATE TABLE include (
    id int NOT NULL AUTO_INCREMENT,
    offer_id int NOT NULL,
    plan_id int NOT NULL,
    UNIQUE INDEX include_ak_1 (offer_id,plan_id),
    CONSTRAINT include_pk PRIMARY KEY (id)
);

-- Table: invoice
CREATE TABLE invoice (
    id int NOT NULL AUTO_INCREMENT,
    customer_invoice_data text NOT NULL,
    subscription_id int NOT NULL,
    plan_history_id int NOT NULL,
    invoice_period_start_date date NOT NULL,
    invoice_period_end_date date NOT NULL,
    invoice_description varchar(255) NOT NULL,
    invoice_amount decimal(8,2) NOT NULL,
    invoice_created_ts timestamp NOT NULL,
    invoice_due_ts timestamp NOT NULL,
    invoice_paid_ts timestamp NULL,
    CONSTRAINT invoice_pk PRIMARY KEY (id)
);

-- Table: offer
CREATE TABLE offer (
    id int NOT NULL AUTO_INCREMENT,
    offer_name varchar(255) NOT NULL,
    offer_start_date date NOT NULL,
    offer_end_date date NULL,
    description text NOT NULL,
    discount_amount decimal(8,2) NULL,
    discount_percentage decimal(5,2) NULL COMMENT 'discount percentage',
    duration_months int NULL,
    duration_end_date date NULL,
    UNIQUE INDEX offer_ak_1 (offer_name),
    CONSTRAINT offer_pk PRIMARY KEY (id)
);

-- Table: option
CREATE TABLE `option` (
    id int NOT NULL AUTO_INCREMENT,
    option_name varchar(255) NOT NULL,
    UNIQUE INDEX option_ak_1 (option_name),
    CONSTRAINT option_pk PRIMARY KEY (id)
);

-- Table: option_included
CREATE TABLE option_included (
    id int NOT NULL AUTO_INCREMENT,
    plan_id int NOT NULL,
    option_id int NOT NULL,
    date_added date NOT NULL,
    date_removed date NULL,
    UNIQUE INDEX option_included_ak_1 (plan_id,option_id,date_added),
    CONSTRAINT option_included_pk PRIMARY KEY (id)
);

-- Table: plan
CREATE TABLE plan (
    id int NOT NULL AUTO_INCREMENT,
    plan_name varchar(255) NOT NULL,
    software_id int NOT NULL,
    user_group_type_id int NOT NULL,
    current_price decimal(8,2) NOT NULL,
    insert_ts timestamp NOT NULL,
    is_active bool NOT NULL COMMENT 'if plan is still active or not',
    UNIQUE INDEX plan_ak_1 (plan_name,software_id),
    CONSTRAINT plan_pk PRIMARY KEY (id)
) COMMENT 'a list of possible subscription plans';

-- Table: plan_history
CREATE TABLE plan_history (
    id int NOT NULL AUTO_INCREMENT,
    subscription_id int NOT NULL,
    plan_id int NOT NULL,
    date_start date NOT NULL,
    date_end date NULL,
    insert_ts timestamp NOT NULL,
    CONSTRAINT plan_history_pk PRIMARY KEY (id)
);

-- Table: prerequisite
CREATE TABLE prerequisite (
    id int NOT NULL AUTO_INCREMENT,
    offer_id int NOT NULL,
    plan_id int NOT NULL,
    UNIQUE INDEX prerequisite_ak_1 (offer_id,plan_id),
    CONSTRAINT prerequisite_pk PRIMARY KEY (id)
);

-- Table: software
CREATE TABLE software (
    id int NOT NULL AUTO_INCREMENT,
    software_name varchar(255) NOT NULL,
    details text NULL,
    access_link text NOT NULL,
    UNIQUE INDEX software_ak_1 (software_name),
    CONSTRAINT software_pk PRIMARY KEY (id)
) COMMENT 'a dictionary of all software products we have in offer';

-- Table: subscription
CREATE TABLE subscription (
    id int NOT NULL AUTO_INCREMENT,
    user_group_id int NOT NULL,
    trial_period_start_date date NULL,
    trial_period_end_date date NULL,
    subscribe_after_trial bool NOT NULL,
    current_plan_id int NOT NULL,
    offer_id int NULL,
    offer_start_date date NULL,
    offer_end_date date NULL,
    date_subscribed date NOT NULL,
    valid_to date NOT NULL,
    date_unsubscribed date NULL,
    insert_ts timestamp NOT NULL,
    CONSTRAINT subscription_pk PRIMARY KEY (id)
) COMMENT 'a list of all subscriptions';

-- Table: user_account
CREATE TABLE user_account (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    user_name varchar(64) NOT NULL,
    password varchar(255) NOT NULL,
    email varchar(128) NOT NULL,
    confirmation_code text NOT NULL,
    confirmation_time timestamp NULL,
    insert_ts timestamp NOT NULL,
    UNIQUE INDEX user_account_ak_1 (user_name),
    UNIQUE INDEX user_account_ak_2 (email),
    CONSTRAINT user_account_pk PRIMARY KEY (id)
) COMMENT 'a list of single user accounts';

-- Table: user_group
CREATE TABLE user_group (
    id int NOT NULL AUTO_INCREMENT,
    user_group_type_id int NOT NULL,
    customer_invoice_data text NOT NULL,
    insert_ts timestamp NOT NULL,
    CONSTRAINT user_group_pk PRIMARY KEY (id)
) COMMENT 'groups subscribing to software';

-- Table: user_group_type
CREATE TABLE user_group_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(128) NOT NULL,
    members_min int NOT NULL,
    members_max int NOT NULL,
    UNIQUE INDEX user_group_type_ak_1 (type_name),
    CONSTRAINT user_group_type_pk PRIMARY KEY (id)
) COMMENT 'group type, e.g. individual account, student account, group - of individuals, group - company';

-- foreign keys
-- Reference: in_group_user_account (table: in_group)
ALTER TABLE in_group ADD CONSTRAINT in_group_user_account FOREIGN KEY in_group_user_account (user_account_id)
    REFERENCES user_account (id);

-- Reference: in_group_user_group (table: in_group)
ALTER TABLE in_group ADD CONSTRAINT in_group_user_group FOREIGN KEY in_group_user_group (user_group_id)
    REFERENCES user_group (id);

-- Reference: include_offer (table: include)
ALTER TABLE include ADD CONSTRAINT include_offer FOREIGN KEY include_offer (offer_id)
    REFERENCES offer (id);

-- Reference: include_plan (table: include)
ALTER TABLE include ADD CONSTRAINT include_plan FOREIGN KEY include_plan (plan_id)
    REFERENCES plan (id);

-- Reference: option_included_option (table: option_included)
ALTER TABLE option_included ADD CONSTRAINT option_included_option FOREIGN KEY option_included_option (option_id)
    REFERENCES `option` (id);

-- Reference: option_included_plan (table: option_included)
ALTER TABLE option_included ADD CONSTRAINT option_included_plan FOREIGN KEY option_included_plan (plan_id)
    REFERENCES plan (id);

-- Reference: payment_plan_history (table: invoice)
ALTER TABLE invoice ADD CONSTRAINT payment_plan_history FOREIGN KEY payment_plan_history (plan_history_id)
    REFERENCES plan_history (id);

-- Reference: payment_subscription (table: invoice)
ALTER TABLE invoice ADD CONSTRAINT payment_subscription FOREIGN KEY payment_subscription (subscription_id)
    REFERENCES subscription (id);

-- Reference: plan_history_plan (table: plan_history)
ALTER TABLE plan_history ADD CONSTRAINT plan_history_plan FOREIGN KEY plan_history_plan (plan_id)
    REFERENCES plan (id);

-- Reference: plan_history_subscription (table: plan_history)
ALTER TABLE plan_history ADD CONSTRAINT plan_history_subscription FOREIGN KEY plan_history_subscription (subscription_id)
    REFERENCES subscription (id);

-- Reference: plan_software (table: plan)
ALTER TABLE plan ADD CONSTRAINT plan_software FOREIGN KEY plan_software (software_id)
    REFERENCES software (id);

-- Reference: plan_user_group_type (table: plan)
ALTER TABLE plan ADD CONSTRAINT plan_user_group_type FOREIGN KEY plan_user_group_type (user_group_type_id)
    REFERENCES user_group_type (id);

-- Reference: prerequisite_offer (table: prerequisite)
ALTER TABLE prerequisite ADD CONSTRAINT prerequisite_offer FOREIGN KEY prerequisite_offer (offer_id)
    REFERENCES offer (id);

-- Reference: prerequisite_plan (table: prerequisite)
ALTER TABLE prerequisite ADD CONSTRAINT prerequisite_plan FOREIGN KEY prerequisite_plan (plan_id)
    REFERENCES plan (id);

-- Reference: subscription_offer (table: subscription)
ALTER TABLE subscription ADD CONSTRAINT subscription_offer FOREIGN KEY subscription_offer (offer_id)
    REFERENCES offer (id);

-- Reference: subscription_plan (table: subscription)
ALTER TABLE subscription ADD CONSTRAINT subscription_plan FOREIGN KEY subscription_plan (current_plan_id)
    REFERENCES plan (id);

-- Reference: subscription_user_group (table: subscription)
ALTER TABLE subscription ADD CONSTRAINT subscription_user_group FOREIGN KEY subscription_user_group (user_group_id)
    REFERENCES user_group (id);

-- Reference: user_group_user_group_type (table: user_group)
ALTER TABLE user_group ADD CONSTRAINT user_group_user_group_type FOREIGN KEY user_group_user_group_type (user_group_type_id)
    REFERENCES user_group_type (id);

-- End of file.


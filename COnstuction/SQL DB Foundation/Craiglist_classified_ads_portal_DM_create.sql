-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:08:39.238

-- tables
-- Table: category
CREATE TABLE category (
    id number  NOT NULL,
    category_name varchar2(100)  NOT NULL,
    parent_category_id number  NULL,
    maximum_images_allowed number  NOT NULL,
    post_validity_interval_in_days number  NOT NULL,
    CONSTRAINT category_pk PRIMARY KEY (id)
) ;

-- Table: city
CREATE TABLE city (
    id number  NOT NULL,
    city_name varchar2(100)  NOT NULL,
    state_id number  NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (id)
) ;

-- Table: country
CREATE TABLE country (
    id number  NOT NULL,
    country_name varchar2(100)  NOT NULL,
    currency_code varchar2(20)  NOT NULL,
    CONSTRAINT country_pk PRIMARY KEY (id)
) ;

-- Table: county
CREATE TABLE county (
    id number  NOT NULL,
    county_name varchar2(100)  NOT NULL,
    city_id number  NOT NULL,
    CONSTRAINT county_pk PRIMARY KEY (id)
) ;

-- Table: language
CREATE TABLE language (
    id number  NOT NULL,
    language_name varchar2(50)  NOT NULL,
    CONSTRAINT language_pk PRIMARY KEY (id)
) ;

-- Table: post
CREATE TABLE post (
    id number  NOT NULL,
    user_account_id number  NOT NULL,
    category_id number  NOT NULL,
    create_date date  NOT NULL,
    post_title varchar2(50)  NOT NULL,
    post_detail clob  NOT NULL,
    is_active char(1)  NOT NULL,
    is_seller char(1)  NOT NULL,
    is_individual char(1)  NOT NULL,
    expected_price number  NULL,
    is_price_negotiable char(1)  NULL,
    last_renewed_on date  NULL,
    CONSTRAINT post_pk PRIMARY KEY (id)
) ;

-- Table: post_alert
CREATE TABLE post_alert (
    id number  NOT NULL,
    user_account_id number  NOT NULL,
    create_date date  NOT NULL,
    valid_for number  NOT NULL,
    category_id number  NOT NULL,
    search_context varchar2(100)  NOT NULL,
    CONSTRAINT post_alert_pk PRIMARY KEY (id)
) ;

-- Table: post_attribute
CREATE TABLE post_attribute (
    post_id number  NOT NULL,
    post_attribute xmltype  NOT NULL,
    CONSTRAINT post_attribute_pk PRIMARY KEY (post_id)
) ;

-- Table: post_image
CREATE TABLE post_image (
    id number  NOT NULL,
    post_id number  NOT NULL,
    image blob  NOT NULL,
    CONSTRAINT post_image_pk PRIMARY KEY (id)
) ;

-- Table: property
CREATE TABLE property (
    id number  NOT NULL,
    category_id number  NOT NULL,
    property_name varchar2(100)  NOT NULL,
    property_unit varchar2(100)  NULL,
    is_mandatory char(1)  NOT NULL,
    screen_control_id number  NOT NULL,
    possible_values xmltype  NULL,
    CONSTRAINT property_pk PRIMARY KEY (id)
) ;

-- Table: screen_control
CREATE TABLE screen_control (
    id number  NOT NULL,
    screen_control varchar2(50)  NOT NULL,
    CONSTRAINT screen_control_pk PRIMARY KEY (id)
) ;

-- Table: state
CREATE TABLE state (
    id number  NOT NULL,
    state_name varchar2(100)  NOT NULL,
    country_id number  NOT NULL,
    CONSTRAINT state_pk PRIMARY KEY (id)
) ;

-- Table: user_account
CREATE TABLE user_account (
    id number  NOT NULL,
    first_name varchar2(50)  NOT NULL,
    last_name varchar2(50)  NOT NULL,
    email varchar2(255)  NOT NULL,
    mobile_number number  NOT NULL,
    login_pwd_encry varchar2(20)  NOT NULL,
    preferred_language_id number  NOT NULL,
    county_id number  NOT NULL,
    zip varchar2(20)  NOT NULL,
    is_privacy_enabled char(1)  NOT NULL,
    CONSTRAINT user_account_pk PRIMARY KEY (id)
) ;

-- foreign keys
-- Reference: Table_11_post (table: post_image)
ALTER TABLE post_image ADD CONSTRAINT Table_11_post
    FOREIGN KEY (post_id)
    REFERENCES post (id);

-- Reference: category_category (table: category)
ALTER TABLE category ADD CONSTRAINT category_category
    FOREIGN KEY (parent_category_id)
    REFERENCES category (id);

-- Reference: city_state (table: city)
ALTER TABLE city ADD CONSTRAINT city_state
    FOREIGN KEY (state_id)
    REFERENCES state (id);

-- Reference: county_city (table: county)
ALTER TABLE county ADD CONSTRAINT county_city
    FOREIGN KEY (city_id)
    REFERENCES city (id);

-- Reference: post_alert_category (table: post_alert)
ALTER TABLE post_alert ADD CONSTRAINT post_alert_category
    FOREIGN KEY (category_id)
    REFERENCES category (id);

-- Reference: post_alert_user_account (table: post_alert)
ALTER TABLE post_alert ADD CONSTRAINT post_alert_user_account
    FOREIGN KEY (user_account_id)
    REFERENCES user_account (id);

-- Reference: post_category (table: post)
ALTER TABLE post ADD CONSTRAINT post_category
    FOREIGN KEY (category_id)
    REFERENCES category (id);

-- Reference: post_property_post (table: post_attribute)
ALTER TABLE post_attribute ADD CONSTRAINT post_property_post
    FOREIGN KEY (post_id)
    REFERENCES post (id);

-- Reference: post_user_account (table: post)
ALTER TABLE post ADD CONSTRAINT post_user_account
    FOREIGN KEY (user_account_id)
    REFERENCES user_account (id);

-- Reference: property_category (table: property)
ALTER TABLE property ADD CONSTRAINT property_category
    FOREIGN KEY (category_id)
    REFERENCES category (id);

-- Reference: property_screen_control (table: property)
ALTER TABLE property ADD CONSTRAINT property_screen_control
    FOREIGN KEY (screen_control_id)
    REFERENCES screen_control (id);

-- Reference: state_country (table: state)
ALTER TABLE state ADD CONSTRAINT state_country
    FOREIGN KEY (country_id)
    REFERENCES country (id);

-- Reference: user_account_county (table: user_account)
ALTER TABLE user_account ADD CONSTRAINT user_account_county
    FOREIGN KEY (county_id)
    REFERENCES county (id);

-- Reference: user_account_language (table: user_account)
ALTER TABLE user_account ADD CONSTRAINT user_account_language
    FOREIGN KEY (preferred_language_id)
    REFERENCES language (id);

-- End of file.


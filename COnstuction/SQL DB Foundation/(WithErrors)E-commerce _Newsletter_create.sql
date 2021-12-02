-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:14:30.452

-- tables
-- Table: channel
CREATE TABLE channel (
    id int  NOT NULL,
    channel varchar(255)  NOT NULL,
    CONSTRAINT channel_pk PRIMARY KEY  (id)
);

-- Table: client
CREATE TABLE client (
    id int  NOT NULL,
    first_name varchar(255)  NOT NULL,
    last_name varchar(255)  NOT NULL,
    email varchar(255)  NOT NULL,
    phone_number int  NOT NULL,
    country varchar(50)  NOT NULL,
    postal_code varchar(6)  NOT NULL,
    city varchar(100)  NOT NULL,
    street varchar(100)  NOT NULL,
    house_number varchar(50)  NOT NULL,
    birthday date  NOT NULL,
    create_date date  NOT NULL,
    source_id int  NOT NULL,
    CONSTRAINT client_pk PRIMARY KEY  (id)
);

-- Table: consent_change
CREATE TABLE consent_change (
    id int  NOT NULL,
    client_id int  NOT NULL,
    channel_id int  NOT NULL,
    new_consent boolean  NOT NULL,
    update_date date  NOT NULL,
    CONSTRAINT consent_change_pk PRIMARY KEY  (id)
);

-- Table: marketing_consent
CREATE TABLE marketing_consent (
    client_id int  NOT NULL,
    newsletter_consent boolean  NOT NULL,
    direct_mailing_consent boolean  NOT NULL,
    telemarketing_consent boolean  NOT NULL,
    sms_consent boolean  NOT NULL,
    CONSTRAINT marketing_consent_pk PRIMARY KEY  (client_id)
);

-- Table: newsletter
CREATE TABLE newsletter (
    id int  NOT NULL,
    name varchar(255)  NOT NULL,
    subject varchar(255)  NOT NULL,
    html_file varchar(255)  NOT NULL,
    type varchar(255)  NOT NULL,
    create_date date  NOT NULL,
    CONSTRAINT id PRIMARY KEY  (id)
);

-- Table: newsletter_sendout
CREATE TABLE newsletter_sendout (
    id int  NOT NULL,
    newsletter_id int  NOT NULL,
    send_date date  NOT NULL,
    send_time time(6)  NOT NULL,
    CONSTRAINT id PRIMARY KEY  (id)
);

-- Table: nl_sendount_receivers
CREATE TABLE nl_sendount_receivers (
    id int  NOT NULL,
    client_id int  NOT NULL,
    nl_sendout_id int  NOT NULL,
    CONSTRAINT nl_sendount_receivers_pk PRIMARY KEY  (id)
);

-- Table: source
CREATE TABLE source (
    id int  NOT NULL,
    source_name varchar(255)  NOT NULL,
    CONSTRAINT source_pk PRIMARY KEY  (id)
);

-- foreign keys
-- Reference: client_Origin (table: client)
ALTER TABLE client ADD CONSTRAINT client_Origin
    FOREIGN KEY (source_id)
    REFERENCES source (id);

-- Reference: client_nl_sendount_receivers (table: nl_sendount_receivers)
ALTER TABLE nl_sendount_receivers ADD CONSTRAINT client_nl_sendount_receivers
    FOREIGN KEY (client_id)
    REFERENCES client (id);

-- Reference: consent_change_channel (table: consent_change)
ALTER TABLE consent_change ADD CONSTRAINT consent_change_channel
    FOREIGN KEY (channel_id)
    REFERENCES channel (id);

-- Reference: consent_change_marketing_consent (table: consent_change)
ALTER TABLE consent_change ADD CONSTRAINT consent_change_marketing_consent
    FOREIGN KEY (client_id)
    REFERENCES marketing_consent (client_id);

-- Reference: marketing_consent_client (table: marketing_consent)
ALTER TABLE marketing_consent ADD CONSTRAINT marketing_consent_client
    FOREIGN KEY (client_id)
    REFERENCES client (id);

-- Reference: newsletter_newsletter_sendout (table: newsletter_sendout)
ALTER TABLE newsletter_sendout ADD CONSTRAINT newsletter_newsletter_sendout
    FOREIGN KEY (newsletter_id)
    REFERENCES newsletter (id);

-- Reference: newsletter_sendout_nl_sendount_receivers (table: nl_sendount_receivers)
ALTER TABLE nl_sendount_receivers ADD CONSTRAINT newsletter_sendout_nl_sendount_receivers
    FOREIGN KEY (nl_sendout_id)
    REFERENCES newsletter_sendout (id);

-- End of file.


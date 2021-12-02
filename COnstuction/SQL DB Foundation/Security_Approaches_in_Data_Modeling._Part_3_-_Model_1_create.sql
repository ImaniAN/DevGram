-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:30:57.132

-- tables
-- Table: person
CREATE TABLE person (
    id integer  NOT NULL,
    given_name varchar2(100)  NOT NULL,
    family_name varchar2(100)  NOT NULL,
    birthdate date  NOT NULL,
    gender varchar2(1)  NOT NULL CHECK (gender in ('F', 'M')),
    email_address varchar2(500)  NOT NULL,
    street_address varchar2(500)  NOT NULL,
    city varchar2(150)  NOT NULL,
    province_state varchar2(100)  NOT NULL,
    postal_code varchar2(30)  NOT NULL,
    country varchar2(150)  NOT NULL,
    CONSTRAINT person_pk PRIMARY KEY (id)
) ;

-- Table: photo
CREATE TABLE photo (
    id integer  NOT NULL,
    content blob  NOT NULL,
    updated timestamp with time zone  NOT NULL,
    format_handle varchar2(150)  NOT NULL,
    uploaded_by_member_id integer  NOT NULL,
    uploading_member_seq integer  NOT NULL,
    for_club_id integer  NOT NULL,
    CONSTRAINT photo_pk PRIMARY KEY (id)
) ;

-- Table: photo_content
CREATE TABLE photo_content (
    photo_id integer  NOT NULL,
    person_id integer  NOT NULL,
    person_role_seq integer  DEFAULT 1 NOT NULL CHECK (person_role_seq <= role_max_per_person),
    photo_content_role_id integer  NOT NULL,
    role_max_per_person integer  NOT NULL,
    content_headline varchar2(100)  NULL CHECK (person_id > 0 or content_headline is not null),
    content_detailed clob  NULL,
    CONSTRAINT photo_content_pk PRIMARY KEY (photo_id,person_id,person_role_seq,photo_content_role_id)
) ;

-- Table: photo_content_role
CREATE TABLE photo_content_role (
    id integer  NOT NULL,
    max_per_person integer  DEFAULT 1 NOT NULL,
    label varchar2(100)  NOT NULL,
    description clob  NOT NULL,
    exclusive_to_club integer  NOT NULL,
    CONSTRAINT content_id_unique UNIQUE (id),
    CONSTRAINT photo_content_role_pk PRIMARY KEY (id,max_per_person)
) ;

-- foreign keys
-- Reference: photo_content_role (table: photo_content)
ALTER TABLE photo_content ADD CONSTRAINT photo_content_role
    FOREIGN KEY (photo_content_role_id,role_max_per_person)
    REFERENCES photo_content_role (id,max_per_person);

-- Reference: photo_interest_person (table: photo_content)
ALTER TABLE photo_content ADD CONSTRAINT photo_interest_person
    FOREIGN KEY (person_id)
    REFERENCES person (id);

-- Reference: photo_interest_photo (table: photo_content)
ALTER TABLE photo_content ADD CONSTRAINT photo_interest_photo
    FOREIGN KEY (photo_id)
    REFERENCES photo (id);

-- End of file.


-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:31:41.149

-- tables
-- Table: club
CREATE TABLE club (
    id integer  NOT NULL,
    name varchar2(500)  NOT NULL,
    description clob  NOT NULL,
    CONSTRAINT club_pk PRIMARY KEY (id)
) ;

-- Table: club_office
CREATE TABLE club_office (
    club_id integer  NOT NULL,
    office_seq integer  DEFAULT 1 NOT NULL,
    office_label varchar2(150)  NOT NULL,
    office_description clob  NOT NULL,
    photo_action_clearance varchar2(100)  NULL,
    CONSTRAINT club_office_pk PRIMARY KEY (club_id,office_seq)
) ;

CREATE UNIQUE INDEX Club_office_idx_1 
on club_office 
(club_id ASC,office_label ASC)
;

-- Table: graphic_format
CREATE TABLE graphic_format (
    handle varchar2(150)  NOT NULL,
    description clob  NOT NULL,
    CONSTRAINT graphic_format_pk PRIMARY KEY (handle)
) ;

-- Table: member
CREATE TABLE member (
    person_id integer  NOT NULL,
    club_id integer  NOT NULL,
    membership_seq integer  DEFAULT 1 NOT NULL,
    joined timestamp with time zone  NOT NULL,
    exited timestamp with time zone  NULL,
    CONSTRAINT member_pk PRIMARY KEY (person_id,club_id,membership_seq)
) ;

-- Table: officer
CREATE TABLE officer (
    member_id integer  NOT NULL,
    membership_seq integer  NOT NULL,
    club_id integer  NOT NULL,
    office_seq integer  NOT NULL,
    club_officer_seq integer  NOT NULL,
    officer_from timestamp with time zone  NOT NULL,
    officer_until timestamp with time zone  NULL,
    CONSTRAINT officer_pk PRIMARY KEY (member_id,membership_seq,club_id,office_seq,club_officer_seq)
) ;

-- Table: person
CREATE TABLE person (
    id integer  NOT NULL,
    given_name varchar2(100)  NOT NULL,
    family_name varchar2(100)  NOT NULL,
    birth_date date  NOT NULL,
    gender varchar2(1)  NOT NULL,
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
    updated timestamp  NOT NULL,
    format_handle varchar2(150)  NOT NULL,
    uploaded_by_member_id integer  NOT NULL,
    uploading_member_seq integer  NOT NULL,
    for_club_id integer  NOT NULL,
    CONSTRAINT photo_pk PRIMARY KEY (id)
) ;

-- Table: photo_action
CREATE TABLE photo_action (
    handle varchar2(100)  NOT NULL,
    sensitivity_rank integer  NOT NULL,
    description clob  NOT NULL,
    CONSTRAINT photo_action_pk PRIMARY KEY (handle)
) ;

-- foreign keys
-- Reference: Club_office_Club (table: club_office)
ALTER TABLE club_office ADD CONSTRAINT Club_office_Club
    FOREIGN KEY (club_id)
    REFERENCES club (id);

-- Reference: Member_Club (table: member)
ALTER TABLE member ADD CONSTRAINT Member_Club
    FOREIGN KEY (club_id)
    REFERENCES club (id);

-- Reference: Member_Person (table: member)
ALTER TABLE member ADD CONSTRAINT Member_Person
    FOREIGN KEY (person_id)
    REFERENCES person (id);

-- Reference: Photo_graphic_format (table: photo)
ALTER TABLE photo ADD CONSTRAINT Photo_graphic_format
    FOREIGN KEY (format_handle)
    REFERENCES graphic_format (handle);

-- Reference: club_office_photo_action (table: club_office)
ALTER TABLE club_office ADD CONSTRAINT club_office_photo_action
    FOREIGN KEY (photo_action_clearance)
    REFERENCES photo_action (handle);

-- Reference: officer_Club_office (table: officer)
ALTER TABLE officer ADD CONSTRAINT officer_Club_office
    FOREIGN KEY (club_id,office_seq)
    REFERENCES club_office (club_id,office_seq);

-- Reference: officer_Member (table: officer)
ALTER TABLE officer ADD CONSTRAINT officer_Member
    FOREIGN KEY (member_id,club_id,membership_seq)
    REFERENCES member (person_id,club_id,membership_seq);

-- Reference: photo_member (table: photo)
ALTER TABLE photo ADD CONSTRAINT photo_member
    FOREIGN KEY (uploaded_by_member_id,for_club_id,uploading_member_seq)
    REFERENCES member (person_id,club_id,membership_seq);

-- End of file.


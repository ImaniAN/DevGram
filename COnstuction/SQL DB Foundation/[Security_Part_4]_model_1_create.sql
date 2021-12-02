-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:30:14.959

-- tables
-- Table: album
CREATE TABLE album (
    id number  NOT NULL,
    club_id integer  NOT NULL,
    album_name varchar2(150)  NOT NULL,
    club_valuation number(16,2)  NULL,
    club_sensitivity number(16,2)  NULL,
    CONSTRAINT album_ak_1 UNIQUE (club_id, album_name),
    CONSTRAINT album_pk PRIMARY KEY (id)
) ;

-- Table: album_photo
CREATE TABLE album_photo (
    album_id number  NOT NULL,
    photo_order number  NOT NULL,
    photo_id integer  NOT NULL,
    caption varchar2(150)  NOT NULL,
    club_valuation number(16,2)  NULL,
    club_sensitivity number(16,2)  NULL,
    CONSTRAINT album_photo_ak_1 UNIQUE (album_id, photo_id),
    CONSTRAINT album_photo_pk PRIMARY KEY (album_id,photo_order)
) ;

-- Table: club
CREATE TABLE club (
    id integer  NOT NULL,
    name varchar2(500)  NOT NULL,
    description clob  NOT NULL,
    club_valuation number(16,2)  NULL,
    club_sensitivity number(16,2)  NULL,
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
    monicker varchar2(150)  NOT NULL,
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
    image_created timestamp  NULL,
    camera_mfr varchar2(150)  NULL,
    camera_model varchar2(150)  NULL,
    camera_software_version varchar2(100)  NULL,
    image_x_resolution number  NULL,
    image_y_resolution number  NULL,
    image_resolution_unit varchar2(100)  NULL,
    image_exposure_time number  NULL,
    camera_aperture_f number  NULL,
    GPSLatitude number  NULL,
    GPSLongitude number  NULL,
    GPSAltitude number  NULL,
    CONSTRAINT photo_pk PRIMARY KEY (id)
) ;

-- Table: photo_action
CREATE TABLE photo_action (
    handle varchar2(100)  NOT NULL,
    sensitivity_rank integer  NOT NULL,
    description clob  NOT NULL,
    CONSTRAINT photo_action_pk PRIMARY KEY (handle)
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
    exclusive_to_club integer  NULL,
    CONSTRAINT content_id_unique UNIQUE (id),
    CONSTRAINT photo_content_role_pk PRIMARY KEY (id,max_per_person)
) ;

-- foreign keys
-- Reference: Album_club (table: album)
ALTER TABLE album ADD CONSTRAINT Album_club
    FOREIGN KEY (club_id)
    REFERENCES club (id);

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

-- Reference: album_photo_album (table: album_photo)
ALTER TABLE album_photo ADD CONSTRAINT album_photo_album
    FOREIGN KEY (album_id)
    REFERENCES album (id);

-- Reference: album_photo_photo (table: album_photo)
ALTER TABLE album_photo ADD CONSTRAINT album_photo_photo
    FOREIGN KEY (photo_id)
    REFERENCES photo (id);

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

-- Reference: photo_content_role (table: photo_content)
ALTER TABLE photo_content ADD CONSTRAINT photo_content_role
    FOREIGN KEY (photo_content_role_id,role_max_per_person)
    REFERENCES photo_content_role (id,max_per_person);

-- Reference: photo_content_role_club (table: photo_content_role)
ALTER TABLE photo_content_role ADD CONSTRAINT photo_content_role_club
    FOREIGN KEY (exclusive_to_club)
    REFERENCES club (id);

-- Reference: photo_interest_person (table: photo_content)
ALTER TABLE photo_content ADD CONSTRAINT photo_interest_person
    FOREIGN KEY (person_id)
    REFERENCES person (id);

-- Reference: photo_interest_photo (table: photo_content)
ALTER TABLE photo_content ADD CONSTRAINT photo_interest_photo
    FOREIGN KEY (photo_id)
    REFERENCES photo (id);

-- Reference: photo_member (table: photo)
ALTER TABLE photo ADD CONSTRAINT photo_member
    FOREIGN KEY (uploaded_by_member_id,for_club_id,uploading_member_seq)
    REFERENCES member (person_id,club_id,membership_seq);

-- End of file.


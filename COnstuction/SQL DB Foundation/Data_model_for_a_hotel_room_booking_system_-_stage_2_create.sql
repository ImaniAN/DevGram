-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:36:25.685

-- tables
-- Table: guest
CREATE TABLE guest (
    id int  NOT NULL,
    first_name varchar(80)  NOT NULL,
    last_name varchar(80)  NOT NULL,
    member_since date  NOT NULL,
    CONSTRAINT guest_pk PRIMARY KEY (id)
);

-- Table: reservation
CREATE TABLE reservation (
    id int  NOT NULL,
    date_in date  NOT NULL,
    date_out date  NOT NULL,
    made_by varchar(20)  NOT NULL,
    guest_id int  NOT NULL,
    CONSTRAINT reservation_pk PRIMARY KEY (id)
);

-- Table: reserved_room
CREATE TABLE reserved_room (
    id int  NOT NULL,
    number_of_rooms int  NOT NULL,
    reservation_id int  NOT NULL,
    status varchar(20)  NOT NULL,
    CONSTRAINT reserved_room_pk PRIMARY KEY (id)
);

-- Table: room
CREATE TABLE room (
    id int  NOT NULL,
    number int  NOT NULL,
    name varchar(40)  NOT NULL,
    status varchar(10)  NOT NULL,
    smoke boolean  NOT NULL,
    CONSTRAINT room_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: reservation_guest (table: reservation)
ALTER TABLE reservation ADD CONSTRAINT reservation_guest
    FOREIGN KEY (guest_id)
    REFERENCES guest (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: reserved_room_reservation (table: reserved_room)
ALTER TABLE reserved_room ADD CONSTRAINT reserved_room_reservation
    FOREIGN KEY (reservation_id)
    REFERENCES reservation (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.


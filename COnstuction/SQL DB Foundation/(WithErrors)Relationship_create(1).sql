-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:25:25.902

-- tables
-- Table: organization
CREATE TABLE organization (
    org_name varchar(%)  NOT NULL
);

-- Table: party
CREATE TABLE party (
    party_ref varchar(%)  NOT NULL
);

-- Table: person
CREATE TABLE person (
    given_name varchar(%)  NOT NULL,
    family_name varchar(%)  NOT NULL,
    date_of_birth date  NOT NULL,
    date_of_retirement date  NOT NULL,
    date_of_death date  NOT NULL
);

-- Table: relationship
CREATE TABLE relationship (
    relationship_ref varchar(%)  NOT NULL,
    effective_from date  NOT NULL,
    effective_to date  NOT NULL
);

-- foreign keys
-- Reference: party_organization (table: party)
ALTER TABLE party ADD CONSTRAINT party_organization
    FOREIGN KEY ()
    REFERENCES organization ()  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: party_person (table: party)
ALTER TABLE party ADD CONSTRAINT party_person
    FOREIGN KEY ()
    REFERENCES person ()  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: relationship_party (table: relationship)
ALTER TABLE relationship ADD CONSTRAINT relationship_party
    FOREIGN KEY ()
    REFERENCES party ()  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: relationship_party (table: relationship)
ALTER TABLE relationship ADD CONSTRAINT relationship_party
    FOREIGN KEY ()
    REFERENCES party ()  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.


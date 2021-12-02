-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:33:19.735

-- tables
-- Table: attend
CREATE TABLE attend (
    id int NOT NULL AUTO_INCREMENT,
    student_id int NOT NULL,
    class_id int NOT NULL,
    class_enrollment_date date NOT NULL COMMENT 'date when student started attending course',
    class_drop_date date NULL COMMENT 'date (if exists) when student dropped class',
    drop_class_reason_id int NULL,
    attendance_outcome_id int NOT NULL COMMENT 'must be filled (in progress, finished partially, ...)',
    CONSTRAINT attend_pk PRIMARY KEY (id)
);

-- Table: attendance_outcome
CREATE TABLE attendance_outcome (
    id int NOT NULL AUTO_INCREMENT,
    outcome_text varchar(256) NOT NULL,
    CONSTRAINT attendance_outcome_pk PRIMARY KEY (id)
);

-- Table: category
CREATE TABLE category (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(128) NOT NULL,
    CONSTRAINT category_pk PRIMARY KEY (id)
);

-- Table: class
CREATE TABLE class (
    id int NOT NULL AUTO_INCREMENT,
    class_type_id int NOT NULL,
    name varchar(128) NOT NULL,
    description varchar(512) NOT NULL,
    start_date date NOT NULL,
    end_date date NULL COMMENT 'maybe we''''ll have classes where we can''''t know in advance when they will end',
    completed bool NOT NULL,
    CONSTRAINT class_pk PRIMARY KEY (id)
);

-- Table: class_schedule
CREATE TABLE class_schedule (
    id int NOT NULL AUTO_INCREMENT,
    class_id int NOT NULL,
    start_time timestamp NOT NULL,
    end_time timestamp NOT NULL,
    CONSTRAINT class_schedule_pk PRIMARY KEY (id)
);

-- Table: class_type
CREATE TABLE class_type (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(128) NOT NULL,
    description varchar(512) NOT NULL,
    CONSTRAINT class_type_pk PRIMARY KEY (id)
);

-- Table: contact_person
CREATE TABLE contact_person (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(128) NOT NULL,
    last_name varchar(128) NOT NULL,
    contact_phone varchar(128) NULL,
    contact_mobile varchar(128) NULL,
    contact_mail varchar(256) NULL,
    CONSTRAINT contact_person_pk PRIMARY KEY (id)
);

-- Table: contact_person_student
CREATE TABLE contact_person_student (
    id int NOT NULL AUTO_INCREMENT,
    contact_person_id int NOT NULL,
    student_id int NOT NULL,
    contact_person_type_id int NOT NULL,
    UNIQUE INDEX parent_student_ak_1 (contact_person_id,student_id),
    CONSTRAINT contact_person_student_pk PRIMARY KEY (id)
);

-- Table: contact_person_type
CREATE TABLE contact_person_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(128) NOT NULL,
    CONSTRAINT contact_person_type_pk PRIMARY KEY (id)
) COMMENT 'mother, father, grandmother, grandfather...';

-- Table: drop_attendance_reason
CREATE TABLE drop_attendance_reason (
    id int NOT NULL AUTO_INCREMENT,
    reason_text varchar(256) NOT NULL,
    CONSTRAINT drop_attendance_reason_pk PRIMARY KEY (id)
);

-- Table: drop_teach_reason
CREATE TABLE drop_teach_reason (
    id int NOT NULL AUTO_INCREMENT,
    reason_text varchar(256) NOT NULL,
    CONSTRAINT drop_teach_reason_pk PRIMARY KEY (id)
);

-- Table: instructor
CREATE TABLE instructor (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(128) NOT NULL,
    last_name varchar(128) NOT NULL,
    title varchar(64) NULL,
    birth_date date NOT NULL,
    contact_phone varchar(128) NULL,
    contact_mobile varchar(128) NULL,
    contact_mail varchar(128) NULL,
    CONSTRAINT instructor_pk PRIMARY KEY (id)
);

-- Table: instructor_presence
CREATE TABLE instructor_presence (
    instructor_id int NOT NULL,
    class_schedule_id int NOT NULL,
    present bool NOT NULL,
    CONSTRAINT instructor_presence_pk PRIMARY KEY (instructor_id,class_schedule_id)
);

-- Table: student
CREATE TABLE student (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(128) NOT NULL,
    last_name varchar(128) NOT NULL,
    birth_date date NOT NULL,
    category_id int NULL,
    contact_phone varchar(128) NULL,
    contact_mobile varchar(128) NULL,
    contact_mail varchar(256) NULL,
    CONSTRAINT student_pk PRIMARY KEY (id)
);

-- Table: student_presence
CREATE TABLE student_presence (
    student_id int NOT NULL,
    class_schedule_id int NOT NULL,
    present bool NOT NULL,
    CONSTRAINT student_presence_pk PRIMARY KEY (student_id,class_schedule_id)
);

-- Table: teach
CREATE TABLE teach (
    id int NOT NULL AUTO_INCREMENT,
    instructor_id int NOT NULL,
    class_id int NOT NULL,
    start_date date NOT NULL,
    end_date date NULL,
    drop_teach_reason_id int NULL,
    teach_outcome_id int NOT NULL COMMENT 'must be filled (in progress, finished partially, ...)',
    CONSTRAINT teach_pk PRIMARY KEY (id)
);

-- Table: teach_outcome
CREATE TABLE teach_outcome (
    id int NOT NULL AUTO_INCREMENT,
    outcome_text varchar(256) NOT NULL,
    CONSTRAINT teach_outcome_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: attend_attendance_outcome (table: attend)
ALTER TABLE attend ADD CONSTRAINT attend_attendance_outcome FOREIGN KEY attend_attendance_outcome (attendance_outcome_id)
    REFERENCES attendance_outcome (id);

-- Reference: attend_class (table: attend)
ALTER TABLE attend ADD CONSTRAINT attend_class FOREIGN KEY attend_class (class_id)
    REFERENCES class (id);

-- Reference: attend_drop_class_reason (table: attend)
ALTER TABLE attend ADD CONSTRAINT attend_drop_class_reason FOREIGN KEY attend_drop_class_reason (drop_class_reason_id)
    REFERENCES drop_attendance_reason (id);

-- Reference: attend_student (table: attend)
ALTER TABLE attend ADD CONSTRAINT attend_student FOREIGN KEY attend_student (student_id)
    REFERENCES student (id);

-- Reference: class_class_type (table: class)
ALTER TABLE class ADD CONSTRAINT class_class_type FOREIGN KEY class_class_type (class_type_id)
    REFERENCES class_type (id);

-- Reference: class_schedule_class (table: class_schedule)
ALTER TABLE class_schedule ADD CONSTRAINT class_schedule_class FOREIGN KEY class_schedule_class (class_id)
    REFERENCES class (id);

-- Reference: instructor_presence_class_schedule (table: instructor_presence)
ALTER TABLE instructor_presence ADD CONSTRAINT instructor_presence_class_schedule FOREIGN KEY instructor_presence_class_schedule (class_schedule_id)
    REFERENCES class_schedule (id);

-- Reference: instructor_presence_instructor (table: instructor_presence)
ALTER TABLE instructor_presence ADD CONSTRAINT instructor_presence_instructor FOREIGN KEY instructor_presence_instructor (instructor_id)
    REFERENCES instructor (id);

-- Reference: parent_student_contact_person_type (table: contact_person_student)
ALTER TABLE contact_person_student ADD CONSTRAINT parent_student_contact_person_type FOREIGN KEY parent_student_contact_person_type (contact_person_type_id)
    REFERENCES contact_person_type (id);

-- Reference: parent_student_parent (table: contact_person_student)
ALTER TABLE contact_person_student ADD CONSTRAINT parent_student_parent FOREIGN KEY parent_student_parent (contact_person_id)
    REFERENCES contact_person (id);

-- Reference: parent_student_student (table: contact_person_student)
ALTER TABLE contact_person_student ADD CONSTRAINT parent_student_student FOREIGN KEY parent_student_student (student_id)
    REFERENCES student (id);

-- Reference: student_category (table: student)
ALTER TABLE student ADD CONSTRAINT student_category FOREIGN KEY student_category (category_id)
    REFERENCES category (id);

-- Reference: student_presence_class_schedule (table: student_presence)
ALTER TABLE student_presence ADD CONSTRAINT student_presence_class_schedule FOREIGN KEY student_presence_class_schedule (class_schedule_id)
    REFERENCES class_schedule (id);

-- Reference: student_presence_student (table: student_presence)
ALTER TABLE student_presence ADD CONSTRAINT student_presence_student FOREIGN KEY student_presence_student (student_id)
    REFERENCES student (id);

-- Reference: teach_class (table: teach)
ALTER TABLE teach ADD CONSTRAINT teach_class FOREIGN KEY teach_class (class_id)
    REFERENCES class (id);

-- Reference: teach_drop_teach_reason (table: teach)
ALTER TABLE teach ADD CONSTRAINT teach_drop_teach_reason FOREIGN KEY teach_drop_teach_reason (drop_teach_reason_id)
    REFERENCES drop_teach_reason (id);

-- Reference: teach_instructor (table: teach)
ALTER TABLE teach ADD CONSTRAINT teach_instructor FOREIGN KEY teach_instructor (instructor_id)
    REFERENCES instructor (id);

-- Reference: teach_teach_outcome (table: teach)
ALTER TABLE teach ADD CONSTRAINT teach_teach_outcome FOREIGN KEY teach_teach_outcome (teach_outcome_id)
    REFERENCES teach_outcome (id);

-- End of file.


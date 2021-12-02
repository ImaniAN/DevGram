-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:58:53.691

-- tables
-- Table: address
CREATE TABLE address (
    id number NOT NULL,
    street_address varchar2(500) NOT NULL,
    city varchar2(50) NOT NULL,
    state varchar2(50) NOT NULL,
    country varchar2(50) NOT NULL,
    zip varchar2(10) NOT NULL,
    CONSTRAINT address_pk PRIMARY KEY (id)
);

-- Table: exp_level_teach_teacher
CREATE TABLE exp_level_teach_teacher (
    teacher_id number NOT NULL,
    experience_level_to_teach_id number NOT NULL,
    CONSTRAINT exp_level_teach_teacher_pk PRIMARY KEY (teacher_id,experience_level_to_teach_id)
);

-- Table: experience_level_to_teach
CREATE TABLE experience_level_to_teach (
    id number NOT NULL,
    exp_level varchar2(100) NOT NULL,
    CONSTRAINT experience_level_to_teach_pk PRIMARY KEY (id)
);

-- Table: lesson_category
CREATE TABLE lesson_category (
    id number NOT NULL,
    category_name varchar2(50) NOT NULL,
    CONSTRAINT lesson_category_pk PRIMARY KEY (id)
);

-- Table: lesson_subsciption
CREATE TABLE lesson_subsciption (
    id number NOT NULL,
    student_id number NOT NULL,
    recorded_lesson_id number NOT NULL,
    subscription_date date NOT NULL,
    is_lifetime_subscription char(1) NOT NULL,
    subscription_expiring_on date NULL,
    CONSTRAINT lesson_subsciption_pk PRIMARY KEY (id)
);

-- Table: recorded_lesson
CREATE TABLE recorded_lesson (
    id number NOT NULL,
    subject varchar2(100) NOT NULL,
    lesson_category_id number NOT NULL,
    teacher_id number NOT NULL,
    lesson_description varchar2(4000) NOT NULL,
    video_location varchar2(2000) NOT NULL,
    lesson_transcript clob NULL,
    cost_to_subscribe number NOT NULL,
    CONSTRAINT recorded_lesson_pk PRIMARY KEY (id)
);

-- Table: student
CREATE TABLE student (
    id number NOT NULL,
    first_name varchar2(50) NOT NULL,
    last_name varchar2(50) NOT NULL,
    gender char(1) NOT NULL,
    date_of_birth date NOT NULL,
    email varchar2(50) NOT NULL,
    contact_number varchar2(10) NOT NULL,
    CONSTRAINT student_pk PRIMARY KEY (id)
);

-- Table: student_comfortability
CREATE TABLE student_comfortability (
    id number NOT NULL,
    teacher_id number NOT NULL,
    gender char(1) NOT NULL,
    starting_age number NOT NULL,
    age_upto number NOT NULL,
    CONSTRAINT student_comfortability_pk PRIMARY KEY (id)
);

-- Table: teacher
CREATE TABLE teacher (
    id number NOT NULL,
    first_name varchar2(50) NOT NULL,
    last_name varchar2(50) NOT NULL,
    gender char(1) NOT NULL,
    date_of_birth date NOT NULL,
    email varchar2(255) NOT NULL,
    mobile_number varchar2(10) NOT NULL,
    alternate_contact_number varchar2(10) NOT NULL,
    max_travel_distance number NOT NULL,
    cost_to_travel number NOT NULL,
    profile_image blob NULL,
    teaching_since date NOT NULL,
    brief_description varchar2(4000) NOT NULL,
    timezone_id number NOT NULL,
    CONSTRAINT teacher_pk PRIMARY KEY (id)
);

-- Table: teacher_availability
CREATE TABLE teacher_availability (
    id number NOT NULL,
    teacher_id number NOT NULL,
    start_date_time timestamp NOT NULL,
    duration_in_min number NOT NULL,
    CONSTRAINT teacher_availability_pk PRIMARY KEY (id)
);

-- Table: teacher_earning
CREATE TABLE teacher_earning (
    teacher_id number NOT NULL,
    cost_for_30minutes number NOT NULL,
    cost_for_60minutes number NOT NULL,
    cost_for_90minutes number NOT NULL,
    cost_for_120minutes number NOT NULL,
    CONSTRAINT teacher_earning_pk PRIMARY KEY (teacher_id)
);

-- Table: teacher_reservation
CREATE TABLE teacher_reservation (
    id number NOT NULL,
    student_id number NOT NULL,
    teacher_id number NOT NULL,
    teacher_availability_id number NOT NULL,
    teacher_teaching_location_id number NOT NULL,
    CONSTRAINT teacher_reservation_pk PRIMARY KEY (id)
);

-- Table: teacher_teaching_location
CREATE TABLE teacher_teaching_location (
    id number NOT NULL,
    teacher_id number NOT NULL,
    teaching_location_type_id number NOT NULL,
    address_id number NULL,
    CONSTRAINT teacher_teaching_location_pk PRIMARY KEY (id)
);

-- Table: teaching_location_type
CREATE TABLE teaching_location_type (
    id number NOT NULL,
    teaching_loc_type_name varchar2(50) NOT NULL,
    CONSTRAINT teaching_location_type_pk PRIMARY KEY (id)
);

-- Table: timezone
CREATE TABLE timezone (
    id number NOT NULL,
    timezone_name varchar2(100) NOT NULL,
    time_difference_in_minutes number NOT NULL,
    is_positive_negative char(1) NOT NULL,
    CONSTRAINT timezone_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: Table_8_teacher (table: teacher_availability)
ALTER TABLE teacher_availability ADD CONSTRAINT Table_8_teacher FOREIGN KEY Table_8_teacher (teacher_id)
    REFERENCES teacher (id);

-- Reference: exp_level_teach_tchr_tchr (table: exp_level_teach_teacher)
ALTER TABLE exp_level_teach_teacher ADD CONSTRAINT exp_level_teach_tchr_tchr FOREIGN KEY exp_level_teach_tchr_tchr (teacher_id)
    REFERENCES teacher (id);

-- Reference: exp_level_teach_teacher_exp (table: exp_level_teach_teacher)
ALTER TABLE exp_level_teach_teacher ADD CONSTRAINT exp_level_teach_teacher_exp FOREIGN KEY exp_level_teach_teacher_exp (experience_level_to_teach_id)
    REFERENCES experience_level_to_teach (id);

-- Reference: lesson_subsciption_student (table: lesson_subsciption)
ALTER TABLE lesson_subsciption ADD CONSTRAINT lesson_subsciption_student FOREIGN KEY lesson_subsciption_student (student_id)
    REFERENCES student (id);

-- Reference: lsn_subs_rec_lesson (table: lesson_subsciption)
ALTER TABLE lesson_subsciption ADD CONSTRAINT lsn_subs_rec_lesson FOREIGN KEY lsn_subs_rec_lesson (recorded_lesson_id)
    REFERENCES recorded_lesson (id);

-- Reference: rec_lesson_lesson_cat (table: recorded_lesson)
ALTER TABLE recorded_lesson ADD CONSTRAINT rec_lesson_lesson_cat FOREIGN KEY rec_lesson_lesson_cat (lesson_category_id)
    REFERENCES lesson_category (id);

-- Reference: recorded_lesson_teacher (table: recorded_lesson)
ALTER TABLE recorded_lesson ADD CONSTRAINT recorded_lesson_teacher FOREIGN KEY recorded_lesson_teacher (teacher_id)
    REFERENCES teacher (id);

-- Reference: student_comfortability_teacher (table: student_comfortability)
ALTER TABLE student_comfortability ADD CONSTRAINT student_comfortability_teacher FOREIGN KEY student_comfortability_teacher (teacher_id)
    REFERENCES teacher (id);

-- Reference: tchr_resrv_tchr_availability (table: teacher_reservation)
ALTER TABLE teacher_reservation ADD CONSTRAINT tchr_resrv_tchr_availability FOREIGN KEY tchr_resrv_tchr_availability (teacher_availability_id)
    REFERENCES teacher_availability (id);

-- Reference: tchr_resrv_tchr_teaching_loc (table: teacher_reservation)
ALTER TABLE teacher_reservation ADD CONSTRAINT tchr_resrv_tchr_teaching_loc FOREIGN KEY tchr_resrv_tchr_teaching_loc (teacher_teaching_location_id)
    REFERENCES teacher_teaching_location (id);

-- Reference: tchr_teaching_loc_tchr (table: teacher_teaching_location)
ALTER TABLE teacher_teaching_location ADD CONSTRAINT tchr_teaching_loc_tchr FOREIGN KEY tchr_teaching_loc_tchr (teacher_id)
    REFERENCES teacher (id);

-- Reference: tchr_teaching_loc_teaching_loc (table: teacher_teaching_location)
ALTER TABLE teacher_teaching_location ADD CONSTRAINT tchr_teaching_loc_teaching_loc FOREIGN KEY tchr_teaching_loc_teaching_loc (teaching_location_type_id)
    REFERENCES teaching_location_type (id);

-- Reference: teacher_earning_teacher (table: teacher_earning)
ALTER TABLE teacher_earning ADD CONSTRAINT teacher_earning_teacher FOREIGN KEY teacher_earning_teacher (teacher_id)
    REFERENCES teacher (id);

-- Reference: teacher_reservation_student (table: teacher_reservation)
ALTER TABLE teacher_reservation ADD CONSTRAINT teacher_reservation_student FOREIGN KEY teacher_reservation_student (student_id)
    REFERENCES student (id);

-- Reference: teacher_reservation_teacher (table: teacher_reservation)
ALTER TABLE teacher_reservation ADD CONSTRAINT teacher_reservation_teacher FOREIGN KEY teacher_reservation_teacher (teacher_id)
    REFERENCES teacher (id);

-- Reference: teacher_teaching_loc_addr (table: teacher_teaching_location)
ALTER TABLE teacher_teaching_location ADD CONSTRAINT teacher_teaching_loc_addr FOREIGN KEY teacher_teaching_loc_addr (address_id)
    REFERENCES address (id);

-- Reference: teacher_timezone (table: teacher)
ALTER TABLE teacher ADD CONSTRAINT teacher_timezone FOREIGN KEY teacher_timezone (timezone_id)
    REFERENCES timezone (id);

-- End of file.


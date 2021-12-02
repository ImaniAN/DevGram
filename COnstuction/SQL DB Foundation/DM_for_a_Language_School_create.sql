-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:02:33.016

-- tables
-- Table: category
CREATE TABLE category (
    id int  NOT NULL,
    name varchar(20)  NOT NULL,
    CONSTRAINT category_pk PRIMARY KEY  (id)
);

-- Table: class
CREATE TABLE class (
    id int  NOT NULL,
    name varchar(100)  NOT NULL,
    start_date date  NOT NULL,
    end_date date  NOT NULL,
    price money  NOT NULL,
    teacher_id int  NOT NULL,
    course_id int  NOT NULL,
    CONSTRAINT class_pk PRIMARY KEY  (id)
);

-- Table: class_student
CREATE TABLE class_student (
    id int  NOT NULL,
    class_id int  NOT NULL,
    student_id int  NOT NULL,
    CONSTRAINT Group_student_id PRIMARY KEY  (id)
);

-- Table: class_weekday
CREATE TABLE class_weekday (
    class_id int  NOT NULL,
    weekday_id int  NOT NULL,
    hours varchar(50)  NOT NULL,
    CONSTRAINT Group_Day_pk PRIMARY KEY  (class_id,weekday_id)
);

-- Table: course
CREATE TABLE course (
    id int  NOT NULL,
    lessons int  NOT NULL,
    description varchar(300)  NOT NULL,
    term varchar(100)  NOT NULL,
    language_id int  NOT NULL,
    level_id int  NOT NULL,
    category_id int  NOT NULL,
    CONSTRAINT course_pk PRIMARY KEY  (id)
);

-- Table: language
CREATE TABLE language (
    id int  NOT NULL,
    name varchar(100)  NOT NULL,
    CONSTRAINT language_pk PRIMARY KEY  (id)
);

-- Table: level
CREATE TABLE level (
    id int  NOT NULL,
    sign char(2)  NOT NULL,
    name varchar(100)  NOT NULL,
    CONSTRAINT level_pk PRIMARY KEY  (id)
);

-- Table: payment
CREATE TABLE payment (
    id int  NOT NULL,
    payment_date datetime  NOT NULL,
    amount money  NOT NULL,
    payment_method_id int  NOT NULL,
    status varchar(50)  NOT NULL,
    student_id int  NOT NULL,
    class_id int  NOT NULL,
    CONSTRAINT payment_pk PRIMARY KEY  (id)
);

-- Table: payment_method
CREATE TABLE payment_method (
    id int  NOT NULL,
    name varchar(100)  NOT NULL,
    CONSTRAINT payment_method_pk PRIMARY KEY  (id)
);

-- Table: staff
CREATE TABLE staff (
    id int  NOT NULL,
    position varchar(120)  NOT NULL,
    first_name varchar(50)  NOT NULL,
    last_name varchar(50)  NOT NULL,
    email varchar(50)  NOT NULL,
    phone varchar(15)  NOT NULL,
    CONSTRAINT staff_pk PRIMARY KEY  (id)
);

-- Table: staff_account
CREATE TABLE staff_account (
    id int  NOT NULL,
    is_active bit  NOT NULL,
    login varchar(100)  NOT NULL,
    password varchar(100)  NOT NULL,
    staff_id int  NOT NULL,
    CONSTRAINT staff_account_pk PRIMARY KEY  (id)
);

-- Table: student
CREATE TABLE student (
    id int  NOT NULL,
    date_birth date  NOT NULL,
    state varchar(150)  NOT NULL,
    city varchar(100)  NOT NULL,
    zip_code char(10)  NOT NULL,
    street varchar(100)  NOT NULL,
    first_name varchar(50)  NOT NULL,
    last_name varchar(50)  NOT NULL,
    email varchar(50)  NOT NULL,
    phone varchar(15)  NOT NULL,
    CONSTRAINT student_pk PRIMARY KEY  (id)
);

-- Table: student_account
CREATE TABLE student_account (
    id int  NOT NULL,
    student_id int  NOT NULL,
    is_active bit  NOT NULL,
    login varchar(100)  NOT NULL,
    password varchar(100)  NOT NULL,
    CONSTRAINT student_account_pk PRIMARY KEY  (id)
);

-- Table: teacher
CREATE TABLE teacher (
    id int  NOT NULL,
    description varchar(300)  NOT NULL,
    photo image  NULL,
    first_name varchar(50)  NOT NULL,
    last_name varchar(50)  NOT NULL,
    email varchar(50)  NOT NULL,
    phone varchar(15)  NOT NULL,
    CONSTRAINT teacher_pk PRIMARY KEY  (id)
);

-- Table: teacher_account
CREATE TABLE teacher_account (
    id int  NOT NULL,
    teacher_id int  NOT NULL,
    is_active bit  NOT NULL,
    login varchar(100)  NOT NULL,
    password varchar(100)  NOT NULL,
    CONSTRAINT teacher_account_pk PRIMARY KEY  (id)
);

-- Table: weekday
CREATE TABLE weekday (
    id int  NOT NULL,
    name varchar(100)  NOT NULL,
    CONSTRAINT weekday_pk PRIMARY KEY  (id)
);

-- foreign keys
-- Reference: class_course (table: class)
ALTER TABLE class ADD CONSTRAINT class_course
    FOREIGN KEY (course_id)
    REFERENCES course (id);

-- Reference: course_category (table: course)
ALTER TABLE course ADD CONSTRAINT course_category
    FOREIGN KEY (category_id)
    REFERENCES category (id);

-- Reference: course_language (table: course)
ALTER TABLE course ADD CONSTRAINT course_language
    FOREIGN KEY (language_id)
    REFERENCES language (id);

-- Reference: course_level (table: course)
ALTER TABLE course ADD CONSTRAINT course_level
    FOREIGN KEY (level_id)
    REFERENCES level (id);

-- Reference: group_day_day (table: class_weekday)
ALTER TABLE class_weekday ADD CONSTRAINT group_day_day
    FOREIGN KEY (weekday_id)
    REFERENCES weekday (id);

-- Reference: group_day_group (table: class_weekday)
ALTER TABLE class_weekday ADD CONSTRAINT group_day_group
    FOREIGN KEY (class_id)
    REFERENCES class (id);

-- Reference: group_student_group (table: class_student)
ALTER TABLE class_student ADD CONSTRAINT group_student_group
    FOREIGN KEY (class_id)
    REFERENCES class (id);

-- Reference: group_student_student (table: class_student)
ALTER TABLE class_student ADD CONSTRAINT group_student_student
    FOREIGN KEY (student_id)
    REFERENCES student (id);

-- Reference: group_teacher (table: class)
ALTER TABLE class ADD CONSTRAINT group_teacher
    FOREIGN KEY (teacher_id)
    REFERENCES teacher (id);

-- Reference: payment_class (table: payment)
ALTER TABLE payment ADD CONSTRAINT payment_class
    FOREIGN KEY (class_id)
    REFERENCES class (id);

-- Reference: payment_payment_type (table: payment)
ALTER TABLE payment ADD CONSTRAINT payment_payment_type
    FOREIGN KEY (payment_method_id)
    REFERENCES payment_method (id);

-- Reference: payment_student (table: payment)
ALTER TABLE payment ADD CONSTRAINT payment_student
    FOREIGN KEY (student_id)
    REFERENCES student (id);

-- Reference: staff_account_staff (table: staff_account)
ALTER TABLE staff_account ADD CONSTRAINT staff_account_staff
    FOREIGN KEY (staff_id)
    REFERENCES staff (id);

-- Reference: student_user_account_student (table: student_account)
ALTER TABLE student_account ADD CONSTRAINT student_user_account_student
    FOREIGN KEY (student_id)
    REFERENCES student (id);

-- Reference: teacher_user_account_teacher (table: teacher_account)
ALTER TABLE teacher_account ADD CONSTRAINT teacher_user_account_teacher
    FOREIGN KEY (teacher_id)
    REFERENCES teacher (id);

-- End of file.


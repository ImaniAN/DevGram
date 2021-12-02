-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:02:51.307

-- tables
-- Table: content_type
CREATE TABLE content_type (
    id number  NOT NULL,
    content_type varchar2(20)  NOT NULL,
    CONSTRAINT content_type_pk PRIMARY KEY (id)
) ;

-- Table: course
CREATE TABLE course (
    id number  NOT NULL,
    course_title varchar2(200)  NOT NULL,
    course_brief varchar2(4000)  NOT NULL,
    instructor_id number  NOT NULL,
    num_of_chapters number  NOT NULL,
    course_fee number  NOT NULL,
    language_id number  NOT NULL,
    CONSTRAINT course_pk PRIMARY KEY (id)
) ;

-- Table: course_chapter
CREATE TABLE course_chapter (
    id number  NOT NULL,
    course_id number  NOT NULL,
    chapter_title varchar2(100)  NOT NULL,
    num_of_reading number  NOT NULL,
    num_of_video number  NOT NULL,
    num_of_assignment number  NOT NULL,
    CONSTRAINT course_chapter_pk PRIMARY KEY (id)
) ;

-- Table: course_chapter_content
CREATE TABLE course_chapter_content (
    id number  NOT NULL,
    course_chapter_id number  NOT NULL,
    content_type_id number  NOT NULL,
    is_mandatory char(1)  NOT NULL,
    time_required_in_sec number  NOT NULL,
    is_open_for_free char(1)  NOT NULL,
    CONSTRAINT course_chapter_content_pk PRIMARY KEY (id)
) ;

-- Table: enrollment
CREATE TABLE enrollment (
    id number  NOT NULL,
    student_id number  NOT NULL,
    course_id number  NOT NULL,
    enrollment_date date  NOT NULL,
    is_paid_subscription char(1)  NOT NULL,
    CONSTRAINT enrollment_pk PRIMARY KEY (id)
) ;

-- Table: feedback
CREATE TABLE feedback (
    id number  NOT NULL,
    enrollment_id number  NOT NULL,
    rating_score number  NOT NULL,
    feedback_text varchar2(4000)  NULL,
    submission_date date  NOT NULL,
    CONSTRAINT feedback_pk PRIMARY KEY (id)
) ;

-- Table: instructor
CREATE TABLE instructor (
    id number  NOT NULL,
    first_name varchar2(50)  NOT NULL,
    last_name varchar2(50)  NOT NULL,
    email varchar2(50)  NOT NULL,
    registration_date date  NOT NULL,
    qualification varchar2(200)  NOT NULL,
    introduction_brief varchar2(1000)  NOT NULL,
    image blob  NOT NULL,
    num_of_published_courses number  NOT NULL,
    num_of_enrolled_students number  NOT NULL,
    average_review_rating number  NOT NULL,
    num_of_reviews number  NOT NULL,
    CONSTRAINT instructor_pk PRIMARY KEY (id)
) ;

-- Table: language
CREATE TABLE language (
    id number  NOT NULL,
    language_name varchar2(50)  NOT NULL,
    CONSTRAINT language_pk PRIMARY KEY (id)
) ;

-- Table: learning_progress
CREATE TABLE learning_progress (
    id number  NOT NULL,
    enrollment_id number  NOT NULL,
    course_chapter_content_id number  NOT NULL,
    begin_timestamp timestamp  NOT NULL,
    completion_timestamp timestamp  NOT NULL,
    status char(1)  NOT NULL,
    CONSTRAINT learning_progress_pk PRIMARY KEY (id)
) ;

-- Table: student
CREATE TABLE student (
    id number  NOT NULL,
    first_name varchar2(100)  NULL,
    last_name varchar2(100)  NOT NULL,
    email varchar2(255)  NOT NULL,
    registration_date date  NOT NULL,
    num_of_courses_enrolled number  NOT NULL,
    num_of_courses_completed number  NOT NULL,
    CONSTRAINT student_pk PRIMARY KEY (id)
) ;

-- foreign keys
-- Reference: course_chapter_cnt_cnt_type (table: course_chapter_content)
ALTER TABLE course_chapter_content ADD CONSTRAINT course_chapter_cnt_cnt_type
    FOREIGN KEY (content_type_id)
    REFERENCES content_type (id);

-- Reference: course_chapter_cnt_crs_chapter (table: course_chapter_content)
ALTER TABLE course_chapter_content ADD CONSTRAINT course_chapter_cnt_crs_chapter
    FOREIGN KEY (course_chapter_id)
    REFERENCES course_chapter (id);

-- Reference: course_content_course (table: course_chapter)
ALTER TABLE course_chapter ADD CONSTRAINT course_content_course
    FOREIGN KEY (course_id)
    REFERENCES course (id);

-- Reference: course_instructor (table: course)
ALTER TABLE course ADD CONSTRAINT course_instructor
    FOREIGN KEY (instructor_id)
    REFERENCES instructor (id);

-- Reference: course_language (table: course)
ALTER TABLE course ADD CONSTRAINT course_language
    FOREIGN KEY (language_id)
    REFERENCES language (id);

-- Reference: enrollment_course (table: enrollment)
ALTER TABLE enrollment ADD CONSTRAINT enrollment_course
    FOREIGN KEY (course_id)
    REFERENCES course (id);

-- Reference: enrollment_student (table: enrollment)
ALTER TABLE enrollment ADD CONSTRAINT enrollment_student
    FOREIGN KEY (student_id)
    REFERENCES student (id);

-- Reference: feedback_enrollment (table: feedback)
ALTER TABLE feedback ADD CONSTRAINT feedback_enrollment
    FOREIGN KEY (enrollment_id)
    REFERENCES enrollment (id);

-- Reference: learning_prgs_crs_chapter_cnt (table: learning_progress)
ALTER TABLE learning_progress ADD CONSTRAINT learning_prgs_crs_chapter_cnt
    FOREIGN KEY (course_chapter_content_id)
    REFERENCES course_chapter_content (id);

-- Reference: learning_progress_enrollment (table: learning_progress)
ALTER TABLE learning_progress ADD CONSTRAINT learning_progress_enrollment
    FOREIGN KEY (enrollment_id)
    REFERENCES enrollment (id);

-- End of file.


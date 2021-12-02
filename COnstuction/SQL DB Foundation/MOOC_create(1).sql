-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:17:57.247

-- tables
-- Table: chapter
CREATE TABLE chapter (
    id int NOT NULL AUTO_INCREMENT,
    course_id int NOT NULL,
    chapter_no int NOT NULL COMMENT 'chapter ordinal number in course',
    description text NOT NULL,
    UNIQUE INDEX chapter_ak_1 (course_id,chapter_no),
    CONSTRAINT chapter_pk PRIMARY KEY (id)
) COMMENT 'chapters or usually weeks';

-- Table: course
CREATE TABLE course (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    commitment varchar(255) NOT NULL COMMENT 'expected commitment - description',
    description text NOT NULL COMMENT 'course description',
    specialization_id int NULL COMMENT 'minimal grade student has to achieve to pass the course',
    min_grade decimal(5,2) NOT NULL,
    course_price decimal(8,2) NOT NULL,
    active bool NOT NULL,
    UNIQUE INDEX course_ak_1 (name),
    CONSTRAINT course_pk PRIMARY KEY (id)
);

-- Table: course_created_by
CREATE TABLE course_created_by (
    id int NOT NULL AUTO_INCREMENT,
    institution_id int NOT NULL,
    course_id int NOT NULL,
    UNIQUE INDEX course_created_by_ak_1 (institution_id,course_id),
    CONSTRAINT course_created_by_pk PRIMARY KEY (id)
);

-- Table: course_session
CREATE TABLE course_session (
    id int NOT NULL AUTO_INCREMENT,
    course_id int NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    specialization_session_id int NULL,
    UNIQUE INDEX course_session_ak_1 (course_id,start_date),
    CONSTRAINT course_session_pk PRIMARY KEY (id)
) COMMENT 'different sessions of same course - each with different date';

-- Table: enrolled_course
CREATE TABLE enrolled_course (
    id int NOT NULL AUTO_INCREMENT,
    student_id int NOT NULL,
    course_session_id int NOT NULL,
    enrollment_date date NOT NULL,
    status_id int NULL,
    status_date date NULL,
    final_grade decimal(5,2) NULL COMMENT 'contains value if student completed course',
    certificate_ID text NULL COMMENT 'if final_grade > min_grade (for course) certificate exists',
    certificate_location text NULL COMMENT 'if final_grade > min_grade (for course) certificate exists',
    UNIQUE INDEX enrolled_course_ak_1 (student_id,course_session_id),
    CONSTRAINT enrolled_course_pk PRIMARY KEY (id)
);

-- Table: enrolled_specialization
CREATE TABLE enrolled_specialization (
    id int NOT NULL AUTO_INCREMENT,
    student_id int NOT NULL,
    specialization_session_id int NOT NULL,
    enrollment_date date NOT NULL,
    status_id int NULL,
    status_date date NULL,
    final_grade decimal(5,2) NULL COMMENT 'contains value if student completed course',
    certificate_ID text NULL COMMENT 'if student passed all courses in specialization -> certificate exists',
    certificate_location text NULL COMMENT 'if student passed all courses in specialization -> certificate exists',
    UNIQUE INDEX enrolled_specialization_ak_1 (student_id,specialization_session_id),
    CONSTRAINT enrolled_specialization_pk PRIMARY KEY (id)
);

-- Table: institution
CREATE TABLE institution (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    location varchar(255) NOT NULL,
    CONSTRAINT institution_pk PRIMARY KEY (id)
) COMMENT 'list of all institutions that specializations, courses and lecturers belong to';

-- Table: lecturer
CREATE TABLE lecturer (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    title varchar(32) NOT NULL,
    institution_id int NOT NULL,
    CONSTRAINT lecturer_pk PRIMARY KEY (id)
);

-- Table: material
CREATE TABLE material (
    id int NOT NULL,
    chapter_id int NOT NULL,
    material_no int NOT NULL COMMENT 'material ordinal number in chapter',
    material_type_id int NOT NULL,
    material_link text NOT NULL COMMENT 'link to location with video, test etc.',
    mandatroy bool NOT NULL COMMENT 'is this material mandatory to pass the course',
    max_points int NOT NULL COMMENT 'max. points that student can earn when he complete material (0 if material does not provide any points)',
    UNIQUE INDEX material_ak_1 (chapter_id,material_no),
    CONSTRAINT material_pk PRIMARY KEY (id)
) COMMENT 'video lecture, reading, test';

-- Table: material_type
CREATE TABLE material_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(64) NOT NULL,
    UNIQUE INDEX material_type_ak_1 (type_name),
    CONSTRAINT material_type_pk PRIMARY KEY (id)
);

-- Table: on_course
CREATE TABLE on_course (
    id int NOT NULL AUTO_INCREMENT,
    lecturer_id int NOT NULL,
    course_id int NOT NULL,
    UNIQUE INDEX on_course_ak_1 (lecturer_id,course_id),
    CONSTRAINT on_course_pk PRIMARY KEY (id)
);

-- Table: on_specialization
CREATE TABLE on_specialization (
    id int NOT NULL AUTO_INCREMENT,
    lecturer_id int NOT NULL,
    specialization_id int NOT NULL,
    UNIQUE INDEX on_specialization_ak_1 (lecturer_id,specialization_id),
    CONSTRAINT on_specialization_pk PRIMARY KEY (id)
);

-- Table: specialization
CREATE TABLE specialization (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    description text NOT NULL,
    specialization_discount decimal(8,2) NOT NULL COMMENT 'discount if student enrolls for the whole specialization',
    active bool NOT NULL,
    UNIQUE INDEX specialization_ak_1 (name),
    CONSTRAINT specialization_pk PRIMARY KEY (id)
);

-- Table: specialization_created_by
CREATE TABLE specialization_created_by (
    id int NOT NULL AUTO_INCREMENT,
    institution_id int NOT NULL,
    specialization_id int NOT NULL,
    UNIQUE INDEX specialization_created_by_ak_1 (institution_id,specialization_id),
    CONSTRAINT specialization_created_by_pk PRIMARY KEY (id)
);

-- Table: specialization_session
CREATE TABLE specialization_session (
    id int NOT NULL AUTO_INCREMENT,
    specialization_id int NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    UNIQUE INDEX specialization_session_ak_1 (specialization_id,start_date),
    CONSTRAINT specialization_session_pk PRIMARY KEY (id)
);

-- Table: status
CREATE TABLE status (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(255) NOT NULL,
    UNIQUE INDEX status_ak_1 (status_name),
    CONSTRAINT status_pk PRIMARY KEY (id)
) COMMENT 'course/specialization final status: dropped, finished successfully, finished unsuccessfully';

-- Table: student
CREATE TABLE student (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    user_name varchar(255) NOT NULL,
    password varchar(255) NOT NULL,
    location text NOT NULL,
    UNIQUE INDEX student_ak_1 (user_name),
    CONSTRAINT student_pk PRIMARY KEY (id)
);

-- Table: student_results
CREATE TABLE student_results (
    id int NOT NULL AUTO_INCREMENT,
    material_id int NOT NULL,
    enrolled_course_id int NOT NULL,
    attempt int NOT NULL COMMENT 'ordinal number of attempts (start form 1 for each student for each material)',
    attempt_link text NULL,
    started timestamp NOT NULL COMMENT 'when material/test started',
    ended timestamp NULL COMMENT 'when material/test ended',
    score int NULL COMMENT 'student score',
    UNIQUE INDEX student_results_ak_1 (material_id,enrolled_course_id,attempt),
    CONSTRAINT student_results_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: chapter_course (table: chapter)
ALTER TABLE chapter ADD CONSTRAINT chapter_course FOREIGN KEY chapter_course (course_id)
    REFERENCES course (id);

-- Reference: course_created_by_course (table: course_created_by)
ALTER TABLE course_created_by ADD CONSTRAINT course_created_by_course FOREIGN KEY course_created_by_course (course_id)
    REFERENCES course (id);

-- Reference: course_created_by_institution (table: course_created_by)
ALTER TABLE course_created_by ADD CONSTRAINT course_created_by_institution FOREIGN KEY course_created_by_institution (institution_id)
    REFERENCES institution (id);

-- Reference: course_session_course (table: course_session)
ALTER TABLE course_session ADD CONSTRAINT course_session_course FOREIGN KEY course_session_course (course_id)
    REFERENCES course (id);

-- Reference: course_session_specialization_session (table: course_session)
ALTER TABLE course_session ADD CONSTRAINT course_session_specialization_session FOREIGN KEY course_session_specialization_session (specialization_session_id)
    REFERENCES specialization_session (id);

-- Reference: course_specialization (table: course)
ALTER TABLE course ADD CONSTRAINT course_specialization FOREIGN KEY course_specialization (specialization_id)
    REFERENCES specialization (id);

-- Reference: enrolled_course_course_session (table: enrolled_course)
ALTER TABLE enrolled_course ADD CONSTRAINT enrolled_course_course_session FOREIGN KEY enrolled_course_course_session (course_session_id)
    REFERENCES course_session (id);

-- Reference: enrolled_course_status (table: enrolled_course)
ALTER TABLE enrolled_course ADD CONSTRAINT enrolled_course_status FOREIGN KEY enrolled_course_status (status_id)
    REFERENCES status (id);

-- Reference: enrolled_course_student (table: enrolled_course)
ALTER TABLE enrolled_course ADD CONSTRAINT enrolled_course_student FOREIGN KEY enrolled_course_student (student_id)
    REFERENCES student (id);

-- Reference: enrolled_specialization_specialization_session (table: enrolled_specialization)
ALTER TABLE enrolled_specialization ADD CONSTRAINT enrolled_specialization_specialization_session FOREIGN KEY enrolled_specialization_specialization_session (specialization_session_id)
    REFERENCES specialization_session (id);

-- Reference: enrolled_specialization_status (table: enrolled_specialization)
ALTER TABLE enrolled_specialization ADD CONSTRAINT enrolled_specialization_status FOREIGN KEY enrolled_specialization_status (status_id)
    REFERENCES status (id);

-- Reference: enrolled_specialization_student (table: enrolled_specialization)
ALTER TABLE enrolled_specialization ADD CONSTRAINT enrolled_specialization_student FOREIGN KEY enrolled_specialization_student (student_id)
    REFERENCES student (id);

-- Reference: lecturer_institution (table: lecturer)
ALTER TABLE lecturer ADD CONSTRAINT lecturer_institution FOREIGN KEY lecturer_institution (institution_id)
    REFERENCES institution (id);

-- Reference: material_chapter (table: material)
ALTER TABLE material ADD CONSTRAINT material_chapter FOREIGN KEY material_chapter (chapter_id)
    REFERENCES chapter (id);

-- Reference: material_material_type (table: material)
ALTER TABLE material ADD CONSTRAINT material_material_type FOREIGN KEY material_material_type (material_type_id)
    REFERENCES material_type (id);

-- Reference: on_course_course (table: on_course)
ALTER TABLE on_course ADD CONSTRAINT on_course_course FOREIGN KEY on_course_course (course_id)
    REFERENCES course (id);

-- Reference: on_course_lecturer (table: on_course)
ALTER TABLE on_course ADD CONSTRAINT on_course_lecturer FOREIGN KEY on_course_lecturer (lecturer_id)
    REFERENCES lecturer (id);

-- Reference: on_specialization_lecturer (table: on_specialization)
ALTER TABLE on_specialization ADD CONSTRAINT on_specialization_lecturer FOREIGN KEY on_specialization_lecturer (lecturer_id)
    REFERENCES lecturer (id);

-- Reference: on_specialization_specialization (table: on_specialization)
ALTER TABLE on_specialization ADD CONSTRAINT on_specialization_specialization FOREIGN KEY on_specialization_specialization (specialization_id)
    REFERENCES specialization (id);

-- Reference: specialization_created_by_institution (table: specialization_created_by)
ALTER TABLE specialization_created_by ADD CONSTRAINT specialization_created_by_institution FOREIGN KEY specialization_created_by_institution (institution_id)
    REFERENCES institution (id);

-- Reference: specialization_created_by_specialization (table: specialization_created_by)
ALTER TABLE specialization_created_by ADD CONSTRAINT specialization_created_by_specialization FOREIGN KEY specialization_created_by_specialization (specialization_id)
    REFERENCES specialization (id);

-- Reference: specialization_session_specialization (table: specialization_session)
ALTER TABLE specialization_session ADD CONSTRAINT specialization_session_specialization FOREIGN KEY specialization_session_specialization (specialization_id)
    REFERENCES specialization (id);

-- Reference: student_results_enrolled_course (table: student_results)
ALTER TABLE student_results ADD CONSTRAINT student_results_enrolled_course FOREIGN KEY student_results_enrolled_course (enrolled_course_id)
    REFERENCES enrolled_course (id);

-- Reference: student_results_material (table: student_results)
ALTER TABLE student_results ADD CONSTRAINT student_results_material FOREIGN KEY student_results_material (material_id)
    REFERENCES material (id);

-- End of file.


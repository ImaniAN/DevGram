-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:36:54.682

-- tables
-- Table: auditorium
CREATE TABLE `auditorium` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(32) NOT NULL,
    `seats_no` int NOT NULL,
    CONSTRAINT `auditorium_pk` PRIMARY KEY (`id`)
) COMMENT 'seats_no is redundancy (it could be computed by counting Seat.id_seat related to specific room)';

-- Table: employee
CREATE TABLE `employee` (
    `id` int NOT NULL AUTO_INCREMENT,
    `username` varchar(32) NOT NULL,
    `password` varchar(100) NOT NULL,
    CONSTRAINT `employee_pk` PRIMARY KEY (`id`)
) COMMENT 'Employee list (users of system)';

-- Table: movie
CREATE TABLE `movie` (
    `id` int NOT NULL AUTO_INCREMENT,
    `title` varchar(256) NOT NULL,
    `director` varchar(256) NULL,
    `cast` varchar(1024) NULL,
    `description` text NULL,
    `duration_min` int NULL,
    CONSTRAINT `movie_pk` PRIMARY KEY (`id`)
);

-- Table: reservation
CREATE TABLE `reservation` (
    `id` int NOT NULL AUTO_INCREMENT,
    `screening_id` int NOT NULL,
    `employee_reserved_id` int NULL,
    `reservation_type_id` int NULL,
    `reservation_contact` varchar(1024) NOT NULL,
    `reserved` bool NULL,
    `employee_paid_id` int NULL,
    `paid` bool NULL,
    `active` bool NOT NULL,
    CONSTRAINT `reservation_pk` PRIMARY KEY (`id`)
);

-- Table: reservation_type
CREATE TABLE `reservation_type` (
    `id` int NOT NULL AUTO_INCREMENT,
    `reservation_type` varchar(32) NOT NULL,
    CONSTRAINT `reservation_type_pk` PRIMARY KEY (`id`)
);

-- Table: screening
CREATE TABLE `screening` (
    `id` int NOT NULL AUTO_INCREMENT,
    `movie_id` int NOT NULL,
    `auditorium_id` int NOT NULL,
    `screening_start` timestamp NOT NULL,
    UNIQUE INDEX `Projection_ak_1` (`auditorium_id`,`screening_start`),
    CONSTRAINT `screening_pk` PRIMARY KEY (`id`)
);

-- Table: seat
CREATE TABLE `seat` (
    `id` int NOT NULL AUTO_INCREMENT,
    `row` int NOT NULL,
    `number` int NOT NULL,
    `auditorium_id` int NOT NULL,
    CONSTRAINT `seat_pk` PRIMARY KEY (`id`)
);

-- Table: seat_reserved
CREATE TABLE `seat_reserved` (
    `id` int NOT NULL AUTO_INCREMENT,
    `seat_id` int NOT NULL,
    `reservation_id` int NOT NULL,
    `screening_id` int NOT NULL,
    CONSTRAINT `seat_reserved_pk` PRIMARY KEY (`id`)
);

-- foreign keys
-- Reference: Projection_Movie (table: screening)
ALTER TABLE `screening` ADD CONSTRAINT `Projection_Movie` FOREIGN KEY `Projection_Movie` (`movie_id`)
    REFERENCES `movie` (`id`);

-- Reference: Projection_Room (table: screening)
ALTER TABLE `screening` ADD CONSTRAINT `Projection_Room` FOREIGN KEY `Projection_Room` (`auditorium_id`)
    REFERENCES `auditorium` (`id`);

-- Reference: Reservation_Projection (table: reservation)
ALTER TABLE `reservation` ADD CONSTRAINT `Reservation_Projection` FOREIGN KEY `Reservation_Projection` (`screening_id`)
    REFERENCES `screening` (`id`);

-- Reference: Reservation_Reservation_type (table: reservation)
ALTER TABLE `reservation` ADD CONSTRAINT `Reservation_Reservation_type` FOREIGN KEY `Reservation_Reservation_type` (`reservation_type_id`)
    REFERENCES `reservation_type` (`id`);

-- Reference: Reservation_paid_Employee (table: reservation)
ALTER TABLE `reservation` ADD CONSTRAINT `Reservation_paid_Employee` FOREIGN KEY `Reservation_paid_Employee` (`employee_paid_id`)
    REFERENCES `employee` (`id`);

-- Reference: Reservation_reserving_employee (table: reservation)
ALTER TABLE `reservation` ADD CONSTRAINT `Reservation_reserving_employee` FOREIGN KEY `Reservation_reserving_employee` (`employee_reserved_id`)
    REFERENCES `employee` (`id`);

-- Reference: Seat_Room (table: seat)
ALTER TABLE `seat` ADD CONSTRAINT `Seat_Room` FOREIGN KEY `Seat_Room` (`auditorium_id`)
    REFERENCES `auditorium` (`id`);

-- Reference: Seat_reserved_Reservation_projection (table: seat_reserved)
ALTER TABLE `seat_reserved` ADD CONSTRAINT `Seat_reserved_Reservation_projection` FOREIGN KEY `Seat_reserved_Reservation_projection` (`screening_id`)
    REFERENCES `screening` (`id`);

-- Reference: Seat_reserved_Reservation_reservation (table: seat_reserved)
ALTER TABLE `seat_reserved` ADD CONSTRAINT `Seat_reserved_Reservation_reservation` FOREIGN KEY `Seat_reserved_Reservation_reservation` (`reservation_id`)
    REFERENCES `reservation` (`id`);

-- Reference: Seat_reserved_Seat (table: seat_reserved)
ALTER TABLE `seat_reserved` ADD CONSTRAINT `Seat_reserved_Seat` FOREIGN KEY `Seat_reserved_Seat` (`seat_id`)
    REFERENCES `seat` (`id`);

-- End of file.


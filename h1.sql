CREATE DATABASE hostel;
USE hostel;
SHOW DATABASES;
USE hostel;

CREATE TABLE hostel_list (
hostel_code CHAR(2) NOT NULL,
vacancy INT UNSIGNED NOT NULL,
PRIMARY KEY (hostel_code)
);

CREATE TABLE wing_leader(
id VARCHAR (13) NOT NULL UNIQUE,
wing_size INT UNSIGNED NOT NULL,
gender CHAR(1), CHECK(gender in ("M", "F")),
pref_1 CHAR(2) NOT NULL,
pref_2 CHAR(2) NOT NULL,
pref_3 CHAR(2) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE wing_members(
id_1 VARCHAR (13) NOT NULL,
id_2 VARCHAR (13),
gender CHAR(1), CHECK(gender in ("M", "F")),
PRIMARY KEY (id_1),
FOREIGN KEY (id_2) REFERENCES wing_leader(id)
);

CREATE TABLE ashok (
room_number INT UNSIGNED NOT NULL AUTO_INCREMENT,
id VARCHAR (13) NOT NULL,
PRIMARY KEY (room_number) 
);

CREATE TABLE bhagirath LIKE ashok;
CREATE TABLE budh LIKE ashok;
CREATE TABLE cvr LIKE ashok;
CREATE TABLE gandhi LIKE ashok;
CREATE TABLE krishna LIKE ashok;
CREATE TABLE malviya LIKE ashok;
CREATE TABLE meera LIKE ashok;
CREATE TABLE ram LIKE ashok;
CREATE TABLE ranapratap LIKE ashok;
CREATE TABLE shankar LIKE ashok;
CREATE TABLE sr LIKE ashok;
CREATE TABLE vishwakarma LIKE ashok;
CREATE TABLE vyas LIKE ashok;

INSERT INTO hostel_list VALUES
("AK", 400), ("BG", 400), ("BD", 400), ("CV", 400), ("GN", 400), ("KR", 400), ("MA", 400),
("MR", 400), ("RM", 400), ("RP", 400), ("SK", 400), ("SR", 400), ("VK", 400), ("VY", 400);

select * from hostel_list;

create table hostel_allotment (
id char (13) not null primary key,
hostel_alloted varchar (2),
room_number int unsigned 
);

-- Starting girl allocation 
CREATE VIEW girls AS
SELECT id, wing_size FROM wing_leader
where gender = "F";

select * from wing_members;

update girls set wing_size = wing_size + 1;

call allocate_girls("2019b4a70860p");


CREATE VIEW boys AS
SELECT id, wing_size, pref_1, pref_2, pref_3 FROM wing_leader
where gender = "M";

update boys set wing_size = wing_size + 1;

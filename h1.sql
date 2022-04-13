DROP DATABASE IF EXISTS hostel; 
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
pref_2 CHAR(2),
pref_3 CHAR(2),
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
("AK", 400), ("BG", 400), ("BD", 400), ("CV", 400), ("GN", 400), ("KR", 400), ("ML", 400),
("MR", 400), ("RM", 400), ("RP", 400), ("SK", 400), ("SR", 400), ("VK", 400), ("VY", 400);

select * from hostel_list;

create table hostel_allotment (
id char (13) not null primary key,
hostel_alloted varchar (2),
room_number int unsigned 
);

-- Starting girl allocation 
-- CREATE VIEW girls AS
-- SELECT id, wing_size FROM wing_leader
-- where gender = "F";

-- select * from wing_members;

-- update girls set wing_size = wing_size + 1;

-- call allocate_girls("2019b4a70860p");


-- CREATE VIEW boys AS
-- SELECT id, wing_size, pref_1, pref_2, pref_3 FROM wing_leader
-- where gender = "M";

-- update boys set wing_size = wing_size + 1;

-- Trigger to ensure 2 things before inserting into the wing_members table --
-- 1. The gender of the entry to be inserted matches with the gender of the wing leader --
-- 2. Wing size should not exceed the size specified by the wing leader --
DELIMITER $$
CREATE TRIGGER trig BEFORE INSERT
ON wing_members
FOR EACH ROW
BEGIN
DECLARE x INT;
IF (NEW.gender != (SELECT gender FROM wing_leader WHERE wing_leader.id = NEW.id_2)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert Unsuccessful. Gender not matching with the gender of the wing leader.';
END IF;
SELECT COUNT(*)
	INTO x
FROM
	wing_members
WHERE 
	wing_members.id_2 = NEW.id_2;
IF (x > (SELECT wing_size - 2 FROM wing_leader WHERE wing_leader.id = NEW.id_2)) THEN
	SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Insert Unsuccessful. Wing is already full.';
END IF;
END; $$
DELIMITER ;

-- Sample Data --
INSERT INTO wing_leader VALUES('2019A1PS0150P', 4, 'M', 'ML', 'RM', 'BD');
INSERT INTO wing_leader VALUES('2019A1PS0599P', 5, 'M', 'ML', 'RM', 'BD');
INSERT INTO wing_leader VALUES('2019A1PS0615P', 6, 'M', 'SR', 'RM', 'KR');
INSERT INTO wing_leader VALUES('2019A1PS0646P', 7, 'M', 'KR', 'VK', 'CV');
INSERT INTO wing_leader VALUES('2019A2PS0414P', 8, 'M', 'AK', 'RM', 'SK');
INSERT INTO wing_leader VALUES('2019A1PS0433P', 4, 'F', 'MR', NULL, NULL);

INSERT INTO wing_members VALUES('2019A1PS0386P', '2019A1PS0150P', 'M');
INSERT INTO wing_members VALUES('2019A1PS0556P', '2019A1PS0150P', 'M');
INSERT INTO wing_members VALUES('2019A1PS0581P', '2019A1PS0150P', 'M');

SELECT * FROM wing_members;

INSERT INTO wing_members VALUES('2019A1PS0600P', '2019A1PS0599P', 'M');
INSERT INTO wing_members VALUES('2019A1PS0601P', '2019A1PS0599P', 'M');
INSERT INTO wing_members VALUES('2019A1PS0610P', '2019A1PS0599P', 'M');
INSERT INTO wing_members VALUES('2019A1PS0614P', '2019A1PS0599P', 'M');

INSERT INTO wing_members VALUES('2019A1PS0622P', '2019A1PS0615P', 'M');
INSERT INTO wing_members VALUES('2019A1PS0625P', '2019A1PS0615P', 'M');
INSERT INTO wing_members VALUES('2019A1PS0630P', '2019A1PS0615P', 'M');
INSERT INTO wing_members VALUES('2019A1PS0633P', '2019A1PS0615P', 'M');
INSERT INTO wing_members VALUES('2019A1PS0644P', '2019A1PS0615P', 'M');

INSERT INTO wing_members VALUES('2019A1PS0651P', '2019A1PS0646P', 'M');
INSERT INTO wing_members VALUES('2019A1PS0655P', '2019A1PS0646P', 'M');
INSERT INTO wing_members VALUES('2019A1PS0663P', '2019A1PS0646P', 'M');
INSERT INTO wing_members VALUES('2019A1PS0664P', '2019A1PS0646P', 'M');
INSERT INTO wing_members VALUES('2019A1PS0670P', '2019A1PS0646P', 'M');
INSERT INTO wing_members VALUES('2019A1PS0673P', '2019A1PS0646P', 'M');

INSERT INTO wing_members VALUES('2019A2PS0577P', '2019A2PS0414P', 'M');
INSERT INTO wing_members VALUES('2019A2PS0585P', '2019A2PS0414P', 'M');
INSERT INTO wing_members VALUES('2019A2PS0590P', '2019A2PS0414P', 'M');
INSERT INTO wing_members VALUES('2019A2PS0626P', '2019A2PS0414P', 'M');
INSERT INTO wing_members VALUES('2019A2PS0632P', '2019A2PS0414P', 'M');
INSERT INTO wing_members VALUES('2019A2PS0640P', '2019A2PS0414P', 'M');
INSERT INTO wing_members VALUES('2019A2PS0648P', '2019A2PS0414P', 'M');

INSERT INTO wing_members VALUES('2019A1PS0686P', '2019A1PS0433P', 'F');
INSERT INTO wing_members VALUES('2019A1PS0709P', '2019A1PS0433P', 'F');
INSERT INTO wing_members VALUES('2019A1PS0711P', '2019A1PS0433P', 'F');
-- Created required database and tables  
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
id CHAR (13) NOT NULL UNIQUE,
wing_size INT UNSIGNED NOT NULL,
gender CHAR(1), CHECK(gender in ("M", "F")),
pref_1 CHAR(2) NOT NULL,
pref_2 CHAR(2),
pref_3 CHAR(2),
PRIMARY KEY (id)
);

CREATE TABLE wing_members(
id_1 CHAR (13) NOT NULL,
id_2 CHAR (13),
gender CHAR(1), CHECK(gender in ("M", "F")),
PRIMARY KEY (id_1),
FOREIGN KEY (id_2) REFERENCES wing_leader(id)
);

CREATE TABLE ashok (
room_number INT UNSIGNED NOT NULL AUTO_INCREMENT,
id VARCHAR (13) NOT NULL UNIQUE,
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

-- inserting sample data 
INSERT INTO hostel_list VALUES
("AK", 400), ("BG", 400), ("BD", 400), ("CV", 400), ("GN", 400), ("KR", 400), ("ML", 400),
("MR", 400), ("RM", 400), ("RP", 400), ("SK", 400), ("SR", 400), ("VK", 400), ("VY", 400);

-- trigger to maintain consistency in inserted tuples 
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
IF (x > (SELECT wing_size - 1 FROM wing_leader WHERE wing_leader.id = NEW.id_2)) THEN
	SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Insert Unsuccessful. Wing is already full.';
END IF;
END; $$
DELIMITER ;

-- DROP TRIGGER trig;

-- Sample data for wing_leader table 
INSERT INTO wing_leader VALUES('2019A1PS0150P', 3, 'M', 'ML', 'RM', 'BD');
INSERT INTO wing_leader VALUES('2019A1PS0599P', 4, 'M', 'ML', 'RM', 'BD');
INSERT INTO wing_leader VALUES('2019A1PS0615P', 5, 'M', 'SR', 'RM', 'KR');
INSERT INTO wing_leader VALUES('2019A1PS0646P', 6, 'M', 'KR', 'VK', 'CV');
INSERT INTO wing_leader VALUES('2019B4A70860P', 3, 'F', 'MR', NULL, NULL);
INSERT INTO wing_leader VALUES('2019A2PS0414P', 7, 'M', 'AK', 'RM', 'SK');
INSERT INTO wing_leader VALUES('2019A1PS0433P', 3, 'F', 'MR', NULL, NULL);

SELECT * FROM wing_members;

-- Sample data for wing_members table
INSERT INTO wing_members VALUES('2019A1PS0386P', '2019A1PS0150P', 'M');
INSERT INTO wing_members VALUES('2019A1PS0556P', '2019A1PS0150P', 'M');
INSERT INTO wing_members VALUES('2019A1PS0581P', '2019A1PS0150P', 'M');

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

INSERT INTO wing_members VALUES
("2019A7PS0064P", "2019B4A70860P", "F"),
("2019A7PS0062P", "2019B4A70860P", "F"),
("2019A7PS0133P", "2019B4A70860P", "F");

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

select * from wing_members;

-- As the input value excluded the wing_leader in the count of wing_members 
UPDATE wing_leader SET wing_size = wing_size + 1;

-- Creating required views and procedures
CREATE VIEW girls AS
SELECT id, wing_size FROM wing_leader
WHERE gender = "F";

SELECT * FROM girls;

delimiter $$
CREATE PROCEDURE get_vacancy (IN hostel_abr CHAR(2), OUT vacant INT)
COMMENT 'Returns the number of vacant room in a Bhawan'
BEGIN
	SELECT vacancy INTO vacant FROM hostel_list WHERE hostel_code = hostel_abr ;
END $$

DELIMITER $$
CREATE PROCEDURE hostel_allotment_girls() 
COMMENT 'Gets id of every girl wing leader and calls the allocate_girls() procedure to allot room to each girl in Meera Bhawan' 
BEGIN  
    
    DECLARE n INT DEFAULT 0;
	DECLARE i INT DEFAULT 0; 
    
    SELECT COUNT(*) FROM girls INTO n;
	SET i=0;
    
    WHILE i<n DO 
		SELECT id, wing_size
        INTO @id, @size
        FROM girls
        ORDER BY wing_size DESC
        LIMIT i,1;
        CALL get_vacancy("MR", @vacant);
        IF @vacant >= @size THEN
			CALL allocate_girls(@id);
		ELSE
			SELECT 'Not enough rooms' AS '';
        END IF;
		SET i = i + 1;
	END WHILE;
END $$ 
DELIMITER ; 

delimiter $$
CREATE PROCEDURE allocate_girls (IN leader_id CHAR(13))
COMMENT 'Allots a room in Meera Bhawan to every girl in a wing. Room & ID gets stored in the meera table'
BEGIN
    DECLARE i INT DEFAULT 0;     
    
	SELECT vacancy INTO @vacant FROM hostel_list WHERE hostel_code = "MR";
	SELECT wing_size INTO @size FROM girls WHERE id=leader_id;
    
    WHILE i<@size-1 DO
		
        SELECT id_1 INTO @mem FROM wing_members WHERE id_2=leader_id LIMIT i,1;
		SET i = i + 1;
        INSERT INTO meera VALUE
		(400 - @vacant + i, @mem);
        
	END WHILE;
    SET i = i + 1;
	INSERT INTO meera VALUE
	(400 - @vacant + i, leader_id);
    
    UPDATE hostel_list 
	SET vacancy = @vacant - @size
	WHERE hostel_code = "MR";
    
END $$

call hostel_allotment_girls();

SELECT * FROM hostel_list;
SELECT * FROM meera;


-- Starting boys allocation 
CREATE VIEW boys AS
SELECT id, wing_size, pref_1, pref_2, pref_3 FROM wing_leader
where gender = "M";

DELIMITER $$
CREATE PROCEDURE hostel_allotment_boys()  
COMMENT 'Gets id of every boy wing leader and calls the allocate_boys() procedure 
		to allot room to each boy in their preferrerd Bhawan'
BEGIN  

    DECLARE n INT DEFAULT 0;
	DECLARE i INT DEFAULT 0;    

    SELECT COUNT(*) FROM boys INTO n;
	SET i=0;
    
    WHILE i<n DO 
		SELECT id, wing_size, pref_1, pref_2, pref_3
        INTO @id, @size, @pref_1, @pref_2, @pref_3
        FROM boys
        ORDER BY wing_size DESC
        LIMIT i,1;

        CALL get_vacancy(@pref_1, @vacant_1);
        CALL get_vacancy(@pref_2, @vacant_2);
        CALL get_vacancy(@pref_3, @vacant_3);

        IF @vacant_1 >= @size THEN
			CALL allocate_boys(@id, @pref_1); 
		ELSEIF @vacant_2 >= @size THEN 
			CALL allocate_boys(@id, @pref_2);
		ELSEIF @vacant_3 >= @size THEN 
			CALL allocate_boys(@id, @pref_3);
		ELSE
			CALL random_allocate_boys(@id, @size);
        END IF;

		SET i = i + 1;
	END WHILE;
END $$ 
DELIMITER ; 

delimiter $$
CREATE PROCEDURE allocate_boys (IN leader_id CHAR(13), IN hostel_abr CHAR(2))
COMMENT 'Allocates room to every boy in the wing in the hostel of their preference, 
		if possible, otherwise they are allotted rooms randomly'
BEGIN
	
    DECLARE i INT DEFAULT 0;
    CALL get_vacancy(hostel_abr, @vacant);

    SELECT wing_size INTO @size FROM wing_leader WHERE id=leader_id;

    WHILE i<@size-1 DO  
        SELECT id_1 INTO @mem FROM wing_members WHERE id_2=leader_id LIMIT i,1;
		SET i = i + 1;
        CALL insert_into_hostel(hostel_abr, i, @mem);
    END WHILE; 

    SET i = i+1;
    CALL insert_into_hostel(hostel_abr, i, leader_id);
	
    UPDATE hostel_list
    SET vacancy = @vacant- @size
    WHERE hostel_code = hostel_abr;
END $$

delimiter $$
CREATE PROCEDURE insert_into_hostel (IN hostel_abr CHAR(2), IN i INT, IN id CHAR(13))
COMMENT 'Allocates the first non-occupied room in the accepted Bhawan to the accepted id'
BEGIN
	CALL get_vacancy(hostel_abr, @vacant);
    CASE
		WHEN hostel_abr = "AK" THEN INSERT INTO ashok VALUE(400-@vacant+i, id);
		WHEN hostel_abr = "BG" THEN INSERT INTO bhagirath VALUE(400-@vacant+i, id);
		WHEN hostel_abr = "BD" THEN INSERT INTO budh VALUE(400-@vacant+i, id);
		WHEN hostel_abr = "CV" THEN INSERT INTO cvr VALUE(400-@vacant+i, id);
		WHEN hostel_abr = "GN" THEN INSERT INTO gandhi VALUE(400-@vacant+i, id);
		WHEN hostel_abr = "KR" THEN INSERT INTO krishna VALUE(400-@vacant+i, id);
		WHEN hostel_abr = "ML" THEN INSERT INTO malviya VALUE(400-@vacant+i, id);
		WHEN hostel_abr = "RM" THEN INSERT INTO ram VALUE(400-@vacant+i, id);
		WHEN hostel_abr = "RP" THEN INSERT INTO ranapratap VALUE(400-@vacant+i, id);
		WHEN hostel_abr = "SK" THEN INSERT INTO shankar VALUE(400-@vacant+i, id);
		WHEN hostel_abr = "SR" THEN INSERT INTO sr VALUE(400-@vacant+i, id);
		WHEN hostel_abr = "VK" THEN INSERT INTO vishwakarma VALUE(400-@vacant+i, id);
		WHEN hostel_abr = "VY" THEN INSERT INTO vyas VALUE(400-@vacant+i, id);
    END CASE;
END $$

delimiter $$
CREATE PROCEDURE random_allocate_boys (IN leader_id CHAR(13), IN size INT)
COMMENT 'In case rooms are not allotted in preferred bhawans then the wing gets allotted to the hostel having maximum vacancies'
BEGIN
	DECLARE i INT DEFAULT 0;
    SELECT hostel_code, vacancy INTO @hostel_abr, @vacant 
    FROM hostel_list 
    WHERE hostel_code NOT IN ("MR") ORDER BY vacancy DESC, hostel_code ASC LIMIT 1;
    IF @vacant >= size THEN 
		WHILE i<@size-1 DO  
			SELECT id_1 INTO @mem FROM wing_members WHERE id_2=leader_id LIMIT i,1;
			SET i = i + 1;
			CALL insert_into_hostel(@hostel_abr, i, @mem);
		END WHILE; 
	
		SET i = i+1;
		CALL insert_into_hostel(@hostel_abr, i, leader_id);
		
		UPDATE hostel_list
		SET vacancy = @vacant- @size
		WHERE hostel_code = @hostel_abr;
    ELSE
		SELECT 'Not enough rooms' AS '';
    END IF;
END $$

CALL hostel_allotment_boys();

SELECT * FROM hostel_list; -- Observe the decrease in vacancies as we fill up students

-- Example of allocation  
SELECT * FROM ashok;
SELECT * FROM ram;
SELECT * FROM krishna;

-- To test random allotment procedure, we have decreased the vacancies and added the additional tuples 
update hostel_list set vacancy = 5 where hostel_code in ("Ak", "ML", "KR");

INSERT INTO wing_leader VALUES('2019A5PS0414P', 8, 'M', 'AK', 'ml', 'KR');

INSERT INTO wing_members VALUES('2019A9PS0577P', '2019A5PS0414P', 'M');
INSERT INTO wing_members VALUES('2019A9PS0585P', '2019A5PS0414P', 'M');
INSERT INTO wing_members VALUES('2019A9PS0590P', '2019A5PS0414P', 'M');
INSERT INTO wing_members VALUES('2019A9PS0626P', '2019A5PS0414P', 'M');
INSERT INTO wing_members VALUES('2019A9PS0632P', '2019A5PS0414P', 'M');
INSERT INTO wing_members VALUES('2019A9PS0640P', '2019A5PS0414P', 'M');
INSERT INTO wing_members VALUES('2019A9PS0648P', '2019A5PS0414P', 'M');

-- Drop queries for procedure, trigger, view, tables and database 
DROP PROCEDURE get_vacancy;
DROP PROCEDURE allocate_girls;
DROP PROCEDURE hostel_allotment_girls;
DROP PROCEDURE allocate_boys;
DROP PROCEDURE random_allocate_boys;
DROP PROCEDURE hostel_allotment_boys;
DROP PROCEDURE insert_into_hostel;

DROP TRIGGER trig;

DROP VIEW girls, boys;

DROP TABLES ashok, bhagirath, budh, cvr, gandhi, krishna, malviya, meera, ram, ranapratap, shankar, sr, vishwakarma, vyas;
DROP TABLES wing_members, wing_leader, hostel_list;

DROP DATABASE hostel;
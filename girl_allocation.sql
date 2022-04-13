delimiter $$
CREATE PROCEDURE allocate_girls (in leader_id CHAR(13))-- , in hostel_abr CHAR(2))
BEGIN
    DECLARE i INT DEFAULT 0; 
--     DECLARE x CHAR(13);
--     DECLARE leader_id CHAR(13);
    -- SET leader_id = "2019b4a70860p";
    
    
	SELECT vacancy INTO @vacant FROM hostel_list WHERE hostel_code = "MR";
	SELECT wing_size INTO @size FROM girls WHERE id=leader_id ;
    
    
    -- SET x = select id_1 from @members limit i,1;
    
    WHILE i<size DO
		set i = i + 1;
        SELECT id_1 into @member from wing_members where id_2=leader_id limit i,1;
		INSERT INTO meera value
		(member, 400 - vacant + i);
        
	end while;
    
    update hostel_list 
	set vacant = vacant - size
	where hostel_code = hostel_sym;
    
END $$
USE `worktime`;

-- 3. feladat:
DELIMITER //

CREATE PROCEDURE IF NOT EXISTS `sp_register_work_time`(
    IN _employee_id INT,
    IN _start_time TIME,
    IN _end_time TIME,
    IN _break_minutes INT
)
BEGIN
    IF _start_time >= _end_time THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A kezdési időpont nem lehet későbbi, mint a befejezési';
    END IF;
    
    INSERT INTO
      `timesheets` (`employee_id`, `work_date`, `start_time`, `end_time`, `break_minutes`, `approved`)
    VALUES
      (_employee_id, CURDATE(), _start_time, _end_time, _break_minutes, 0);
END//

DELIMITER ;

-- 4. feladat:
DELIMITER //

CREATE PROCEDURE IF NOT EXISTS `sp_workhours`(
    IN _employee_id INT,
    IN _year INT,
    OUT _total_hours DECIMAL(10,2)
)
BEGIN
    SELECT 
        SUM((TIME_TO_SEC(TIMEDIFF(`end_time`, `start_time`)) - (`break_minutes` * 60)) / 3600)
    INTO
      _total_hours
    FROM
      `timesheets`
    WHERE
      `employee_id` = _employee_id
      AND YEAR(`work_date`) = _year
      AND approved = 1;
    
    SET _total_hours = IFNULL(_total_hours, 0);
END//

DELIMITER ;

-- 5. feladat:
CALL `sp_workhours`(1, 2024, @total_hours);

SELECT
	@total_hours AS '1-es dolgozó teljes munkaideje 2024-ben'
FROM
	DUAL;

-- 6. feladat:
DELIMITER //

CREATE PROCEDURE IF NOT EXISTS `sp_approve`(
    IN _timesheet_id INT,
    IN _approver_id INT
)
BEGIN
    DECLARE _employee_id INT;
    DECLARE _boss_id INT;
    DECLARE _approved INT;
    DECLARE _exists INT;
    
    SELECT
      COUNT(*)
    INTO
      _exists
    FROM
      `timesheets`
    WHERE
      `id` = _timesheet_id;
    
    IF _exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A megadott munkaidő bejegyzés nem található';
    END IF;
    
    SELECT
      `employee_id`,
      `approved`
    INTO
      _employee_id,
      _approved
    FROM
      `timesheets`
    WHERE
      `id` = _timesheet_id;
    
    IF _approved = 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A bejegyzés már alá van írva';
    END IF;
    
    SELECT
      `boss_id`
    INTO
      _boss_id
    FROM
      `employees`
    WHERE
      `id` = _employee_id;
    
    IF _boss_id IS NULL THEN
        IF _approver_id != _employee_id THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Csak saját magának írhatja alá, ha nincs főnöke';
        END IF;
    ELSE
        IF _approver_id != _boss_id THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Csak a főnöke írhatja alá';
        END IF;
    END IF;
    
    UPDATE
      `timesheets`
    SET
      `approved` = 1
    WHERE
      `id` = _timesheet_id;
END//

DELIMITER ;

-- 7. feladat:
CREATE ROLE IF NOT EXISTS 'admin';
GRANT SELECT, INSERT, UPDATE ON `worktime`.* TO 'admin'@'%';

-- 8. feladat:
CREATE ROLE IF NOT EXISTS 'manager';
GRANT SELECT ON `worktime`.* TO 'manager'@'%';
GRANT EXECUTE ON PROCEDURE `worktime`.`sp_register_work_time` TO 'manager'@'%';
GRANT EXECUTE ON PROCEDURE `worktime`.`sp_approve` TO 'manager'@'%';

-- 9. feladat:
CREATE ROLE IF NOT EXISTS 'worker';
GRANT SELECT ON `worktime`.* TO 'worker'@'%';
GRANT EXECUTE ON PROCEDURE `worktime`.`sp_approve` TO 'worker'@'%';

-- 10. feladat:
DELIMITER //

CREATE PROCEDURE IF NOT EXISTS `sp_create_user`(
    IN _username VARCHAR(50),
    IN _password VARCHAR(255),
    IN _type VARCHAR(10)
)
BEGIN
    SET @sql_stmt = CONCAT('CREATE USER ''', _username, '''@''%'' IDENTIFIED BY ''', _password, '''');
    PREPARE stmt FROM @sql_stmt;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    IF _type = 'admin' THEN
        SET @sql_stmt = CONCAT('GRANT ''admin'' TO ''', _username, '''@''%''');
        PREPARE stmt FROM @sql_stmt;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    ELSEIF _type = 'manager' THEN
        SET @sql_stmt = CONCAT('GRANT ''manager'' TO ''', _username, '''@''%''');
        PREPARE stmt FROM @sql_stmt;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        
        SET @sql_stmt = CONCAT('SET DEFAULT ROLE ''manager'' TO ''', _username, '''@''%''');
        PREPARE stmt FROM @sql_stmt;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    ELSE
        SET @sql_stmt = CONCAT('GRANT ''worker'' TO ''', _username, '''@''%''');
        PREPARE stmt FROM @sql_stmt;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        
        SET @sql_stmt = CONCAT('SET DEFAULT ROLE ''worker'' TO ''', _username, '''@''%''');
        PREPARE stmt FROM @sql_stmt;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
    
    FLUSH PRIVILEGES;
END//

DELIMITER ;

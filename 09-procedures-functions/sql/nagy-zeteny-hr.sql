USE `hr`;

-- 1. feladat:
DROP PROCEDURE IF EXISTS `hely_darab`;

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS `hely_darab`(IN _orszagnev VARCHAR(40))
BEGIN
    SELECT
      COUNT(*) AS `telephelyek_szama`
    FROM
      `locations`
    INNER JOIN `countries` ON `locations`.`COUNTRY_ID` = `countries`.`COUNTRY_ID`
    WHERE
      `COUNTRY_NAME` = _orszagnev;
END//

DELIMITER ;

CALL `hely_darab`('United States of America');

-- 2. feladat:
DROP PROCEDURE IF EXISTS `dolgozodb`;

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS `dolgozodb`(
    IN _munkakor VARCHAR(10),
    OUT _darab INT
)
BEGIN
    SELECT
      COUNT(*)
    INTO
      _darab
    FROM
      `employees`
    WHERE
      `JOB_ID` = _munkakor;
    
    IF _darab IS NULL THEN
        SET _darab = 0;
    END IF;
END//

DELIMITER ;

CALL `dolgozodb`('IT_PROG', @darab);
SELECT @darab;

-- 3. feladat:
DROP PROCEDURE IF EXISTS `minmax`;

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS `minmax`()
BEGIN
    DECLARE _max_db INT;
    DECLARE _min_db INT;
    
    SELECT
      MAX(`db`),
      MIN(`db`)
    INTO
      _max_db,
      _min_db
    FROM (
        SELECT
          COUNT(*) AS `db`
        FROM
          `employees`
        GROUP BY
          `JOB_ID`
    ) AS `counts`;
    
    SELECT
      `JOB_TITLE`,
      COUNT(*) AS `dolgozok_letszama`
    FROM
      `employees`
    INNER JOIN `jobs` ON `employees`.`JOB_ID` = `jobs`.`JOB_ID`
    GROUP BY
      `JOB_TITLE`
    HAVING
      COUNT(*) = _max_db OR COUNT(*) = _min_db;
END//

DELIMITER ;

CALL `minmax`();

-- 4. feladat:
DROP PROCEDURE IF EXISTS `emel1000`;

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS `emel1000`(
    IN _varos VARCHAR(30),
    IN _munkakor VARCHAR(10)
)
BEGIN
    UPDATE
      `employees`
    INNER JOIN `departments` ON `employees`.`DEPARTMENT_ID` = `departments`.`DEPARTMENT_ID`
    INNER JOIN `locations` ON `departments`.`LOCATION_ID` = `locations`.`LOCATION_ID`
    SET
      `SALARY` = `SALARY` + 1000
    WHERE
      `CITY` = _varos
      AND `employees`.`JOB_ID` = _munkakor;
END//

DELIMITER ;

CALL `emel1000`('Seattle', 'IT_PROG');

-- 5. feladat:
DROP PROCEDURE IF EXISTS `emeles`;

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS `emeles`(
    IN _kor INT,
    IN _reszleg_id DECIMAL(4,0),
    IN _szazalek DECIMAL(5,2)
)
BEGIN
    UPDATE
      `employees`
    SET
      `SALARY` = `SALARY` * (1 + _szazalek / 100)
    WHERE
      `DEPARTMENT_ID` = _reszleg_id
      AND TIMESTAMPDIFF(YEAR, `HIRE_DATE`, CURDATE()) >= _kor;
END//

DELIMITER ;

CALL `emeles`(30, 90, 10);

-- 6. feladat:
DROP PROCEDURE IF EXISTS `hely`;

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS `hely`(
    IN _location_id DECIMAL(4,0),
    IN _cim VARCHAR(40),
    IN _iranyitoszam VARCHAR(12),
    IN _varos VARCHAR(30),
    IN _orszagnev VARCHAR(40)
)
BEGIN
    DECLARE _country_id VARCHAR(2);
    
    SELECT
      `COUNTRY_ID`
    INTO
      _country_id
    FROM
      `countries`
    WHERE
      `COUNTRY_NAME` = _orszagnev;
    
    IF _country_id IS NOT NULL THEN
        INSERT INTO `locations` (
            `LOCATION_ID`,
            `STREET_ADDRESS`,
            `POSTAL_CODE`,
            `CITY`,
            `COUNTRY_ID`
        )
        VALUES (
            _location_id,
            _cim,
            _iranyitoszam,
            _varos,
            _country_id
        );
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nem létező ország!';
    END IF;
END//

DELIMITER ;

CALL `hely`(3300, 'Test Street 123', '1234', 'Test', 'Canada');

-- 7. feladat:
DROP FUNCTION IF EXISTS `orszagkod`;

DELIMITER //

CREATE FUNCTION IF NOT EXISTS `orszagkod`(_orszagnev VARCHAR(40))
RETURNS VARCHAR(2)
DETERMINISTIC
BEGIN
    DECLARE _kod VARCHAR(2);
    
    SELECT
      `COUNTRY_ID`
    INTO
      _kod
    FROM
      `countries`
    WHERE
      `COUNTRY_NAME` = _orszagnev;
    
    RETURN _kod;
END//

DELIMITER ;

SELECT `orszagkod`('Canada');

-- 8. feladat:
DROP FUNCTION IF EXISTS `atlagfizetes`;

DELIMITER //

CREATE FUNCTION IF NOT EXISTS `atlagfizetes`(
    _reszleg_nev VARCHAR(30)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE _atlag DECIMAL(10,2);
    
    SELECT
      AVG(`SALARY`)
    INTO
      _atlag
    FROM
      `employees`
    INNER JOIN `departments` ON `employees`.`DEPARTMENT_ID` = `departments`.`DEPARTMENT_ID`
    WHERE
      `departments`.`DEPARTMENT_NAME` = _reszleg_nev;
    
    RETURN _atlag;
END//

DELIMITER ;

SELECT `atlagfizetes`('Finance');

-- 9. feladat:
DROP FUNCTION IF EXISTS `fonokatlag`;

DELIMITER //

CREATE FUNCTION IF NOT EXISTS `fonokatlag`()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE _atlag DECIMAL(10,2);
    
    SELECT
      AVG(`SALARY`)
    INTO
      _atlag
    FROM
      `employees`
    WHERE
      `EMPLOYEE_ID` IN (
        SELECT DISTINCT
          `MANAGER_ID`
        FROM
          `employees`
        WHERE
          `MANAGER_ID` IS NOT NULL
    );
    
    RETURN _atlag;
END//

DELIMITER ;

SELECT `fonokatlag`();

-- 10. feladat:
DROP FUNCTION IF EXISTS `email`;

DELIMITER //

CREATE FUNCTION IF NOT EXISTS `email`(_employee_id DECIMAL(6,0))
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE _email VARCHAR(50);
    DECLARE _vezeteknev VARCHAR(25);
    DECLARE _keresztnev VARCHAR(20);
    
    SELECT
      `LAST_NAME`,
      `FIRST_NAME`
    INTO
      _vezeteknev,
      _keresztnev
    FROM
      `employees`
    WHERE
      `EMPLOYEE_ID` = _employee_id;
    
    SET _email = CONCAT(
        LOWER(LEFT(_vezeteknev, 2)),
        LOWER(RIGHT(_keresztnev, 2)),
        LPAD(_employee_id, 6, '0'),
        '@supercompany.com'
    );
    
    RETURN _email;
END//

DELIMITER ;

SELECT `email`(100);

-- 11. feladat:
DROP FUNCTION IF EXISTS `emailfrissites`;

DELIMITER //

CREATE FUNCTION IF NOT EXISTS `emailfrissites`()
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE _frissitett_db INT;
    DECLARE _done INT DEFAULT FALSE;
    DECLARE _employee_id DECIMAL(6,0);

    DECLARE `cursor` CURSOR FOR
      SELECT
        `EMPLOYEE_ID`
      FROM
        `employees`;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET _done = TRUE;
    
    SET _frissitett_db = 0;
    
    OPEN `cursor`;
    
    `read_loop`: LOOP
        FETCH `cursor` INTO _employee_id;
        IF _done THEN
            LEAVE `read_loop`;
        END IF;
        
        UPDATE
          `employees`
        SET
          `EMAIL` = `email`(_employee_id)
        WHERE
          `EMPLOYEE_ID` = _employee_id;
        
        SET _frissitett_db = _frissitett_db + 1;
    END LOOP;
    
    CLOSE `cursor`;

    RETURN _frissitett_db;
END//

DELIMITER ;

SELECT `emailfrissites`();

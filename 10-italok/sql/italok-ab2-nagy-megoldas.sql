USE `italbolt`;

-- 1. feladat
DROP VIEW IF EXISTS `nemsor`;

CREATE VIEW IF NOT EXISTS `nemsor` AS
SELECT
	*
FROM
	`italok`
WHERE
	`tipus` <> 'sör'
	AND `ar` BETWEEN 220 AND 440;

SELECT
	*
FROM
	`nemsor`;

-- 2. feladat
DROP VIEW IF EXISTS `keszlethiany`;

CREATE VIEW IF NOT EXISTS `keszlethiany` AS
SELECT
	`nev`
FROM
	`italok`
WHERE
	`kiszereles` = 'dobozos'
	AND `keszlet` < 48;

SELECT
	*
FROM
	`keszlethiany`;

-- 3. feladat
DROP FUNCTION IF EXISTS `alkohol_formaz`;

DELIMITER //

CREATE FUNCTION IF NOT EXISTS `alkohol_formaz`(`a` DOUBLE)
RETURNS
	VARCHAR(20)
DETERMINISTIC
BEGIN
    RETURN CONCAT(REPLACE(ROUND(`a` * 100, 1), '.', ','), '%');
END //

DELIMITER ;

-- 4. feladat
SELECT
	`nev`,
	`tipus`,
	`alkohol_formaz` (`alkohol`) AS `alkoholtartalom`
FROM
	`italok`;

-- 5. feladat
DROP TABLE IF EXISTS `eladas`;

CREATE TABLE IF NOT EXISTS `eladas` (
	`id` int NOT NULL,
    `egyseg` int NOT NULL,
    `mikor` datetime NOT NULL,
    PRIMARY KEY (`id`, `mikor`),
    FOREIGN KEY (`id`) REFERENCES `italok`(`id`)
);

-- 6. feladat
DROP TRIGGER IF EXISTS `sor`;

DELIMITER //

CREATE TRIGGER IF NOT EXISTS `sor`
BEFORE INSERT ON `italok`
FOR EACH ROW
BEGIN
    IF NEW.`tipus` = 'sör' AND NEW.`alkohol` > 0.0020 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A sörben kevesebb alkohol lehet!';
    END IF;
END //

DELIMITER ;

-- 7. feladat
DROP TRIGGER IF EXISTS `nincsennyi`;

DELIMITER //

CREATE TRIGGER IF NOT EXISTS `nincsennyi`
BEFORE UPDATE ON `italok`
FOR EACH ROW
BEGIN
    IF NEW.`keszlet` < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nincs ennyi';
    END IF;
END //

DELIMITER ;

-- 8. feladat
DROP PROCEDURE IF EXISTS `eladas_rogzitese`;

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS `eladas_rogzitese`(IN `mit` INT, IN `mennyit` INT)
BEGIN
    DECLARE `hiba` INT DEFAULT 0;

    START TRANSACTION;

    UPDATE
      `italok`
    SET
      `keszlet` = `keszlet` - `mennyit`
    WHERE
      `id` = `mit`;

    IF ROW_COUNT() = 0 THEN
        SET `hiba` = 1;
    END IF;

    INSERT INTO `eladas` (`id`, `egyseg`, `mikor`)
    VALUES (`mit`, `mennyit`, NOW());

    IF `hiba` = 1 THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END //

DELIMITER ;

CALL `eladas_rogzitese`(1, 1);

-- 9. feladat
SELECT
    `nev`,
    SUM(`egyseg`) AS `osszes_eladott`
FROM
	`eladas`
JOIN
	`italok` ON `eladas`.`id` = `italok`.`id`
GROUP BY
	`nev`;

-- 10. feladat
DROP TABLE IF EXISTS `statisztika`;

CREATE TABLE IF NOT EXISTS `statisztika` (
    `datum` date NOT NULL PRIMARY KEY,
    `liter` double NOT NULL
);

-- 11. feladat
DROP EVENT IF EXISTS `napi`;

DELIMITER //

CREATE EVENT IF NOT EXISTS `napi`
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_DATE + INTERVAL 1 HOUR
DO
BEGIN
    INSERT INTO `statisztika` (`datum`, `liter`)
    SELECT
        CURDATE() - INTERVAL 1 DAY,
        SUM(`egyseg` * `mennyiseg`)
    FROM
      `eladas`
    JOIN
      `italok` ON `eladas`.`id` = `italok`.`id`
    WHERE
      DATE(`eladas`.`mikor`) = CURDATE() - INTERVAL 1 DAY;
END //

DELIMITER ;

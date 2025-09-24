USE `hr`;

-- 3. feladat:
CREATE OR REPLACE VIEW `programozok` AS
SELECT
	CONCAT(`FIRST_NAME`, ' ', `LAST_NAME`) AS `FULL_NAME`
FROM
	`employees`
	INNER JOIN `jobs` ON `jobs`.`JOB_ID` = `employees`.`JOB_ID`
WHERE
	`JOB_TITLE` = 'Programmer';

-- 4. feladat:
SELECT
	*
FROM
	`programozok`;

-- 5. feladat:
CREATE OR REPLACE VIEW `munkakorletszam` AS
SELECT
	`JOB_TITLE`,
	COUNT(*) AS `db`
FROM
	`employees`
	INNER JOIN `jobs` ON `jobs`.`JOB_ID` = `employees`.`JOB_ID`
GROUP BY
	`jobs`.`JOB_ID`;

-- 6. feladat:
SELECT
	*
FROM
	`munkakorletszam`
WHERE
	`db` >= 20;

-- 7. feladat:
CREATE OR REPLACE VIEW `orszagfo` AS
SELECT
	`COUNTRY_NAME`,
	COUNT(*) AS `fo`
FROM
	`countries`
	INNER JOIN `locations` ON `countries`.`COUNTRY_ID` = `locations`.`COUNTRY_ID`
	INNER JOIN `departments` ON `locations`.`LOCATION_ID` = `departments`.`LOCATION_ID`
	INNER JOIN `employees` ON `departments`.`DEPARTMENT_ID` = `employees`.`DEPARTMENT_ID`
GROUP BY
	`countries`.`COUNTRY_ID`;

-- 8. feladat:
SELECT
	*
FROM
	`orszagfo`;

-- 9. feladat:
CREATE OR REPLACE VIEW `reszlegvezeto` AS
SELECT
	`DEPARTMENT_NAME`,
	CONCAT(`FIRST_NAME`, ' ', `LAST_NAME`) AS `FULL_NAME`
FROM
	`departments`
	INNER JOIN `employees` ON `employees`.`EMPLOYEE_ID` = `departments`.`MANAGER_ID`;

-- 10. feladat:
SELECT
	*
FROM
	`reszlegvezeto`
WHERE
	`FULL_NAME` LIKE '%Den%';

-- 11. feladat:
CREATE OR REPLACE VIEW `kiholdolgozik` AS
SELECT
	`EMPLOYEE_ID`,
	CONCAT(`FIRST_NAME`, ' ', `LAST_NAME`) AS `FULL_NAME`,
	`DEPARTMENT_NAME`,
	`departments`.`DEPARTMENT_ID`
FROM
	`departments`
	INNER JOIN `employees` ON `employees`.`DEPARTMENT_ID` = `departments`.`DEPARTMENT_ID`;

-- 12. feladat:
SELECT
	ROUND(AVG(`SALARY`)) AS `atlag`
FROM
	`employees`
WHERE
	`DEPARTMENT_ID` = (
		SELECT
			`DEPARTMENT_ID`
		FROM
			`kiholdolgozik`
		WHERE
			`FULL_NAME` = 'David Austin'
	);

-- 13. feladat:
CREATE OR REPLACE VIEW `belepo` AS
SELECT
	CONCAT(`FIRST_NAME`, ' ', `LAST_NAME`) AS `FULL_NAME`,
	`HIRE_DATE`
FROM
	`employees`
	INNER JOIN `job_history` ON `job_history`.`JOB_ID` = `employees`.`JOB_ID`;

-- 14. feladat:
SELECT
	*
FROM
	`belepo`;

-- 15. feladat:
CREATE OR REPLACE VIEW `regiovezetok` AS
SELECT
	CONCAT(`FIRST_NAME`, ' ', `LAST_NAME`) AS `FULL_NAME`,
	`HIRE_DATE`,
	`REGION_NAME`
FROM
	`employees`
	INNER JOIN `departments` ON `employees`.`EMPLOYEE_ID` = `departments`.`MANAGER_ID`
	INNER JOIN `locations` ON `departments`.`LOCATION_ID` = `locations`.`LOCATION_ID`
	INNER JOIN `countries` ON `locations`.`COUNTRY_ID` = `countries`.`COUNTRY_ID`
	INNER JOIN `regions` ON `countries`.`REGION_ID` = `regions`.`REGION_ID`;

-- 16. feladat:
SELECT
	*
FROM
	`regiovezetok`;
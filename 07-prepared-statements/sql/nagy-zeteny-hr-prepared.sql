USE `hr`;

-- 3. feladat:
SET @job_id = 'IT_PROG';
SET @city = 'Southlake';
SET @region = 'Americas';
SET @department = 'IT';
SET @country = 'Canada';
SET @minimum = 9000;
SET @maximum = 30000;
SET @table = 'employees';
SET @col = 'FIRST_NAME';

-- 4. feladat:
SELECT
	COUNT(*) as `db`
FROM
	`employees`
WHERE
	`JOB_ID` = @job_id;

-- 5. feladat:
SELECT
	`FIRST_NAME`,
	`LAST_NAME`
FROM
	`employees`
WHERE
	`JOB_ID` = @job_id
	AND DATEDIFF(NOW(), `HIRE_DATE`) > 10 * 365.25;

-- 6. feladat:

-- 7. feladat:

-- 8. feladat:

-- 9. feladat:

-- 10. feladat:

-- 11. feladat:

-- 12. feladat:

-- 13. feladat:

-- 14. feladat:

-- 15. feladat:

-- 16. feladat:

-- 17. feladat:

-- 18. feladat:

-- 19. feladat:

-- 20. feladat:

-- 21. feladat:

-- 22. feladat:

-- 23. feladat:

-- 24. feladat:

-- 25. feladat:

-- 26. feladat:

-- 27. feladat:

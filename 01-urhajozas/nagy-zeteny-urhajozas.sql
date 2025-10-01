-- 2. feladat
DROP DATABASE IF EXISTS `urhajozas`;

CREATE DATABASE IF NOT EXISTS `urhajozas`
CHARACTER SET utf8
COLLATE utf8_hungarian_ci;

-- 3. feladat
USE `urhajozas`;

-- 5. feladat
SELECT
	`nev`,
	`nem`,
	`szulev`
FROM
	`urhajos`;

-- 6. feladat
SELECT
	`megnevezes`,
	DATEDIFF(`veg`, `kezdet`) AS `nap`
FROM
	`kuldetes`;

-- 7. feladat
SELECT
	`nev`,
	YEAR(NOW()) - `szulev` AS `kor`
FROM
	`urhajos`
ORDER BY
	`kor` DESC;

-- 8. feladat
SELECT
	`megnevezes`,
	`nev`
FROM
	`urhajos`
	INNER JOIN `repules` ON `urhajos`.`id` = `urhajos_id`
	INNER JOIN `kuldetes` ON `kuldetes`.`id` = `kuldetes_id`
ORDER BY
	`kezdet` ASC,
	`nev` DESC;

-- 9. feladat
SELECT
	`nev`,
	`szulev`
FROM
	`urhajos`
WHERE
	`nem` = 'N'
	AND `szulev` > 1960
	AND `orszag` = 'CAN';

-- 10. feladat
SELECT
	`nev`
FROM
	`urhajos`
ORDER BY
	LENGTH(`nev`) DESC
LIMIT
	1;

-- 11. feladat
SELECT
	`megnevezes`,
	COUNT(*) AS `fo`
FROM
	`kuldetes`
	INNER JOIN `repules` ON `id` = `kuldetes_id`
GROUP BY
	`id`;

-- 12. feladat
SELECT
	`nev`,
	COUNT(*) AS `db`
FROM
	`urhajos`
	INNER JOIN `repules` ON `id` = `urhajos_id`
GROUP BY
	`id`
HAVING
	`db` >= 6;

-- 13. feladat
SELECT
	ROUND(AVG(`veg` - `kezdet`), 2) AS `Gemini küldetések átlagos hoszzúsága`
FROM
	`kuldetes`
WHERE
	`megnevezes` LIKE '%Gemini%';

-- 14. feladat
SELECT
	`orszag`
FROM
	`urhajos`
	INNER JOIN `repules` ON `urhajos`.`id` = `urhajos_id`
	INNER JOIN `kuldetes` ON `kuldetes`.`id` = `kuldetes_id`
WHERE
	YEAR(`kezdet`) BETWEEN 1991 AND 2000
GROUP BY
	`orszag`
ORDER BY
	COUNT(*) DESC
LIMIT
	3;

-- 15. feladat
SELECT
	COUNT(*) AS `Robik száma`
FROM
	`urhajos`
WHERE
	`nev` LIKE '%Robert%';

-- 16. feladat
SELECT
	`nev`,
	`orszag`,
	`szulev`
FROM
	`urhajos`
WHERE
	`szulev` = (
		SELECT
			`szulev`
		FROM
			`urhajos`
		WHERE
			`nev` = 'Barbara Morgan'
	);

-- 17. feladat, rossz a minta, mintában csak férfiak...
SELECT
	`megnevezes`,
	`kezdet`,
	`veg`
FROM
	`kuldetes`
WHERE
	`id` NOT IN(
		SELECT
			`kuldetes_id`
		FROM
			`urhajos`
			INNER JOIN `repules` ON `urhajos`.`id` = `urhajos_id`
		WHERE
			`nem` = 'F'
	);

-- 18. feladat
DELETE FROM `urhajos`
WHERE
	`nev` = 'Serbán Lajos';

-- 19. feladat
INSERT INTO
	`urhajos` (`id`, `nev`, `orszag`, `nem`, `szulev`, `urido`)
VALUES
	(561, 'Alexander Poleshchuk', 'RUS', 'F', 1953, 'T179:00:43');

-- 20. feladat
ALTER TABLE `kuldetes`
ADD `honapok` INT NULL;

-- 21. feladat
UPDATE `kuldetes`
SET
	`honapok` = TIMESTAMPDIFF(MONTH, `kezdet`, `veg`);

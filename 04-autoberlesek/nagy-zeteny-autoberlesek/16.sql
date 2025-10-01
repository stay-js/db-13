SELECT
	CONCAT(`vnev`, ' ', `knev`) AS `teljes_nev`,
	COUNT(*) AS `kolcsonzesek_szama`
FROM
	`berlesek`
	INNER JOIN `ugyfelek` ON `berlesek`.`ugyfel_id` = `ugyfelek`.`id`
GROUP BY
	`ugyfelek`.`id`
HAVING
	`kolcsonzesek_szama` >= 2
ORDER BY
	`teljes_nev`;
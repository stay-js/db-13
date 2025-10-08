SELECT
	`kezeles_tipus`,
	COUNT(*) AS `kezeles_db`
FROM
	`aktualis_kezelesek`
WHERE
	`kezeles_tipus` IN ('fizikoterápia', 'pszichológia', 'sebészet')
GROUP BY
	`kezeles_tipus`
ORDER BY
	`kezeles_db`;
  
CREATE OR REPLACE VIEW `aktualis_kezelesek` AS
SELECT
	`datum`,
	`kezeles_tipus`,
	`orvos`.`nev`
FROM
	`kezeles`
	INNER JOIN `orvos` ON `orvos_id` = `orvos`.`id`
WHERE
	`datum` >= NOW()
ORDER BY
	`datum` ASC;

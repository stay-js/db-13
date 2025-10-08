CREATE OR REPLACE VIEW `orvos_terheltseg` AS
SELECT
	`nev`,
	COUNT(`kezeles`.`id`) AS `kezeles_db`
FROM
	`orvos`
	LEFT JOIN `kezeles` ON `orvos_id` = `orvos`.`id`
GROUP BY
	`nev`;

SELECT
	*
FROM
	`orvos_terheltseg`;
  
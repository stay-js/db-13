CREATE VIEW `kintlevo` AS
SELECT
	`gyarto`,
	`tipus`,
	`vnev`,
	`knev`,
	`elvitte`
FROM
	`autok`
	INNER JOIN `berlesek` ON `autok`.`id` = `berlesek`.`auto_id`
	INNER JOIN `ugyfelek` ON `berlesek`.`ugyfel_id` = `ugyfelek`.`id`
WHERE
	`visszahozta` = NULL
ORDER BY
	`elvitte` ASC;
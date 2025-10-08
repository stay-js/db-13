SELECT
	`gyarto`,
	`szin`,
	`loero`
FROM
	`autok`
WHERE
	`loero` BETWEEN 201 AND 300
	AND `gyarto` IN ('BMW', 'Honda', 'Ford')
	AND `szin` LIKE '%Kék%'
ORDER BY
	`loero`;
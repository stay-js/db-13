CREATE VIEW `atlagfogyasztas` AS
SELECT
	`gyarto`,
	CONCAT(ROUND(AVG(`fogyasztas`), 1), 'liter / 100km')
from `autok`
GROUP BY
	`gyarto`
ORDER BY
	`gyarto` ASC;
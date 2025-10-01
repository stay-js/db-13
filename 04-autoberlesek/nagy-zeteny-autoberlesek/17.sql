CREATE ROLE 'statisztika'@'%';

GRANT SELECT ON `autoberlesek`.`kintlevo` TO 'statisztika'@'%';
GRANT SELECT ON `autoberlesek`.`gyarto_db` TO 'statisztika'@'%';
GRANT SELECT ON `autoberlesek`.`atlagfogyasztas` TO  'statisztika'@'%';

GRANT 'statisztika'@'%' TO 'elemzo' @'%';
FLUSH PRIVILEGES;

-- SET DEFAULT ROLE 'statisztika' TO 'elemzo'@'%';
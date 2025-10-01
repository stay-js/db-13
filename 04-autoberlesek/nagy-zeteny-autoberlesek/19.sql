CREATE USER 'admin'@'%' IDENTIFIED BY 'admin';

GRANT SELECT, INSERT, UPDATE ON `autoberlesek`.`autok` TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE ON `autoberlesek`.`ugyfelek` TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE ON `autoberlesek`.`berlesek` TO 'admin'@'%';

FLUSH PRIVILEGES;
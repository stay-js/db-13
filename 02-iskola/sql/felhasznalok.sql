CREATE USER 'Ilona'@'localhost' IDENTIFIED BY 'Ilona';
GRANT SELECT, INSERT, UPDATE ON `iskola`.`jegyek` TO 'Ilona'@'localhost';

CREATE USER 'Laci'@'localhost' IDENTIFIED BY 'Laci';
GRANT SELECT, INSERT, UPDATE ON `iskola`.`jegyek` TO 'Laci'@'localhost';

CREATE USER 'Dani'@'localhost' IDENTIFIED BY 'Dani';
GRANT SELECT ON `iskola`.`jegyeim` TO 'Dani'@'localhost';

CREATE USER 'Juci'@'localhost' IDENTIFIED BY 'Juci';
GRANT SELECT ON `iskola`.`jegyeim` TO 'Juci'@'localhost';

CREATE USER 'Kati'@'localhost' IDENTIFIED BY 'Kati';
GRANT SELECT ON `iskola`.`jegyeim` TO 'Kati'@'localhost';

CREATE USER 'Marci'@'localhost' IDENTIFIED BY 'Marci';
GRANT SELECT ON `iskola`.`jegyeim` TO 'Marci'@'localhost';

CREATE USER 'Admin'@'localhost' IDENTIFIED BY 'Admin';
GRANT ALL PRIVILEGES ON `iskola`.* TO 'Admin'@'localhost';

FLUSH PRIVILEGES;
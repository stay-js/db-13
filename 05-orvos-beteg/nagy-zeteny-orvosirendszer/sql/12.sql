CREATE ROLE 'adminisztracio'@'%';

GRANT SELECT ON `orvosirendszer`.`orvos_terheltseg` TO 'adminisztracio'@'%';
GRANT SELECT, UPDATE, INSERT ON `orvosirendszer`.`orvos` TO 'adminisztracio'@'%';

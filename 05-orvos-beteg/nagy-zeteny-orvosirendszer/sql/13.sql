CREATE USER 'peti'@'%' IDENTIFIED BY 'python';

GRANT 'adminisztracio'@'%' TO 'peti'@'%';
SET DEFAULT ROLE 'adminisztracio'@'%' TO 'peti'@'%';

FLUSH PRIVILEGES;

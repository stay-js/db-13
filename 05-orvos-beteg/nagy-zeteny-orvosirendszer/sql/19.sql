CREATE USER 'admin'@'%' IDENTIFIED BY 'admin';
GRANT INSERT, SELECT, DELETE, UPDATE ON `orvosirendszer`.* TO 'admin'@'%';

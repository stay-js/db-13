DROP DATABASE IF EXISTS `dome_db`;

CREATE DATABASE IF NOT EXISTS `dome_db`
CHARACTER SET utf8
COLLATE utf8_hungarian_ci;

USE `dome_db`;


CREATE TABLE `concession_stand` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(48) NOT NULL,
  `cash_registers` INT NOT NULL,
  `preorder` BOOLEAN NOT NULL DEFAULT FALSE,
  `pizza` BOOLEAN NOT NULL DEFAULT FALSE,
  `nuggets` BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE `supervisor` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `phone_number` VARCHAR(20) NOT NULL,
  `student` BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE `supervises` (
  `concession_stand_id` BIGINT NOT NULL,
  `supervisor_id` BIGINT NOT NULL,
  PRIMARY KEY (`concession_stand_id`, `supervisor_id`),
  FOREIGN KEY (`concession_stand_id`) REFERENCES `concession_stand`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`supervisor_id`) REFERENCES `supervisor`(`id`) ON DELETE CASCADE
);

CREATE TABLE `manufacturer` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL
);

CREATE TABLE `product` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `manufacturer_id` BIGINT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `items_per_pack` INT NULL,
  `type` VARCHAR(100) NOT NULL,
  FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturer`(`id`) ON DELETE RESTRICT
);

CREATE TABLE `stock` (
  `concession_stand_id` BIGINT NOT NULL,
  `product_id` BIGINT NOT NULL,
  `amount` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`concession_stand_id`, `product_id`),
  FOREIGN KEY (`concession_stand_id`) REFERENCES `concession_stand`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`product_id`) REFERENCES `product`(`id`) ON DELETE CASCADE
);


INSERT INTO `concession_stand` (`name`, `cash_registers`, `preorder`, `pizza`, `nuggets`) VALUES
('fsz jobb', 4, FALSE, FALSE, FALSE),
('fsz bal', 4, FALSE, FALSE, FALSE),
('201', 6, TRUE, FALSE, TRUE),
('204', 6, FALSE, TRUE, TRUE),
('206', 6, FALSE, TRUE, FALSE),
('207', 6, FALSE, FALSE, FALSE),
('209', 6, TRUE, TRUE, TRUE),
('212', 6, FALSE, FALSE, TRUE),
('214', 4, FALSE, FALSE, FALSE),
('215', 4, FALSE, FALSE, FALSE),
('302/303', 4, FALSE, FALSE, FALSE),
('307', 6, TRUE, FALSE, FALSE),
('308', 6, TRUE, FALSE, FALSE),
('312/313', 4, FALSE, FALSE, FALSE),
('317', 6, FALSE, FALSE, FALSE),
('318', 6, FALSE, FALSE, FALSE);

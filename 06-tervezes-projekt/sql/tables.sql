DROP DATABASE IF EXISTS `dome_db`;

CREATE DATABASE IF NOT EXISTS `dome_db`
CHARACTER SET utf8mb4
COLLATE utf8mb4_hungarian_ci;

USE `dome_db`;


DROP TABLE IF EXISTS `concession_stand`;

CREATE TABLE `concession_stand` (
  `id` bigint UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(48) NOT NULL,
  `cash_registers` int UNSIGNED NOT NULL,
  `preorder` boolean NOT NULL DEFAULT FALSE,
  `pizza` boolean NOT NULL DEFAULT FALSE,
  `nuggets` boolean NOT NULL DEFAULT FALSE
);

DROP TABLE IF EXISTS `supervisor`;

CREATE TABLE `supervisor` (
  `id` bigint UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `student` boolean NOT NULL DEFAULT FALSE
);

DROP TABLE IF EXISTS `supervises`;

CREATE TABLE `supervises` (
  `concession_stand_id` bigint UNSIGNED NOT NULL,
  `supervisor_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`concession_stand_id`, `supervisor_id`),
  FOREIGN KEY (`concession_stand_id`) REFERENCES `concession_stand`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`supervisor_id`) REFERENCES `supervisor`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `manufacturer`;

CREATE TABLE `manufacturer` (
  `id` bigint UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL
);

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `id` bigint UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  `manufacturer_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `items_per_pack` int UNSIGNED NULL,
  `type` varchar(100) NOT NULL,
  FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturer`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
);

DROP TABLE IF EXISTS `stock`;

CREATE TABLE `stock` (
  `concession_stand_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `amount` int UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`concession_stand_id`, `product_id`),
  FOREIGN KEY (`concession_stand_id`) REFERENCES `concession_stand`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`product_id`) REFERENCES `product`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

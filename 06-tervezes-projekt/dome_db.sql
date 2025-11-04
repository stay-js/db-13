DROP DATABASE IF EXISTS `dome_db`;

CREATE DATABASE IF NOT EXISTS `dome_db`
CHARACTER SET utf8
COLLATE utf8_hungarian_ci;

USE `dome_db`;


DROP TABLE IF EXISTS `concession_stand`;

CREATE TABLE `concession_stand` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(48) NOT NULL,
  `cash_registers` INT NOT NULL,
  `preorder` BOOLEAN NOT NULL DEFAULT FALSE,
  `pizza` BOOLEAN NOT NULL DEFAULT FALSE,
  `nuggets` BOOLEAN NOT NULL DEFAULT FALSE
);

DROP TABLE IF EXISTS `supervisor`;

CREATE TABLE `supervisor` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `phone_number` VARCHAR(20) NOT NULL,
  `student` BOOLEAN NOT NULL DEFAULT FALSE
);

DROP TABLE IF EXISTS `supervises`;

CREATE TABLE `supervises` (
  `concession_stand_id` BIGINT NOT NULL,
  `supervisor_id` BIGINT NOT NULL,
  PRIMARY KEY (`concession_stand_id`, `supervisor_id`),
  FOREIGN KEY (`concession_stand_id`) REFERENCES `concession_stand`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`supervisor_id`) REFERENCES `supervisor`(`id`) ON DELETE CASCADE
);

DROP TABLE IF EXISTS `manufacturer`;

CREATE TABLE `manufacturer` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `manufacturer_id` BIGINT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `items_per_pack` INT NULL,
  `type` VARCHAR(100) NOT NULL,
  FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturer`(`id`) ON DELETE RESTRICT
);

DROP TABLE IF EXISTS `stock`;

CREATE TABLE `stock` (
  `concession_stand_id` BIGINT NOT NULL,
  `product_id` BIGINT NOT NULL,
  `amount` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`concession_stand_id`, `product_id`),
  FOREIGN KEY (`concession_stand_id`) REFERENCES `concession_stand`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`product_id`) REFERENCES `product`(`id`) ON DELETE CASCADE
);


INSERT INTO `concession_stand` (`id`, `name`, `cash_registers`, `preorder`, `pizza`, `nuggets`) VALUES
(1, 'fsz jobb', 4, FALSE, FALSE, FALSE),
(2, 'fsz bal', 4, FALSE, FALSE, FALSE),
(3, '201', 6, TRUE, FALSE, TRUE),
(4, '204', 6, FALSE, TRUE, TRUE),
(5, '206', 6, FALSE, TRUE, FALSE),
(6, '207', 6, FALSE, FALSE, FALSE),
(7, '209', 6, TRUE, TRUE, TRUE),
(8, '212', 6, FALSE, FALSE, TRUE),
(9, '214', 4, FALSE, FALSE, FALSE),
(10, '215', 4, FALSE, FALSE, FALSE),
(11, '302/303', 4, FALSE, FALSE, FALSE),
(12, '307', 6, TRUE, FALSE, FALSE),
(13, '308', 6, TRUE, FALSE, FALSE),
(14, '312/313', 4, FALSE, FALSE, FALSE),
(15, '317', 6, FALSE, FALSE, FALSE),
(16, '318', 6, FALSE, FALSE, FALSE);

INSERT INTO `supervisor` (`id`, `name`, `email`, `phone_number`, `student`) VALUES
(1, 'Berek András', 'berek.andras@rampart.hu', '+36 30 612 4832', TRUE),
(2, 'Francz Anna', 'francz.anna@rampart.hu', '+36 20 347 5981', TRUE),
(3, 'Balgoh Benjámin', 'balgoh.benjamin@rampart.hu', '+36 50 271 4356', TRUE),
(4, 'Balogh Márk', 'balogh.mark@rampart.hu', '+36 70 842 1395', FALSE),
(5, 'Baukó Milán', 'bauko.milan@rampart.hu', '+36 30 679 5210', TRUE),
(6, 'Garczik Bence', 'garczik.bence@rampart.hu', '+36 70 213 4697', TRUE),
(7, 'Borsós Bernadett', 'borsos.bernadett@rampart.hu', '+36 20 876 5124', FALSE),
(8, 'Béres Réka', 'beres.reka@rampart.hu', '+36 30 598 7241', TRUE),
(9, 'Józsa Dániel', 'jozsa.daniel@rampart.hu', '+36 70 963 8540', TRUE),
(10, 'Galambos Edit', 'galambos.edit@rampart.hu', '+36 50 235 4178', FALSE),
(11, 'Mojzes Elvira', 'mojzes.elvira@rampart.hu', '+36 20 358 7641', TRUE),
(12, 'Panyák Emma', 'panyak.emma@rampart.hu', '+36 30 785 4209', TRUE),
(13, 'Farkas Viktória', 'farkas.viktoria@rampart.hu', '+36 70 612 3479', TRUE),
(14, 'Peszleny Ivett', 'peszleny.ivett@rampart.hu', '+36 30 879 5614', TRUE),
(15, 'Kinicsné Gál Gabriella', 'kinicsne.gal.gabriella@rampart.hu', '+36 50 479 3268', FALSE),
(16, 'Máté Kitti', 'mate.kitti@rampart.hu', '+36 30 564 7931', TRUE),
(17, 'Róka Melinda', 'roka.melinda@rampart.hu', '+36 20 934 6720', TRUE),
(18, 'Majercsik Máté', 'majercsik.mate@rampart.hu', '+36 70 851 9042', TRUE),
(19, 'Mihály Máté', 'mihaly.mate@rampart.hu', '+36 20 327 9518', TRUE),
(20, 'Varga Laura', 'varga.laura@rampart.hu', '+36 30 769 1420', TRUE),
(21, 'Makkay Olivér', 'makkay.oliver@rampart.hu', '+36 70 921 3854', TRUE),
(22, 'Tóth Szabolcs', 'toth.szabolcs@rampart.hu', '+36 50 682 9147', TRUE),
(23, 'Vetró Vivien', 'vetro.vivien@rampart.hu', '+36 30 613 5890', TRUE),
(24, 'Katona Villő', 'katona.villo@rampart.hu', '+36 20 715 3948', TRUE),
(25, 'Deli Zsolt', 'deli.zsolt@rampart.hu', '+36 70 254 8963', TRUE),
(26, 'Szegi Zsófia', 'szegi.zsofia@rampart.hu', '+36 30 932 7645', TRUE),
(27, 'Nagy Zétény', 'nagy.zeteny@rampart.hu', '+36 50 384 2197', TRUE);

INSERT INTO `supervises` (`concession_stand_id`, `supervisor_id`) VALUES
(3, 1),   -- Berek András - 201
(14, 1),  -- Berek András - 312/313
(7, 2),   -- Francz Anna - 209
(4, 3),   -- Balgoh Benjámin - 204
(4, 4),   -- Balogh Márk - 204
(14, 5),  -- Baukó Milán - 312/313
(13, 6),  -- Garczik Bence - 308
(4, 7),   -- Borsós Bernadett - 204
(7, 8),   -- Béres Réka - 209
(6, 9),   -- Józsa Dániel - 207
(6, 10),  -- Galambos Edit - 207
(15, 11), -- Mojzes Elvira - 317
(7, 12),  -- Panyák Emma - 209
(16, 13), -- Farkas Viktória - 318
(12, 14), -- Peszleny Ivett - 307
(1, 15),  -- Kinicsné Gál Gabriella - fsz jobb
(9, 16),  -- Máté Kitti - 214
(2, 16),  -- Máté Kitti - fsz bal
(11, 17), -- Róka Melinda - 302/303
(5, 18),  -- Majercsik Máté - 206
(10, 19), -- Mihály Máté - 215
(2, 20),  -- Varga Laura - fsz bal
(9, 21),  -- Makkay Olivér - 214
(6, 22),  -- Tóth Szabolcs - 207
(13, 23), -- Vetró Vivien - 308
(7, 24),  -- Katona Villő - 209
(5, 25),  -- Deli Zsolt - 206
(8, 26),  -- Szegi Zsófia - 212
(3, 27),  -- Nagy Zétény - 201
(14, 27); -- Nagy Zétény - 312/313
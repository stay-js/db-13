DROP TABLE IF EXISTS `kezeles`;

CREATE TABLE `kezeles` (
    `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `orvos_id` int NOT NULL,
    `paciens_id` int NOT NULL,
    `datum` date NOT NULL,
    `diagnozis` text NOT NULL,
    `kezeles_tipus` varchar(100) NOT NULL
);
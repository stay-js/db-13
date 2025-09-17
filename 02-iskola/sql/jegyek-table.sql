CREATE TABLE `jegyek` (
	`id` int NOT NULL,
	`tantargy_id` int NOT NULL,
	`jegy` int NOT NULL,
	`diak` varchar(20) NOT NULL,
	`tanar` varchar(20) NOT NULL,
	`beirva` DATE NOT NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`tantargy_id`) REFERENCES `tantargyak` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_hungarian_ci;
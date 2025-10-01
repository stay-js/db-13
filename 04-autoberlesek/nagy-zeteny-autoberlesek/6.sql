CREATE TABLE `berlesek` (
	`auto_id` int NOT NULL,
	`ugyfel_id` int NOT NULL,
	`elvitte` datetime NOT NULL,
	`visszahozta` datetime DEFAULT NULL,
	PRIMARY KEY (`auto_id`, `ugyfel_id`),
	FOREIGN KEY (`auto_id`) REFERENCES `autok` (`id`),
	FOREIGN KEY (`ugyfel_id`) REFERENCES `ugyfelek` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_hungarian_ci;

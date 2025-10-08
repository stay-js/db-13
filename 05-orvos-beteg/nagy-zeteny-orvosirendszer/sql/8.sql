ALTER TABLE `kezeles`
ADD CONSTRAINT `fk_kezeles_paciens` FOREIGN KEY (`paciens_id`) REFERENCES `paciens` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `kezeles`
ADD CONSTRAINT `fk_kezeles_orvos` FOREIGN KEY (`orvos_id`) REFERENCES `orvos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
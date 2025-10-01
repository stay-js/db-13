ALTER TABLE `berlesek`
ADD CONSTRAINT `fk_berlesek_autok` FOREIGN KEY (`auto_id`) REFERENCES `autok` (`id`) ON DELETE RESTRICT;
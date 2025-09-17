# Iskola

## Konzol és felhasználó kezelés

### 2. feladat

```bash
docker run --name db -p 3306:3306 -e MYSQL_ROOT_PASSWORD=pass -v "$(pwd)/sql:/sql:ro" -d mysql:9

docker exec -it db mysql -p
```

### 3. feladat

```mysql
DROP DATABASE IF EXISTS `iskola`;

CREATE DATABASE IF NOT EXISTS `iskola`
CHARACTER SET utf8
COLLATE utf8_hungarian_ci;
```

### 4. feladat

```mysql
SHOW DATABASES;
```

### 5. feladat

```mysql
USE `iskola`;
```

### 7. feladat

```bash
source /sql/tantargyak-table.sql
```

### 9. feladat

```bash
source /sql/jegyek-table.sql
```

### 10. feladat

```mysql
CREATE VIEW `jegyeim` AS
SELECT
	*
FROM
	`jegyek`
WHERE
	`diak` = SUBSTRING_INDEX(USER(), '@', 1);
```

### 11. feladat

```mysql
SHOW TABLES;
```

### 13. feladat

```bash
source /sql/felhasznalok.sql
```

### 14. feladat

```bash
docker exec -it db mysql -uAdmin -p
```

```mysql
USE `iskola`;

INSERT INTO `tantargyak` (`id`, `nev`) VALUES
(1, 'Matematika'),
(2, 'Backend programozás'),
(3, 'Történelem'),
(4, 'Fizika');
```

### 15. feladat

```bash
docker exec -it db mysql -uLaci -p
```

```mysql
USE `iskola`;

INSERT INTO `jegyek` (`tantargy_id`, `jegy`, `diak`, `tanar`, `beirva`) VALUES
(1, 5, 'Dani',  SUBSTRING_INDEX(USER(), '@', 1), NOW()),
(2, 4, 'Juci',  SUBSTRING_INDEX(USER(), '@', 1), NOW()),
(3, 3, 'Kati',  SUBSTRING_INDEX(USER(), '@', 1), NOW());

UPDATE `jegyek` SET `jegy` = 3 WHERE `id` = 1;
```

### 16. feladat

```bash
docker exec -it db mysql -uDani -p
```

```mysql
USE `iskola`;

SELECT * FROM `jegyeim`;
```

### 17. feladat

```bash
docker exec -it db mysql -uAdmin -p
```

```mysql
USE `iskola`;

UPDATE `jegyek` SET `jegy` = 4 WHERE `id` = 1;
```

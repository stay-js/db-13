2.

```bash
docker run --name db -p 3306:3306 -e MYSQL_ROOT_PASSWORD=pass -v "$(pwd)/sql:/sql:ro" -d mysql:9

docker exec -it db mysql -p
```

3.

```mysql
DROP DATABASE IF EXISTS `iskola`;

CREATE DATABASE IF NOT EXISTS `iskola`
CHARACTER SET utf8
COLLATE utf8_hungarian_ci;
```

4.

```mysql
SHOW DATABASES;
```

5.

```mysql
USE `iskola`;
```

7.

```bash
source /sql/tantargyak-table.sql
```

9.

```bash
source /sql/jegyek-table.sql
```

10.

```mysql
CREATE VIEW `jegyeim` AS
SELECT
	*
FROM
	`jegyek`
WHERE
	`diak` = SUBSTRING_INDEX(USER(), '@', 1);
```

11.

```mysql
SHOW TABLES;
```

13.

```bash
source /sql/felhasznalok.sql
```

14.

```bash
docker exec -it db mysql -uAdmin -p
```

```mysql
INSERT INTO `tantargyak` (`id`, `nev`) VALUES
(1, 'Matematika'),
(2, 'Backend programozás'),
(3, 'Történelem'),
(4, 'Fizika');
```

15.

```bash
docker exec -it db mysql -uLaci -p
```

```mysql
INSERT INTO `jegyek` (`id`, `tantargy_id`, `jegy`, `diak`, `tanar`, `beirva`) VALUES
(1, 1, 5, 'Dani',  SUBSTRING_INDEX(USER(), '@', 1), NOW()),
(2, 2, 4, 'Juci',  SUBSTRING_INDEX(USER(), '@', 1), NOW()),
(3, 3, 3, 'Kati',  SUBSTRING_INDEX(USER(), '@', 1), NOW());
```

16.

```bash
docker exec -it db mysql -uDani -p
```

```mysql

SELECT * FROM `jegyeim`;
```

17.

```bash
docker exec -it db mysql -uAdmin -p
```

```mysql

UPDATE `jegyek` SET `jegy` = 4 WHERE `id` = 1;
```

# Orvos-beteg

## Felhasználókezelés, Nézettáblák

### 2. feladat

```bash
docker run --name orvosirendszer -p 3306:3306 -e MYSQL_ROOT_PASSWORD=pass -v "$(pwd)/sql:/sql:ro" -d mysql:9.3

docker exec -it orvosirendszer mysql -p
```

### 7. feladat

```bash
source sql/tablak.sql;
source sql/adatok.sql;
```

### 14. feladat

```bash
docker exec -it orvosirendszer mysql -upeti -p
```

```sql
use `orvosirendszer`;

SHOW TABLES;
```

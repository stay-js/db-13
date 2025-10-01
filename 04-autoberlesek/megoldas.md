# Autóbérlések

## Felhasználókezelés, Nézettáblák

### 2. feladat

```bash
docker run --name berles -p 3306:3306 -e MYSQL_ROOT_PASSWORD=pass -v "$(pwd)/sql:/sql:ro" -d mysql:9.3

docker exec -it berles mysql -p
```

### 7. feladat

6. feladat előtt

```bash
source /sql/tablak.sql
```

6. feladat után

```bash
source /sql/adatok.sql
```

### 18. feladat

```bash
docker exec -it berles mysql -uelemzo -p
```

```sql
USE `autoberlesek`;
SHOW TABLES;
```

### 20. feladat

```bash
docker exec -it berles mysql -uadmin -p
```

```sql
USE `autoberlesek`;
```

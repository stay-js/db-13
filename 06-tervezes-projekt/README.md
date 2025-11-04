# Adatbázis tervezés projekt

## MVM Dome - leltár, pultok, pultvezetők nyilvántartása

[Terv és relációk](dome_db.pdf)

```bash
docker run --name dome -p 3306:3306 -e MYSQL_ROOT_PASSWORD=pass -v "$(pwd)/sql:/sql:ro" -d mysql:9.3

docker exec -it dome mysql -p
```

```bash
source sql/tables.sql;
source sql/data.sql;
```

# Docker adatbázis

## Adatbázis létrehozása:

```bash
docker run --name [nev] -p 3306:3306 -e MYSQL_ROOT_PASSWORD=[jelszo] -d mysql:9.3
```

Volume felcsatolásával:

```bash
docker run --name [nev] -p 3306:3306 -e MYSQL_ROOT_PASSWORD=[jelszo] -v "$(pwd)/sql:/sql:ro" -d mysql:9.3
```

## Adatbázis elindulásának ellenőrzése, logok megtekintése:

```bash
docker logs [nev]
```

## Adatbázis leállítása:

```bash
docker stop [nev]
```

## Adatbázis törlése:

```bash
docker rm -f [nev]
```

## Adatbázis elérése terminálból:

```bash
docker exec -it [nev] mysql -p
```

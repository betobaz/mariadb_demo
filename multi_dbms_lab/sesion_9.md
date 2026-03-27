# Sesión 9

Cambiar al branch multimotor
```
git checkout multi-motor
# Cambiar al directorio multi_dbms_lab
cd multi_dbms_lab 
# Revisar que los contenedores de docker estan corriendo
docker ps --format 'table {{.Names}}\t{{.Status}}'
docker compose up -d

```

## Log de errores — dónde encontrarlo:

```
# MariaDB — ruta configurada en my.cnf

docker exec lab_mariadb mysql -uroot -pmysqlroot \
  -e "SHOW VARIABLES LIKE 'log_error';"

docker exec lab_mariadb tail -30 /var/log/mysql/error.log

# PostgreSQL — ver cuál es el directorio de logs

docker exec lab_postgres psql -U dba_user -d labdb \
  -c "SHOW log_directory; SHOW log_filename;"

docker exec lab_postgres tail -30 /var/log/postgresql-$(date +%Y-%m-%d).log

```

## Slow Query Log — activar y leer:

```
docker exec -it lab_mariadb bash
mysql -uroot -pmysqlroot

SHOW VARIABLES LIKE 'slow_query_log%';
SHOW VARIABLES LIKE 'long_query_time';

# Abrir otra ventana y ejecutar
tail -f /var/log/mysql/slow.log

# En la primer ventana ejecutar 
SELECT SLEEP(1);

# Salir del contenedor
exit # De la base de datos
exit # Del contenedor
```

### Postgresql
```
docker exec -it lab_postgres bash
psql -U dba_user -d labdb

ALTER SYSTEM SET log_min_duration_statement = 500;
SELECT pg_reload_conf();

# Abrir otra ventana y ejecutar
tail -f postgresql-2026-03-26.log | grep duration:

# En la primer ventana ejecutar 
SELECT pg_sleep(1);

# Salir del contenedor
exit # De la base de datos
exit # Del contenedor
```

## Binary Log

### Maria DB

```
docker exec lab_mariadb mysql -uroot -pmysqlroot \
  -e "SHOW VARIABLES LIKE 'log_bin%'; SHOW BINARY LOGS;"

# Leer con mysqlbinlog (herramienta externa)
docker exec lab_mariadb mysqlbinlog /var/log/mysql/binlog.000003 | head -50

```
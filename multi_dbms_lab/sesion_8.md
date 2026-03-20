
**Confirmar que `innodb_file_per_table` está activo** (viene de `mysql/my.cnf`):
```bash
docker exec lab_mariadb mysql -uroot -pmysqlroot \
  -e "SHOW VARIABLES LIKE 'innodb_file_per_table';"
# Esperado: ON
```

```bash
docker exec -it lab_mariadb bash
cat /etc/mysql/conf.d/lab.cnf | grep innodb
```

**Consultar metadatos de almacenamiento:**
```bash
docker exec lab_mariadb mysql -uroot -pmysqlroot \
  -e "SELECT TABLE_NAME, ENGINE, DATA_LENGTH, INDEX_LENGTH,
             ROUND((DATA_LENGTH+INDEX_LENGTH)/1024/1024,2) AS total_MB
      FROM information_schema.TABLES
      WHERE TABLE_SCHEMA = 'labdb';"
```

**Ver los tablespaces del sistema (ibdata, undo, temp):**
```bash
# MariaDB usa INNODB_SYS_TABLESPACES (con prefijo SYS) y SPACE en lugar de SPACE_ID
docker exec lab_mariadb mysql -uroot -pmysqlroot \
  -e "SELECT SPACE, NAME, FILE_SIZE, ALLOCATED_SIZE
      FROM information_schema.INNODB_SYS_TABLESPACES
      ORDER BY SPACE;"
```


### Demo 2 — Estructura de archivos en PostgreSQL

**Encontrar el OID de `labdb`:**
```bash
docker exec lab_postgres psql -U dba_user -d labdb \
  -c "SELECT oid, datname FROM pg_database WHERE datname = 'labdb';"
```

**Ver el directorio físico de la base de datos:**
```bash
# Sustituir <OID> por el número devuelto arriba
docker exec lab_postgres ls -lh /var/lib/postgresql/data/base/<OID>/ | head -20
# Cada número es el relfilenode de una tabla o índice
```

**Relacionar el relfilenode con el nombre de la tabla:**
```bash
docker exec lab_postgres psql -U dba_user -d labdb -c \
  "SELECT relname, relfilenode, relpages, relkind
   FROM pg_class
   WHERE relname IN ('empleados', 'empleados_pkey')
   ORDER BY relname;"
```

**Confirmar la ruta completa del archivo de la tabla:**
```bash
docker exec lab_postgres psql -U dba_user -d labdb \
  -c "SELECT pg_relation_filepath('empleados');"
# Devuelve: base/<OID>/<relfilenode>
```
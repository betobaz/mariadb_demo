
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
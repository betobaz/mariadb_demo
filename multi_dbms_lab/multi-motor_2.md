# Comparar configuración activa 

## MySQL — variables de memoria y logging
```
docker exec lab_mariadb mysql -uroot -pmysqlroot \
  -e "SHOW VARIABLES LIKE 'innodb_buffer%';
       SHOW VARIABLES LIKE 'character_set%';
       SHOW VARIABLES LIKE 'max_connections';
       SHOW VARIABLES LIKE 'slow_query%';"
```

## PostgreSQL — variables equivalentes
```
docker exec lab_postgres psql -U dba_user -d labdb -c \
  "SHOW shared_buffers;
   SHOW work_mem;
   SHOW max_connections;
   SHOW log_min_duration_statement;
   SHOW server_encoding;"
```

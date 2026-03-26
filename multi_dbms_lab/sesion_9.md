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
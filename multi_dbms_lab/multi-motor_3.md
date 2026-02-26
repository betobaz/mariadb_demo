# Comparar modelo de procesos  

## MySQL — modelo multi-hilo (un solo proceso mysqld)
```
docker exec lab_mariadb ps aux
```
Esperado: ver UN proceso mysqld principal

## Ver hilos activos de MySQL
```
docker exec lab_mariadb mysql -uroot -pmysqlroot \
  -e "SELECT COUNT(*) as total_threads FROM performance_schema.threads;
       SELECT name, type FROM performance_schema.threads
       WHERE type='BACKGROUND' ORDER BY name;"
```

## PostgreSQL — modelo multi-proceso (un proceso por conexión)
```
docker exec lab_postgres ps aux
```
Esperado: ver postmaster + procesos de background (checkpointer, bgwriter, etc.)

## Procesos de background de PostgreSQL
```
docker exec lab_postgres psql -U dba_user -d labdb \
  -c "SELECT pid, backend_type, state
       FROM pg_stat_activity ORDER BY backend_type;"
```

## Estadísticas de recursos de ambos
```
docker stats lab_mariadb lab_postgres --no-stream
```

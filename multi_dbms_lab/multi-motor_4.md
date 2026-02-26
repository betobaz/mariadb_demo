# Operaciones comparativas 

## Consulta básica MySQL
```
docker exec lab_mariadb mysql -udba_user -pdbapass labdb \
  -e "SELECT COUNT(*) as total, AVG(salario) as salario_promedio,
       MAX(salario) as maximo, MIN(salario) as minimo
       FROM empleados;"
```
## Consulta básica PostgreSQL
```
docker exec lab_postgres psql -U dba_user -d labdb \
  -c "SELECT COUNT(*) as total, ROUND(AVG(salario),2) as salario_promedio,
       MAX(salario) as maximo, MIN(salario) as minimo
       FROM empleados;"
```

## EXPLAIN ANALYZE — comparar planes de ejecución 
### MySQL:
```
docker exec lab_mariadb mysql -udba_user -pdbapass labdb \
  -e "EXPLAIN SELECT * FROM empleados WHERE departamento='TI';"
```

### PostgreSQL:
```
docker exec lab_postgres psql -U dba_user -d labdb \
  -c "EXPLAIN ANALYZE SELECT * FROM empleados WHERE departamento='TI';"
```

## Crear índice y comparar nuevamente
### MySQL:
```
docker exec lab_mariadb mysql -udba_user -pdbapass labdb \
  -e "CREATE INDEX idx_depto ON empleados(departamento);"
```

### PostgreSQL:
```
docker exec lab_postgres psql -U dba_user -d labdb \
  -c "CREATE INDEX idx_depto ON empleados(departamento);"
```
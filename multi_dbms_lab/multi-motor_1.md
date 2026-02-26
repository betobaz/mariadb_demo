# Comparar estructura de directorios 

1. Preparación del Entorno
```
docker pull mysql:10.11
docker pull postgres:16
```

2. Levantar el stack
```
cd multi_dbms_lab
docker compose up -d

# Verificar que ambos están healthy
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'

# Ver logs de arranque
docker logs lab_mariadb  --tail 20
docker logs lab_postgres --tail 20
```

3. Comparar estructura de directirios
```
# MySQL datadir
docker exec lab_mariadb ls -lh /var/lib/mysql/
docker exec lab_mariadb du -sh /var/lib/mysql/

# PostgreSQL PGDATA
docker exec lab_postgres ls -lh /var/lib/postgresql/data/
docker exec lab_postgres du -sh /var/lib/postgresql/data/
```

Preguntas:
1. ¿Cuántos archivos genera cada motor en el directorio raíz?
2. ¿Dónde está el WAL en cada motor?
3. ¿Puedes identificar el directorio de tu BD 'labdb' en cada motor?

# MySQL: directorio labdb/ con los .ibd
docker exec lab_mariadb ls -lh /var/lib/mysql/labdb/

# PostgreSQL: buscar el OID de labdb y listar su contenido
```
docker exec lab_postgres psql -U dba_user -d labdb \
  -c "SELECT oid, datname FROM pg_database WHERE datname='labdb';"
```
 Luego: docker exec lab_postgres ls /var/lib/postgresql/data/base/&lt;OID&gt;/


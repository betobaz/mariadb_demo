1. Preparación del Entorno
```
docker pull mysql:8.0
docker pull postgres:16
```

2. Levantar el stack
```
cd multi_dbms_lab
docker compose up -d

# Verificar que ambos están healthy
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'

# Ver logs de arranque
docker logs lab_mysql  --tail 20
docker logs lab_postgres --tail 20
```

3. Comparar estructura de directirios
```
# MySQL datadir
docker exec lab_mysql ls -lh /var/lib/mysql/
docker exec lab_mysql du -sh /var/lib/mysql/

# PostgreSQL PGDATA
docker exec lab_postgres ls -lh /var/lib/postgresql/data/
docker exec lab_postgres du -sh /var/lib/postgresql/data/
```

Preguntas:
1. ¿Cuántos archivos genera cada motor en el directorio raíz?
2. ¿Dónde está el WAL en cada motor?
3. ¿Puedes identificar el directorio de tu BD 'labdb' en cada motor?

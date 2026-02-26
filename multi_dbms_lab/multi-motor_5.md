# Ver el log completo de arranque
docker exec lab_mariadb cat /var/log/mysql/error.log

# Filtrar solo líneas de sistema e inicialización
docker exec lab_mariadb grep -E '\[System\]|\[ERROR\]|\[Warning\]' \
  /var/log/mysql/error.log | head -30

# ✅ MENSAJES DE ÉXITO — esto debe aparecer:
[System] [MY-010931] ... mysqld: ready for connections. Version: '8.0.x'
[System] [MY-011323] ... X Plugin ready for connections.
[System] [MY-010116] ... Starting as process <PID>

# ✅ MENSAJES DE INICIALIZACIÓN NORMAL:
[Note] InnoDB: Buffer pool(s) load completed
[Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins

# ❌ MENSAJES DE ERROR — investigar inmediatamente:
[ERROR] [MY-012271] ... innodb_buffer_pool_size ... exceeds
[ERROR] [MY-013183] ... Aborting
[ERROR] Can't start server: Bind on TCP/IP port. Address already in use
[ERROR] Plugin 'InnoDB' registration as a STORAGE ENGINE failed.

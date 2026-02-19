Paso 2
```
ps axu
```

Paso 3
```
mariadb -uroot -pdemo123

-- Ver el tamaño configurado del Buffer Pool
SHOW VARIABLES LIKE 'innodb_buffer_pool_size';

-- Ver el estado actual del Buffer Pool
SHOW STATUS LIKE 'Innodb_buffer_pool%';

-- Ver variables de memoria de la sesión
SHOW VARIABLES LIKE '%sort_buffer%';
SHOW VARIABLES LIKE '%join_buffer%';
```
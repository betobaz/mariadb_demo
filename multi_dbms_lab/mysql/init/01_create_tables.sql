CREATE TABLE IF NOT EXISTS empleados (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    departamento    VARCHAR(50),
    salario         DECIMAL(10, 2),
    fecha_ingreso   DATE,
    activo          TINYINT(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insertar 1000 registros de prueba
INSERT INTO empleados (nombre, departamento, salario, fecha_ingreso)
SELECT
  CONCAT('Empleado_', n),
  ELT(1 + (n % 5), 'TI','Ventas','RRHH','Finanzas','Operaciones'),
  ROUND(20000 + RAND() * 80000, 2),
  DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 1825) DAY)
FROM (SELECT @n := @n + 1 AS n FROM information_schema.columns
      CROSS JOIN (SELECT @n := 0) init LIMIT 1000) nums;

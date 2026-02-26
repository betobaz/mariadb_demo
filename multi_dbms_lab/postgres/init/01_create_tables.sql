CREATE TABLE IF NOT EXISTS empleados (
    id              SERIAL PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    departamento    VARCHAR(50),
    salario         DECIMAL(10, 2),
    fecha_ingreso   DATE,
    activo          BOOLEAN DEFAULT TRUE
);

-- Insertar 1000 registros de prueba
INSERT INTO empleados (nombre, departamento, salario, fecha_ingreso)
SELECT
  'Empleado_' || n,
  (ARRAY['TI','Ventas','RRHH','Finanzas','Operaciones'])[1 + (n % 5)],
  ROUND((20000 + random() * 80000)::numeric, 2),
  CURRENT_DATE - (random() * 1825)::int
FROM generate_series(1, 1000) AS s(n);

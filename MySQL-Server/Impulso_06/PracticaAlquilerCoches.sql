# DROP DATABASE alquiler_coches;
Create Database alquiler_coches;
use alquiler_coches;

Create table coches(
	id INT AUTO_INCREMENT,
    marca VARCHAR(30) NOT NULL,
    modelo VARCHAR(30) NOT NULL,
    combustible VARCHAR(20) NOT NULL,
    matricula VARCHAR(10) NOT NULL UNIQUE,
    color VARCHAR(20) NOT NULL,
    precio_por_dia DECIMAL(5,2) NOT NULL,
    alquilado DATE,
    PRIMARY KEY (id)
    );
Create table clientes(
	id INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    dni VARCHAR(9) UNIQUE NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(12) NOT NULL,
    PRIMARY KEY (id)
    );
Create table miembros(
	id INT AUTO_INCREMENT,
    fk_id_cliente INT NOT NULL,
    fecha_alta DATE NOT NULL,
	PRIMARY KEY (id),
    FOREIGN KEY (fk_id_cliente)
    REFERENCES clientes(id)
);
    
Create table alquiler(
	id INT AUTO_INCREMENT,
    fk_id_cliente INT NOT NULL,
    fk_id_coche INT NOT NULL,
    precio_final DECIMAL(9,2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY( fk_id_cliente)
    REFERENCES clientes(id),
	FOREIGN KEY (fk_id_coche)
    REFERENCES coches(id)
);

-- ----------------- TEST -----------------------------------------------------------

-- 🚗 Insertar coches
INSERT INTO coches (marca, modelo, combustible, matricula, color, precio_por_dia, alquilado)
VALUES 
('Toyota', 'Corolla', 'Gasolina', '1234ABC', 'Rojo', 45.50, NULL),
('Tesla', 'Model 3', 'Eléctrico', '5678DEF', 'Negro', 85.00, NULL),
('Volkswagen', 'Golf', 'Diésel', '9012GHI', 'Blanco', 55.25, '2025-10-01');

-- 👤 Insertar clientes
INSERT INTO clientes (nombre, apellidos, dni, email, telefono)
VALUES 
('Laura', 'Martínez López', '12345678A', 'laura@example.com', '600123456'),
('Carlos', 'Gómez Ruiz', '87654321B', 'carlos@example.com', '600654321');

-- 🧑‍🤝‍🧑 Insertar miembros
INSERT INTO miembros (fk_id_cliente, fecha_alta)
VALUES 
(1, '2025-09-15'),
(2, '2025-09-20');

-- 📅 Insertar alquileres
INSERT INTO alquiler (fk_id_cliente, fk_id_coche, precio_final, fecha_inicio, fecha_fin)
VALUES 
(1, 2, 255.00, '2025-10-01', '2025-10-04'),
(2, 1, 91.00, '2025-10-02', '2025-10-04');


-- -------------------------🔍 Consultas de verificación -----------------------------------------------

# Ver todos los coches disponibles
SELECT * FROM coches WHERE alquilado IS NULL;

# Ver todos los alquileres con nombre del cliente y coche
SELECT a.id, c.nombre, c.apellidos, ch.marca, ch.modelo, a.precio_final, a.fecha_inicio, a.fecha_fin
FROM alquiler a
JOIN clientes c ON a.fk_id_cliente = c.id
JOIN coches ch ON a.fk_id_coche = ch.id;

# Ver miembros activos
SELECT m.id, c.nombre, c.apellidos, m.fecha_alta
FROM miembros m
JOIN clientes c ON m.fk_id_cliente = c.id;

# Ver coches alquilados actualmente
SELECT * FROM coches WHERE alquilado IS NOT NULL;
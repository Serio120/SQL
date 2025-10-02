Create Database alquiler_coches_equipo;
use alquiler_coches_equipo;

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
    ON DELETE CASCADE
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

Create table Copia_Clientes(
	id_Copia_Clientes INT AUTO_INCREMENT,
    cambio VARCHAR(100),
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    dni VARCHAR(9) UNIQUE NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(12) NOT NULL,
    PRIMARY KEY (id_Copia_Clientes)
    );
    
DELIMITER //
CREATE TRIGGER copiarClienteBorrado
BEFORE DELETE ON clientes
FOR EACH ROW
BEGIN 
INSERT INTO Copia_Clientes VALUES (NULL, CONCAT("Cliente Borrado", OLD.id), OLD.nombre, OLD.apellidos, OLD.dni, OLD.email, OLD.telefono);
END // 
DELIMITER ;

Create table copia_Miembros(
	id_Copia_Miembro INT AUTO_INCREMENT,
    cambio VARCHAR(100),
    fk_id_cliente INT NOT NULL,
    fecha_alta DATE NOT NULL,
	PRIMARY KEY (id_Copia_Miembro),
    FOREIGN KEY (fk_id_cliente)
    REFERENCES clientes(id)
);

DELIMITER //
CREATE TRIGGER copiarMiembroBorrado
BEFORE DELETE ON miembros
FOR EACH ROW
BEGIN 
INSERT INTO copia_Miembros VALUES (NULL, CONCAT("Miembro Borrado", OLD.id), OLD.fk_id_cliente, OLD.fecha_alta);
END // 
DELIMITER ;

Create table copia_Coches(
	id INT AUTO_INCREMENT,
    cambio VARCHAR(100),
    marca VARCHAR(30) NOT NULL,
    modelo VARCHAR(30) NOT NULL,
    combustible VARCHAR(20) NOT NULL,
    matricula VARCHAR(10) NOT NULL UNIQUE,
    color VARCHAR(20) NOT NULL,
    precio_por_dia DECIMAL(5,2) NOT NULL,
    alquilado DATE,
    PRIMARY KEY (id)
    );
    
    DELIMITER //
CREATE TRIGGER copiarCocheBorrado
BEFORE DELETE ON coches
FOR EACH ROW
BEGIN 
INSERT INTO copia_Coches VALUES (NULL, CONCAT("Coche Borrado", OLD.id), OLD.marca, OLD.modelo, OLD.combustible, OLD.matricula, OLD.color, OLD.precio_por_dia, OLD.alquilado);
END // 
DELIMITER ;

Create table copia_Alquiler(
	id INT AUTO_INCREMENT,
    cambio VARCHAR(100),
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

DELIMITER //
CREATE TRIGGER copiarAlquilerBorrado
BEFORE DELETE ON alquiler
FOR EACH ROW
BEGIN 
INSERT INTO copia_Alquiler VALUES (NULL, CONCAT("Alquiler Borrado", OLD.id), OLD.fk_id_cliente, OLD.fk_id_coche, OLD.precio_final, OLD.fecha_inicio, OLD.fecha_fin);
END // 
DELIMITER ;


INSERT INTO coches (marca, modelo, combustible, matricula, color, precio_por_dia, alquilado)
VALUES 
('Toyota', 'Corolla', 'Gasolina', '1234ABC', 'Rojo', 45.50, NULL),
('Tesla', 'Model 3', 'Eléctrico', '5678DEF', 'Negro', 85.00, NULL),
('Volkswagen', 'Golf', 'Diésel', '9012GHI', 'Blanco', 55.25, '2025-10-01');
INSERT INTO clientes (nombre, apellidos, dni, email, telefono)
VALUES 
('Laura', 'Martínez López', '12345678A', 'laura@example.com', '600123456'),
('Carlos', 'Gómez Ruiz', '87654321B', 'carlos@example.com', '600654321');
INSERT INTO miembros (fk_id_cliente, fecha_alta)
VALUES 
(1, '2025-09-15'),
(2, '2025-09-20');


DELIMITER //
CREATE TRIGGER trg_calcular_precio_alquiler
BEFORE INSERT ON alquiler
FOR EACH ROW
BEGIN
    DECLARE v_precio_dia DECIMAL(5,2);
    DECLARE v_dias INT;
    DECLARE v_precio_base DECIMAL(9,2);
    DECLARE v_fecha_alta DATE;
    DECLARE v_meses INT;
    DECLARE v_descuento DECIMAL(5,2);
    DECLARE v_contador INT;

    -- 1. Obtener precio por día del coche
    SELECT precio_por_dia INTO v_precio_dia
    FROM coches
    WHERE id = NEW.fk_id_coche;

    -- 2. Calcular días de alquiler
    SET v_dias = DATEDIFF(NEW.fecha_fin, NEW.fecha_inicio);

    -- 3. Precio base
    SET v_precio_base = v_precio_dia * v_dias;

    -- 4. Comprobar si el cliente es miembro
    SELECT fecha_alta INTO v_fecha_alta
    FROM miembros
    WHERE fk_id_cliente = NEW.fk_id_cliente
    LIMIT 1;

    -- Si es miembro, calcular meses de antigüedad
    IF v_fecha_alta IS NOT NULL THEN
        SET v_meses = TIMESTAMPDIFF(MONTH, v_fecha_alta, CURDATE());

        -- descuento base 0
        SET v_descuento = 0;

        -- Si tiene al menos 6 meses → 5%
        IF v_meses >= 6 THEN
			while v_meses < 6 do
				SET v_meses = v_meses - 6;
				SET v_contador = v_contador +1;
            end while;
            SET v_descuento = v_contador+4;
            -- límite máximo 15%
            IF v_descuento > 15 THEN
                SET v_descuento = 15;
            END IF;
        END IF;

        -- aplicar descuento
        SET NEW.precio_final = v_precio_base * (1 - v_descuento/100);
    ELSE
        -- no es miembro → sin descuento
        SET NEW.precio_final = v_precio_base;
    END IF;
END;
//
DELIMITER ;


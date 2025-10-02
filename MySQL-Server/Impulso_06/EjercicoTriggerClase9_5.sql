# DROP DATABASE GestionClientes

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS GestionClientes;
USE GestionClientes;

-- Crear tabla principal
CREATE TABLE Clientes (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(20),
    DNI VARCHAR(20)
);

-- Crear tabla de copia
CREATE TABLE Copia_Clientes (
    id INT,
    nombre VARCHAR(100),
    telefono VARCHAR(20),
    DNI VARCHAR(20),
    accion VARCHAR(10), -- 'INSERT' o 'DELETE'
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger para inserciones
DELIMITER //
CREATE TRIGGER tr_insert_clientes
AFTER INSERT ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO Copia_Clientes (id, nombre, telefono, DNI, accion)
    VALUES (NEW.id, NEW.nombre, NEW.telefono, NEW.DNI, 'INSERT');
END;
//
DELIMITER ;

-- Trigger para borrados
DELIMITER //
CREATE TRIGGER tr_delete_clientes
AFTER DELETE ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO Copia_Clientes (id, nombre, telefono, DNI, accion)
    VALUES (OLD.id, OLD.nombre, OLD.telefono, OLD.DNI, 'DELETE');
END;
//
DELIMITER ;

-- Pruebas

-- Insertar clientes
INSERT INTO Clientes (id, nombre, telefono, DNI) VALUES
(1, 'Ana Torres', '600123456', '12345678A'),
(2, 'Luis Gómez', '600987654', '87654321B');

-- Verificar contenido de Copia_Clientes tras inserciones
SELECT * FROM Copia_Clientes;

-- Verificar contenido de Clientes tras inserciones
SELECT * FROM Clientes;

-- Borrar un cliente
DELETE FROM Clientes WHERE id = 1;

-- Verificar contenido de Copia_Clientes tras borrado
SELECT * FROM Copia_Clientes;

INSERT INTO Clientes (id, nombre, telefono, DNI) VALUE
(1, 'Ana Resto', '000000000', '123456787');  # Este registro siempre se borra


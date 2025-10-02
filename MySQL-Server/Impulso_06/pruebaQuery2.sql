# DROP DATABASE HolaMundo;

CREATE DATABASE HolaMundo;
USE HolaMundo;

CREATE TABLE Contrasenias(
id INT AUTO_INCREMENT,   # AUTO_INCREMENT Solo frunciona en MySQL
contrasenia VARCHAR(30) NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE Usuarios(
id INT AUTO_INCREMENT,
nombre VARCHAR(30) NOT NULL UNIQUE,
fk_id_contrasenia INT,
PRIMARY KEY(id),
FOREIGN KEY(fk_id_contrasenia) REFERENCES Contrasenias(id)
);


SELECT * FROM 	Contrasenias;
SELECT * FROM 	Usuarios;

INSERT INTO Contrasenias VALUES(NULL, '1234'); # id = 1
INSERT INTO Contrasenias VALUES(NULL, '1234a'); # id = 2
INSERT INTO Contrasenias VALUES(NULL, '1234ab'); # id = 3
INSERT INTO Contrasenias VALUES(NULL, '1234abc'); # id = 4

INSERT INTO Usuarios VALUES(NULL, 'admin', 2);
INSERT INTO Usuarios VALUES(NULL, 'davinia', 1);
INSERT INTO Usuarios VALUES(NULL, 'paco', 4);
INSERT INTO Usuarios VALUES(NULL, 'petreus', 3);

DELETE FROM Usuarios WHERE id = 4;
DELETE FROM Usuarios WHERE id = 4;

/*
CREATE TABLE Productos(
id INT AUTO_INCREMENT,
nombre VARCHAR(30) NOT NULL,
precio FLOAT(5,2)
fk_id_contrasenia INT,
PRIMARY KEY(id),
FOREIGN KEY(fk_id_contrasenia) REFERENCES Contrasenias(id)
);
*/
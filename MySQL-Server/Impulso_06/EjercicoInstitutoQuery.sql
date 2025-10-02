    #DROP DATABASE Hospital;
    CREATE DATABASE Instituto;

    USE Instituto;
    
	CREATE TABLE Profesores(
        id_cama INT AUTO_INCREMENT,
        dni VARCHAR(9) NOT NULL UNIQUE, 
        nombre VARCHAR(300) NOT NULL,
        direccion VARCHAR(300),
        telefono VARCHAR(15) NOT NULL,
        PRIMARY KEY(id)
    );
    
    CREATE TABLE Modulos(
		id INT AUTO_INCREMENT,
        codigo VARCHAR(30) NOT NULL UNIQUE,
        nombre VARCHAR(100) NOT NULL,
        fk_id_profesor INT NOT NULL,
        PRIMARY KEY(id),
        FOREIGN KEY(id),
        FOREIGN KEY(fk_id_profesor) REFERENCES Profesores(id)
    );
    
    CREATE TABLE Alumnos(
    
    );
    
    
    /*Falta tabla de modulos alumnos y curos*/
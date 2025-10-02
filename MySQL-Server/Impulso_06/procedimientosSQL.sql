USE programacion

DELIMITER //
CREATE PROCEDURE saludar()
BEGIN
	DECLARE saludo VARCHAR(100);
    SET saludo = "Hola";
    SELECT saludo;
END
//
DELIMITER ;

CALL saludar()

#------------------------------------------------------------------------------------------------------------------------------------------------------------
# DROP PROCEDURE saludar2
DELIMITER //
CREATE PROCEDURE saludar2 (IN saludo VARCHAR(25), IN nombre VARCHAR(100))
BEGIN
  SELECT CONCAT(saludo," ",nombre) AS saludo_nombre; # Le ponemos el alias con AS y sale en la llamada (Los Alias lo utilizan los programadores)
END;
//
DELIMITER ;

SET @saludo = "Hola"; # La arroba es porque está fuera de los procedimientos
SET @nombre = "Ana Pérez";
CALL saludar2(@saludo, @nombre);

#----------------------------------------------------Procedimiento con parámetros de salida:--------------------------------------------------------------------------
DELIMITER //
CREATE PROCEDURE sumaResta (IN n1 INT, IN n2 INT, OUT suma INT, OUT resta INT)
BEGIN
  SET suma = n1+n2;
  SET resta = n1-n2;
END;
//
DELIMITER ;

SET @n1 = 100;
SET @n2 = 200;
CALL sumaResta (@n1, @n2, @suma, @resta);
SELECT @suma;
SELECT @resta;
CALL sumaResta (@suma, @resta, @suma2, @resta2);
SELECT @suma2;
SELECT @resta2;
SELECT @suma2 + 900 AS Operacion_2;


#----------------------------------------------------Procedimiento con parámetros de entrada/salida:--------------------------------------------------------------------------

DELIMITER //
CREATE PROCEDURE incrementar (INOUT incremento INT)
BEGIN
	SET incremento = incremento + 10;
END;
//
DELIMITER ;

SET @incremento = 0;
CALL incrementar(@incremento);
SELECT @incremento;
CALL incrementar(@incremento);
SELECT @incremento;
CALL incrementar(@incremento);
SELECT @incremento;
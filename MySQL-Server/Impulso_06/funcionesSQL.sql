	
    #--------------------------------------Función sin parámetros:-------------------------------------------------------------------------------------

    DELIMITER //
	CREATE FUNCTION dosAlCuadrado ()
	RETURNS INT DETERMINISTIC
	BEGIN
		RETURN 2*2;
	END
	//
	DELIMITER ;
    
    SET @resultado = dosAlCuadrado() + 4;
    SELECT @resultado
    
#--------------------------------------------Función con parámetros:-------------------------------------------------------------------------------------------------------------
    
-- Cambiamos el delimitador para definir la función
DELIMITER //

CREATE FUNCTION sumaEnteros(n1 INT, n2 INT)
RETURNS INT DETERMINISTIC
BEGIN
    RETURN n1 + n2;
END //

-- Restauramos el delimitador original
DELIMITER ;

-- Probamos la función con un SELECT
SELECT sumaEnteros(3, 7) AS resultado1;

-- Otro ejemplo de uso, con nombre de columna personalizado
SELECT sumaEnteros(9, 7) AS SUMA_9_7;

-- También puedes usar variables de sesión si lo deseas
SET @n1 = 9;
SET @n2 = 7;
SELECT sumaEnteros(@n1, @n2) AS resultado_con_variables;
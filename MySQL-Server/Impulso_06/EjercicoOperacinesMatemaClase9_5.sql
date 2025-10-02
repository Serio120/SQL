DELIMITER //

CREATE PROCEDURE OperacionesMatematicas (
    IN num1 INT,
    IN num2 INT,
    OUT suma INT,
    OUT resta INT,
    OUT multiplicacion INT,
    OUT division DECIMAL(10,2)
)
# Cuando llamas al procedimiento, tú le das los valores de entrada (num1, num2) y >>>>>> INT
# MySQL te devuelve los valores de salida (suma, resta, etc.) en variables que tú defines: >>>>>> OUT



BEGIN
    SET suma = num1 + num2;
    SET resta = num1 - num2;
    SET multiplicacion = num1 * num2;

    IF num2 != 0 THEN
        SET division = num1 / num2;
    ELSE
        SET division = NULL; -- Evita división por cero
    END IF;
END;
//

DELIMITER ;

-- Pruebas------------------------------------------------------------------------------------------

-- Declarar variables para los resultados
SET @a = 98562 ;
SET @b = 1562;
SET @suma = 0;
SET @resta = 0;
SET @multiplicacion = 0;
SET @division = 0;

-- Llamar al procedimiento
CALL OperacionesMatematicas(@a, @b, @suma, @resta, @multiplicacion, @division);

-- Ver los resultados
SELECT @a AS NUM_A, @b AS NUM_B, @suma AS Suma_ab, @resta AS Resta_ab, @multiplicacion AS Multiplicación_ab, @division AS División_ab;
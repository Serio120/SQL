
# DECLARE s VARCHAR(20);

SET @s = 2;
SET @m = 1;
SELECT @s;
SELECT @m;


IF n > m THEN 
	SET s = '>';
ELSEIF n = m THEN 
	SET s = '=';
ELSE 
	SET s = '<';
END IF;

SET s = CONCAT(n, ' ', s, ' ', m);


DECLARE s VARCHAR(20);

IF n > m THEN 
	SET s = '>';
ELSE
    IF n = m THEN 
        SET s = '=';
    ELSE 
        SET s = '<';
    END IF;
END IF;

SET s = CONCAT(n, ' ', s, ' ', m);

CASE variable/campo

    WHEN valorComparar1 THEN 
        codigo
    [WHEN valorCompararN THEN 
        codigo
    ] 
    ...
    [ELSE 
        codigo
    ]

END CASE;

DECLARE s INT;

CASE n

WHEN 1 THEN 
	SET s = 1;
WHEN 2 THEN 
	SET s = 2;
WHEN 3 THEN 
	SET s = 3;
WHEN 4 THEN 
	SET s = 4;
ELSE 
	SET s = 5;

END CASE;

    DECLARE p INT DEFAULT 3;
    label1: LOOP
        SET p = p + 1;	
        IF p < 10 THEN
            ITERATE label1; # Para dar otra vuelta
        END IF;
        LEAVE label1; # Para salir
    END LOOP label1;
    
        REPEAT
        codigo
    UNTIL condicion/condiciones
    END REPEAT 
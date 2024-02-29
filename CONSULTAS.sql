-- Consulta 1
SELECT P.nombre, P.vision, P.regionProveniencia
FROM Personaje P
JOIN Region R ON R.nombre = P.regionProveniencia
WHERE P.rareza = 4 AND P.vision <> R.elementoOrigen
ORDER BY P.nombre ASC, R.nombre ASC;

-- Consulta 2
SELECT DISTINCT tipo
FROM Arma a
WHERE NOT EXISTS
(SELECT 1 FROM Elemento e WHERE e.nombre != 'N/A' AND NOT EXISTS(
    SELECT 1 FROM Personaje p WHERE 
    p.tipoArma = a.tipo
    AND p.vision = e.nombre
));

-- Consulta 3
SELECT nombrePersonaje1
FROM conoce 
JOIN Ingiere I1 ON I1.nombrePersonaje = nombrePersonaje1
JOIN Ingiere I2 ON I2.nombrePersonaje = nombrePersonaje2
WHERE tipoRelacion = 'Enemistad' AND I1.nombreComida = I2.nombreComida;

-- Consulta 4
SELECT nombreEnemigo FROM aparece WHERE nombreRegion = 'Fontaine' AND nombreEnemigo IN (SELECT nombreEnemigo FROM incluye i WHERE numeroSala = 2 AND idPiso = 12 AND idAbismoAbisal = ((SELECT id from abismoabisal
where FechaFin=(
SELECT max(FechaFin)
FROM abismoabisal
))));


-- Consulta 5
SELECT nombre, Tipo, rareza
FROM Arma
WHERE AtaqueBase > 600;

-- Consulta 6
SELECT *
FROM RegionesInspiradas;

-- Consulta 7
-- Listar los nombres de los personajes que tienen una amistad con al menos un personaje con efecto secundario %Daño Critico y que su magnitud sea mayor a 10
-- Esta consulta fue elaborada ya que la tabla efectos no es tan usada y aprovechando la relacion conoce entre personajes, podemos encontrar
-- los personajes con amigos que tengan el efecto secundario '%Daño Critico' mayor que 10
SELECT nombre 
FROM Personaje
WHERE nombre IN 
    (SELECT nombrePersonaje1 FROM conoce
    WHERE tipoRelacion = 'Amistad'
    AND nombrePersonaje2 IN
        (SELECT nombre FROM Personaje 
        WHERE efectoSecundario = (SELECT id FROM Efecto WHERE nombre = '%Daño Critico') 
        AND magnitudSegundoEfecto > 10)) 
OR nombre IN 
    (SELECT nombrePersonaje2 FROM conoce
    WHERE tipoRelacion = 'Amistad'
    AND nombrePersonaje1 IN
        (SELECT nombre FROM Personaje 
        WHERE efectoSecundario = (SELECT id FROM Efecto WHERE nombre = '%Daño Critico')
        AND magnitudSegundoEfecto > 10));

-- Consulta 8
-- Mostrar la cantidad de enemigos que existen en cada abismo abisal ordenados por ID
-- Se realizó esta consulta porque la tabla enemigo no es tan usada en la consulta y ademas es
-- necesario saber el total de enemigos por abismo abisal como buen recurso de información para
-- los jugadores

SELECT COUNT(E.nombre), I.idabismoabisal 
FROM Enemigo E
JOIN Incluye I ON E.nombre = I.nombreEnemigo
JOIN AbismoAbisal AA ON E.nombre = I.nombreEnemigo
WHERE I.idabismoabisal = AA.id
GROUP BY I.idabismoabisal
ORDER BY I.idabismoabisal;



-- Función TierSSS 
CREATE FUNCTION TierSSS(elemento VARCHAR)
RETURNS VOID AS $$
DECLARE
    personaje VARCHAR(70);
    ataque_promedio FLOAT;
BEGIN
    -- Verificar si el elemento existe en la tabla Elemento y tiene al menos un poseedor
    IF EXISTS (
        SELECT 1
        FROM Elemento E
        JOIN Personaje P ON E.nombre = P.vision
        WHERE E.nombre = elemento
    )
    THEN
        -- Obtener el mejor personaje del elemento
        SELECT P.nombre,
               (P.AtaqueBase + A.AtaqueBase) + 
               (P.AtaqueBase + A.AtaqueBase) * (SELECT bonoATQ FROM Habilidad WHERE nombre = P.habilidadElemental) +
               (P.AtaqueBase + A.AtaqueBase) * (SELECT bonoATQ FROM Habilidad WHERE nombre = P.habilidadDefinitiva)
        INTO personaje, ataque_promedio
        FROM Elemento E
        JOIN Personaje P ON E.nombre = P.vision
        JOIN Arma A ON P.nombreArma = A.nombre
        WHERE E.nombre = elemento
        ORDER BY ataque_promedio DESC
        LIMIT 1;
        -- Retornar el mensaje con el ataque promedio
        RAISE NOTICE 'El mejor personaje del elemento % es %, teniendo un ataque promedio de % puntos.', elemento, personaje, ataque_promedio;
    ELSE
        -- Elemento no encontrado
        RAISE NOTICE 'El elemento ingresado no corresponde a ningún elemento de la tabla Elemento';
    END IF;
END;
$$ LANGUAGE plpgsql;


SELECT TierSSS('Electro');
SELECT TierSSS('Hydro');
SELECT TierSSS('Pairo');
SELECT TierSSS('Geo');
SELECT TierSSS('Dendro');

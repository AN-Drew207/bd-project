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


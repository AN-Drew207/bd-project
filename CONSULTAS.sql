-- Consulta 1
SELECT P.nombre, P.vision, P.region_proveniencia
FROM Personaje P
JOIN Region R ON R.nombre = P.region_proveniencia
WHERE P.rareza = 4 AND P.vision <> R.elemento_origen
ORDER BY P.nombre ASC, R.nombre ASC;

-- Consulta 2
SELECT DISTINCT tipo
FROM Arma a
WHERE NOT EXISTS (SELECT 1 FROM Elemento e WHERE NOT EXISTS(
    SELECT 1 FROM Personaje p WHERE 
    p.tipo_arma = a.tipo
    AND p.vision = e.nombre
));

-- Consulta 3
SELECT nombre_personaje1
FROM conoce 
JOIN Ingiere I1 ON I1.nombre_personaje = nombre_personaje1
JOIN Ingiere I2 ON I2.nombre_personaje = nombre_personaje2
WHERE tipo_relacion = 'Enemistad' AND I1.nombre_comida = I2.nombre_comida;

-- Consulta 4


-- Consulta 5
SELECT nombre, Tipo, rareza
FROM Arma
WHERE ataque_base > 600;

-- Consulta 6
SELECT *
FROM RegionesInspiradas;


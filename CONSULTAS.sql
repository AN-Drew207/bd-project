SELECT P.nombre, P.vision, P.region_proveniencia
FROM Personaje P, Region R
WHERE P.rareza = 4 AND P.vision NOT IN (SELECT R.elemento_origen 
FROM Region R
WHERE P.region_proveniencia = R.nombre)

ORDER BY R.nombre ASC, P.nombre ASC;

SELECT nombre, Tipo, rareza
FROM Arma
WHERE ataque_base > 600;

SELECT *
FROM RegionesInspiradas;

SELECT DISTINCT(P.nombre)
FROM personaje P
JOIN Conoce C1 ON C1.nombre_personaje1 = P.nombre
JOIN Conoce C2 ON C2.nombre_personaje2 = P.nombre
JOIN Ingiere I1 ON I1.nombre_personaje = C1.nombre_personaje1
JOIN Ingiere I2 ON I2.nombre_personaje = C2.nombre_personaje2
WHERE C1.tipo_relacion = 'Enemistad' AND I1.nombre_comida = I2.nombre_comida AND P.nombre <> C2.nombre_personaje1;
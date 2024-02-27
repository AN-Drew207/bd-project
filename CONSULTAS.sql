SELECT P.nombre, P.vision, P.region_proveniencia
FROM Personaje P
JOIN Region R ON R.nombre = P.region_proveniencia
WHERE P.rareza = 4 AND P.vision <> R.elemento_origen
ORDER BY P.nombre ASC, R.nombre ASC;

SELECT nombre, Tipo, rareza
FROM Arma
WHERE ataque_base > 600;

SELECT *
FROM RegionesInspiradas;

SELECT nombre_personaje1
FROM conoce 
JOIN Ingiere I1 ON I1.nombre_personaje = nombre_personaje1
JOIN Ingiere I2 ON I2.nombre_personaje = nombre_personaje2
WHERE tipo_relacion = 'Enemistad' AND I1.nombre_comida = I2.nombre_comida;
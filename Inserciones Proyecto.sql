INSERT INTO Arma VALUES ('Espada de Madera', 4, 564, 'Espada Ligera', 60.5, 1, NULL, NULL, NULL, NULL, 1, 60),
('Aquila Favonia', 5, 674, 'Espada Ligera', 80.5, 1, NULL, NULL, NULL, NULL, 5, 20),
('Cortador de Jade Primordial', 5, 541, 'Espada Ligera', 80.2, 1, NULL, NULL, NULL, NULL, 7, 20);

INSERT INTO Region VALUES ('Fontaine', 'Focalors', 'De las regiones de Teyvat, Fontaine se enorgullece de ser el centro de la cultura y las artes; o en palabras de Francis, un mercader ambulante de la región, "la verdadera belleza y elegancia". El periódico «El Pájaro de Vapor» es el principal periódico de la Corte de Fontaine; Mona es columnista en él, lo que sugiere que tienen escritores de todo Teyvat.', 'Hydro'), 
('Lyue', 'Morax', 'Es una de las siete naciones de Teyvat. También es la ciudad-Estado que adora a Morax, el Arconte Geo.', 'Geo'), 
('Inazuma', 'Beelzebul', 'Es una de las siete naciones de Teyvat. Es una nación archipelágica que adora a Beelzebul, la Arconte Electro, quien a su vez dirige la Entidad Controladora local, el Shogunato de Inazuma.', 'Electro'),
('Mondstadt', 'Barbatos', 'Es una de las siete naciones de Teyvat, y es la primera en la que el Viajero empieza a buscar a su hermana perdida. Es la ciudad-estado que adora a Barbatos, el Arconte Anemo.', 'Anemo'),
('Sumeru', 'Reina Menor Kusanali', 'Es una de las sietes naciones de Teyvat. Es la ciudad-estado que adora a la Diosa de la Sabiduría, la Reina Menor Kusanali, la Arconte Dendro.', 'Dendro');

INSERT INTO RegionesInspiradas VALUES ('Fontaine', 'Francia'), 
('Lyue', 'China'),
('Inazuma', 'Japon'),
('Mondstadt', 'Alemania'),
('Sumeru', 'Oriente Próximo y la Antigua India');

INSERT INTO Elemento VALUES ('Anemo'), ('Pyro'), ('Cryo'), ('Geo'), ('Dendro'), ('Electro'), ('Hydro'), ('N/A');

INSERT INTO Efecto VALUES (1, '%Daño Pyro', 'Inflige daño de Fuego'), 
(2, '%Daño Electro', 'Inflige daño Electrico'), 
(3, '%Daño Hydro', 'Inflige daño Acuatico'),
(4, '%Daño Cryo', 'Inflige daño Congelante'),
(5, '%Daño Geo', 'Inflige daño Fisico'),
(6, '%Daño Dendro', 'Inflige daño '),
(7, '%Daño Anemo', 'Inflige daño de Viento'),
(8, '%PROB. Critico', 'Mide la frecuencia con la que un personaje podrá infligir un crítico.'),
(9, '%Maestria Elemental', 'Aumenta la potencia de las Reacciones elementales creadas por tu personaje.'),
(10, '%Daño Critico', 'Determina cuánto daño adicional infligirá el héroe cuando se active un golpe crítico.'),
(11, '%Recarga de Energia', 'Cada personaje tiene una estadística porcentual de Recarga de Energía. Ésta es inicialmente 100%, pero puede aumentar por medio de los artefactos, de un arma o como especialidad del personaje (en Shogun Raiden, Mona, Bennet, Venti, Kaeya y Yun Jin).'),
(12, '%ATQ', 'Hace un incremento al ataque normal por ciertos segundos, aumentando mas el porcentaje.'),
(13, '%Daño Fisico', 'Es el daño estandard de las armas.');

-- Ataque%, Vida%, Fisico%, Elemental%

INSERT INTO Comida VALUES ('Carne de Mora', 1, 'Lyue'),
('Carne Frita', 1, 'Lyue'),
('Dango Tricolor', 3, 'Inazuma'),
('Costillas con salsa secreta', 2, 'Fontaine'),
('Estofado de perca de lomo negro', 3, 'Lyue'),
('Leche de dango', 3, 'Inazuma'),
('Arroz con anguila bañado en té', 3, 'Inazuma'),
('Biryani', 4, 'Sumeru'),
('Brotes de bambú hervidos', 2, 'Inazuma'),
('Cangrejo mantequilla', 4, 'Inazuma'),
('Pesca extrema', 3, 'Mondstadt'),
('Tayín fuegoáureo', 3, 'Sumeru'),
('Para Foçalors', 3, 'Fontaine'),
('Cassoulet', 3, 'Fontaine'),
('Arroz con anguila bañado en té', 3, 'Inazuma'),
('Pollo rockero', 2, 'Lyue'),
('Ensalada saludable', 2, 'Mondstadt'),
('Fideos barba de dragón', 3, 'Lyue'),
('Guoba de Jueyun', 3, 'Lyue'),
('Jugo de gancho de lobo', 2, 'Mondstadt'),
('Cien sabores', 3, 'Fontaine'),
('Carne a la jardinera', 2, 'Mondstadt'),
('Chop suey de Zhongyuan', 3, 'Lyue'),
('Fish and chips', 3, 'Fontaine'),
('Tulumba', 3, 'Sumeru'),
('Carne estilo Eje Celestial', 4, 'Lyue'),
('Pollo “en vessie”', 4, 'Fontaine'),
('Érase una vez en Mondstadt', 3, 'Mondstadt'),
('Brotes de bambú hervidos', 2, 'Inazuma'),
('Pescado mandarín agridulce', 3, 'Lyue'),
('Pizza de champiñones especial', 3, 'Inazuma'),
('Trucha con almendras', 1, 'Fontaine'),
('Tortilla de papas de Mondstadt', 3, 'Mondstadt'),
('Sopa de cebolla', 2, 'Fontaine'),
('Pastelillo de luna', 4, 'Mondstadt'),
('Pescado seco estofado', 1, 'Inazuma'),
('Bolitas de harina de arroz', 1, 'Lyue'),
('Caracolas de cristal', 3, 'Fontaine'),
('Estofado de carne de Sabz', 3, 'Sumeru'),
('Onigiri', 2, 'Inazuma');

INSERT INTO ConjuntoArtefactos VALUES ('');

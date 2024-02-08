INSERT INTO Arma VALUES ('Espada de Madera', 4, 564, 'Espada Ligera', 60.5, 1, NULL, NULL, NULL, NULL, 1, 60),
('Aquila Favonia', 5, 674, 'Espada Ligera', 80.5, 1, NULL, NULL, NULL, NULL, 5, 20),
('Cortador de Jade Primordial', 5, 541, 'Espada Ligera', 80.2, 1, NULL, NULL, NULL, NULL, 7, 20);

INSERT INTO Region VALUES ('Fontaine', 'Focalors', 'De las regiones de Teyvat, Fontaine se enorgullece de ser el centro de la cultura y las artes; o en palabras de Francis, un mercader ambulante de la región, 'la verdadera belleza y elegancia'. El periódico «El Pájaro de Vapor» es el principal periódico de la Corte de Fontaine; Mona es columnista en él, lo que sugiere que tienen escritores de todo Teyvat.', 'Hydro'), 
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


CREATE TABLE Comida (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    rareza INTEGER(5) NOT NULL,
    nombre_region VARCHAR(100) NOT NULL,
    FOREIGN KEY (nombre_region) REFERENCES Region(nombre)
);

CREATE TABLE Arma (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    rareza INT NOT NULL,
    ataque_base FLOAT NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    logitud INT NOT NULL,
    doble_filo BOOLEAN NOT NULL,
    peso INT NOT NULL,
    tipo_punta VARCHAR(100) NOT NULL,
    material_cuerda VARCHAR(100) NOT NULL,
    tipo_magia VARCHAR(100) NOT NULL,
    segundo_efecto VARCHAR(100) NOT NULL,
    maginitud_segundo_efecto INT NOT NULL
);




INSERT INTO Personaje VALUES ('Albedo','Jefe Alquimista','Geo','Humano sintético','Princeps Cretaceus',5,'Espada Ligera',19,NULL,68,1029,'Mondstadt','Espada Favonious','%Daño Geo',7.2,'Abiogenesis: Solar Isotoma','Rite of Progeniture: Tectonic Tide',NULL),
('Aloy','La Salvadora de Otro Mundo','Cryo','Humana','Nora Fortis',5,'Arco',18,NULL,52,848,NULL,'Bow','%Daño Cryo',7.2,'Frozen Wilds','Prophecies of Dawn',NULL),
('Amber','Campeona de vuelo','Pyro','Humana','Lepus',4,'Arco',18,NULL,50,793,'Mondstadt','Bow','ATK',NULL,'Explosive Puppet','Fiery Rain',NULL),
('Baizhu','El Trasgresor de lo Mortal','Dendro','Humano','Lagenaria',5,'Catalizador',14,NULL,38,1039,'Liyue','Catalyst','HP',NULL,'Universal Diagnosis','Holistic Revivification',NULL),
('Barbara','Ídolo Radiante','Hydro','Humana','Crater',4,'Catalizador',13,NULL,56,820,'Mondstadt','Catalyst','HP',NULL,'Let the Show Begin','Shining Miracle',NULL),
('Beidou','Reina del Océano sin Corona','Electro','Humana','Victor Mare',4,'Espada Pesada',18,NULL,54,1094,'Liyue','Claymore','%Daño Electro',NULL,'Tidecaller','Stormbreaker',NULL),
('Bennett','Líder de la Brigada de Benny','Pyro','Humano','Rota Calamitas',4,'Espada Ligera',16,NULL,64,1039,'Mondstadt','Espada','Energy Recharge',NULL,'Passion Overload','Fantastic Voyage',NULL),
('Candace','Custodia de la Aldea Aaru','Hydro','Humana','Sagitta Scutum',4,'Lanza',17,NULL,57,911,'Sumeru','Polearm','HP',NULL,'Sacred Rite: Herons Sanctum','Sacred Rite: Wagtails Tide',NULL),
('Charlotte','Reportera de El Pájaro de Vapor','Cryo','Humana','Hualina Veritas',4,'Catalizador',14,NULL,45,902,'Fontaine','Catalyst','ATK',NULL,'Framing: Freezing Point Composition','Still Photo: Comprehensive Confirmation',NULL),
('Chevreuse','Capitana de la Unidad Especial de Seguridad y Vigilancia','Pyro','Humana','Sclopetum Ensiferum',4,'Lanza',16,NULL,50,1002,'Fontaine','Polearm','HP',NULL,'Short-Range Rapid Interdiction Fire','Ring of Bursting Grenades',NULL),
('Chongyun','Desterrador del mal y los rumores sobre el mismo','Cryo','Humano','Nubis Caesor',4,'Espada Pesada',18,NULL,54,920,'Liyue','Claymore','ATK',NULL,'Spirit Blade: Chonghuas Layered Frost','Spirit Blade: Cloud-Parting Star',NULL),
('Collei','Guardabosques en prácticas del Bosque Avidya','Dendro','Humana','Leptailurus Cervarius',4,'Arco',16,NULL,50,820,'Sumeru','Bow','ATK',NULL,'Floral Brush','Trump-Card Kitty',NULL),
('Cyno','El Magistrado de lo Arcano','Electro','Humano','Lupus Aureus',5,'Lanza',24,NULL,66,972,'Sumeru','Polearm','%Daño Crítico',NULL,'Secret Rite: Chasmic Soulfarer','Sacred Rite: Wolfs Swiftness',NULL),
('Dehya','La Leona Ardiente','Pyro','Humana','Mantichora',5,'Espada Pesada',20,NULL,48,1220,'Sumeru','Claymore','HP',NULL,'Molten Inferno','Leonine Bite',NULL),
('Diluc','Dueño del Viñedo del Amanecer','Pyro','Humano','Noctua',5,'Espada Pesada',26,NULL,61,1010,'Mondstadt','Claymore','CRIT Rate',NULL,'Searing Onslaught','Dawn',NULL),
('Diona','La Cantinera Felina','Cryo','Sangre felinesa','Feles',4,'Arco',17,3,50,802,'Mondstadt','Bow','%Daño Cryo',NULL,'Icy Paws','Signature Mix',NULL),
('Dori','La Magnate Acaudalada','Electro','Humana','Magicae Lucerna',4,'Espada Pesada',18,4,60,1039,'Sumeru','Claymore','HP',NULL,'Spirit-Warding Lamp: Troubleshooter Cannon','Alcazarzarays Exactitude',NULL),
('Eula','Caballera de la Marea','Cryo','Humana','Aphros Delos',5,'Espada Pesada',26,NULL,58,1029,'Mondstadt','Claymore','%Daño Crítico',NULL,'Icetide Vortex','Glacial Illumination',NULL),
('Fischl','La Princesa del Juicio','Electro','Humana','Corvus',4,'Arco',20,3,49,770,'Mondstadt','Bow','ATK',NULL,'Nightrider','Midnight Phantasmagoria',NULL),
('Furina','La Bailarina Incansable','Hydro','Humana','Animula Choragi',5,'Espada Ligera',18,4,54,1191,'Fontaine','Espada','CRIT Rate',NULL,'Salon Solitaire','Let the People Rejoice',NULL),
('Gaming','El Vigía Leonino','Pyro','Humano','Leo Expergiscens',4,'Espada Pesada',25,1,58,957,'Liyue','Claymore','ATK',NULL,'Bestial Ascent','Suannis Gilded Dance',NULL),
('Ganyu','La Vigía del Plenilunio','Cryo','Humana','Sinae Unicornis',5,'Arco',26,5,49,762,'Liyue','Bow','%Daño Crítico',NULL,'Trail of the Qilin','Celestial Shower',NULL),
('Gorou','El General Canino','Geo','Humano','Canis Bellatoris',4,'Arco',15,NULL,54,802,'Inazuma','Bow','%Daño Geo',NULL,'Inuzaka All-Round Defense','Juuga: Forward Unto Victory',NULL),
('Jean','Caballera de Dandelion','Anemo','Humana','Leo Menor',5,'Espada Ligera',18,5,59,1143,'Mondstadt','Espada','Healing Bonus',NULL,'Gale Blade','Dandelion Breeze',NULL),
('Kaeya','Capitán de Caballería','Cryo','Humano','Pavo Ocellus',4,'Espada Ligera',18,2,66,975,'Mondstadt','Espada','Energy Recharge',NULL,'Frostgnaw','Glacial Waltz',NULL),
('Kaveh','El Espejo del Empíreo','Dendro','Humano','Paradisaea',4,'Espada Pesada',19,2,62,1002,'Sumeru','Claymore','Elemental Mastery',NULL,'Artistic Ingenuity','Painted Dome',NULL),
('Kirara','La Gata en los Aleros','Dendro','Humana','Arcella',4,'Espada Ligera',18,NULL,45,1021,'Inazuma','Espada','HP',NULL,'Meow-teor Kick','Secret Art: Surprise Dispatch',NULL),
('Klee','Caballero Chispeante','Pyro',NULL,'Trifolium',5,'Catalizador',24,2,47,800,'Mondstadt','Catalyst','%Daño Pyro',NULL,'Jumpy Dumpty','Sparks n Splash',NULL),
('Lisa','Bruja de las Rosas','Electro','Humana','Tempus Fugit',4,'Catalizador',19,3,48,802,'Mondstadt','Catalyst','Elemental Mastery',NULL,'Violet Arc','Lightning Rose',NULL),
('Lynette','La Elegancia de las Sombras','Anemo',NULL,'Felis Alba',4,'Espada Ligera',19,4,59,1039,'Fontaine','Espada','%Daño Anemo',NULL,'Enigmatic Feint','Magic Trick: Astonishing Shift',NULL),
('Lyney','El Mago de la Fantasmagoría','Pyro','Humano','Felis Fuscus',5,'Arco',24,NULL,41,857,'Fontaine','Bow','CRIT Rate',NULL,'Bewildering Lights','Wondrous Trick: Miracle Parade',NULL),
('Arlecchino','La Sota','Pyro',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Snezhnaya',NULL,NULL,NULL,NULL,NULL,NULL),
('Scaramuccia','El Baladista',' Electro',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Inazuma',NULL,NULL,NULL,NULL,NULL,NULL),
('Dottore','El Doctor',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Guizhong','Diosa de la Arena',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Colombina','La Damisela', NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Snezhnaya',NULL,NULL,NULL,NULL,NULL,NULL),
('Ahangar','Herrero',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sumeru',NULL,NULL,NULL,NULL,NULL,NULL),
('Fierro','Minero',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Liyue',NULL,NULL,NULL,NULL,NULL,NULL),
('Elzer','Director del Gremio de Productores de Vino',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mondstadt',NULL,NULL,NULL,NULL,NULL,NULL),
('Bruce','Caballero de Favonius',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mondstadt',NULL,NULL,NULL,NULL,NULL,NULL),
('Blanche','Dependienta de la Boutique de Mondstadt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mondstadt',NULL,NULL,NULL,NULL,NULL,NULL),


INSERT INTO ConjuntoArtefactos VALUES ('');

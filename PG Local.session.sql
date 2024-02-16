CREATE TABLE Conoce (
    nombre_personaje1 VARCHAR(50) NOT NULL,
    nombre_personaje2 VARCHAR(50) NOT NULL,
    tipo_relacion VARCHAR(70) NOT NULL,
	PRIMARY KEY (nombre_personaje1,nombre_personaje2),
    FOREIGN KEY (nombre_personaje1) REFERENCES Personaje(nombre),
    FOREIGN KEY (nombre_personaje2) REFERENCES Personaje(nombre)
);

DROP TABLE Conoce;

INSERT INTO Arma VALUES ('Cortador de Jade Primordial', 5, 541, 'Espada Ligera', 80.2, False, NULL, NULL, NULL, NULL, 8, 44.1),
('Deseo Ponzoñoso', 5, 509, 'Espada Ligera', 70.5, True, NULL, NULL, NULL, NULL, 11, 45.9),
('Espada del Alba', 3, 401, 'Espada Ligera', 80.1, True, NULL, NULL, NULL, NULL, 10, 46.8),
('Rompemontañas', 5, 608, 'Espada Ligera', 80.5, False, NULL, NULL, NULL, NULL, 12, 49.6),
('Rugido del León', 4, 509, 'Espada Ligera', 75.2, False, NULL, NULL, NULL, NULL, 12, 41.3),
('Luz Lunar de Xifos', 4, 509, 'Espada Ligera', 70.2, True, NULL, NULL, NULL, NULL, 9, 165),
('Argento Estelar de las Nieves', 4, 564, 'Espada Pesada', NULL, NULL, 5.6, NULL, NULL, NULL, 13, 34.4),
('Espada del Tiempo', 4, 509, 'Espada Pesada', NULL, NULL, 5.0, NULL, NULL, NULL, 14, 41.3),
('Májaira Aguamarina', 4, 509, 'Espada Pesada', NULL, NULL, 6.0, NULL, NULL, NULL, 9, 165.0),
('Segadora de la Lluvia', 4, 509, 'Espada Pesada', NULL, NULL, 6.0, NULL, NULL, NULL, 9, 165.0),
('Médula de la Serpiente Marina', 4, 509, 'Espada Pesada', NULL, NULL, 7.0, NULL, NULL, NULL, 8, 27.5),
('Espada Real del Bosque', 4, 564, 'Espada Pesada', NULL, NULL, 8.0, NULL, NULL, NULL, 11, 30.6),
('Espada de la Desidia', 5, 608, 'Espada Pesada', NULL, NULL, 7.5, NULL, NULL, NULL, 12, 49.6),
('Emblema del Mar de Juncos', 5, 608, 'Espada Pesada', NULL, NULL, 8.0, NULL, NULL, NULL, 8, 33.0),
('Borla Blanca', 3, 401, 'Lanza', NULL, NULL, NULL, 'Inglesa', NULL, NULL, 8, 23.4),
('Alabarda', 3, 448, 'Lanza', NULL, NULL, NULL, 'Alemana', NULL, NULL, 12, 23.4),
('Lanza de Caza Real', 4, 564, 'Lanza', NULL, NULL, NULL, 'Frámea Merovingia', NULL, NULL, 12, 27.5),
('Púa Celestial', 5, 674, 'Lanza', NULL, NULL, NULL, 'Europea Funcional', NULL, NULL, 11, 36.7),
('Lanza del Duelo', 4, 454, 'Lanza', NULL, NULL, NULL, 'Inglesa', NULL, NULL, 8, 36.7),
('La Captura', 4, 509, 'Lanza', NULL, NULL, NULL, 'Europea Funcional', NULL, NULL, 11, 45.9);

SELECT * FROM arma;

SELECT nombre, Tipo, rareza
FROM Arma
WHERE ataque_base > 600;

INSERT INTO region VALUES ('Snezhnaya', 'Zarina', 'Es una de las siete naciones de Teyvat y una región no mostrada en Genshin Impact. Aquellos que viven en Snezhnaya adoran a la Arconte Cryo, la Zarina y también es el hogar de los Fatui.', 'Cryo'),
('Natlan', 'Murata', 'Es una de las siete naciones de Teyvat. Es la ciudad-estado que adora a Murata, la Arconte Pyro.', 'Pyro');

SELECT * FROM region;

CREATE TABLE RegionInspiradas (
    nombre_region VARCHAR(50)  NOT NULL,
    nombre_pais_real VARCHAR(50) NOT NULL,
    PRIMARY KEY(nombre_region,nombre_pais_real),
    FOREIGN KEY (nombre_region) REFERENCES Region(nombre)
);

INSERT INTO RegionInspiradas VALUES ('Fontaine', 'Francia'), 
('Liyue', 'China'),
('Inazuma', 'Japon'),
('Mondstadt', 'Alemania'),
('Sumeru', 'Oriente Próximo y la Antigua India');

SELECT * FROM RegionInspiradas;


CREATE TABLE Personaje (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    cargo VARCHAR(70) NOT NULL,
    vision VARCHAR(70),
    tipo VARCHAR(70) ,
    constelacion VARCHAR(70),
    rareza INTEGER CHECK (rareza = 4 OR rareza = 5 OR rareza = NULL),
    tipo_arma VARCHAR(70),
    ataque_base FLOAT CHECK (ataque_base >= 1),
    vel_movimiento FLOAT CHECK (vel_movimiento >= 1),
    defensa FLOAT CHECK (defensa >= 1),
    vida INTEGER CHECK (vida >= 1),
	region_proveniencia VARCHAR(50),
    nombre_arma VARCHAR(50),
    efecto_secundario INTEGER CHECK (efecto_secundario >= 1),
    maginitud_segundo_efecto FLOAT,
    habilidad_elemental VARCHAR(50),
    habilidad_definitiva VARCHAR(50),
    conjunto_artefactos VARCHAR(50),
    FOREIGN KEY (region_proveniencia) REFERENCES Region(nombre),
    FOREIGN KEY (nombre_arma) REFERENCES Arma(nombre),
    FOREIGN KEY (efecto_secundario) REFERENCES Efecto(id),
    FOREIGN KEY (habilidad_elemental) REFERENCES Habilidad(nombre),	
    FOREIGN KEY (habilidad_definitiva) REFERENCES Habilidad(nombre),	
    FOREIGN KEY (conjunto_artefactos) REFERENCES ConjuntoArtefactos(nombre)	
);

DROP TABLE Personaje;

INSERT INTO Personaje VALUES ('Albedo','Jefe Alquimista','Geo','Humano sintético','Princeps Cretaceus',5,'Espada Ligera',19,NULL,68,1029,'Mondstadt','Aquila Favonia',5, 7.2, 'Abiogenesis: Solar Isotoma','Rite of Progeniture: Tectonic Tide',NULL),
('Aloy','La Salvadora de Otro Mundo','Cryo','Humana','Nora Fortis',5,'Arco',18,NULL,52,848, NULL, 'Arco del Peñasco Oscuro',4, 7.2, 'Frozen Wilds', 'Prophecies of Dawn',NULL),
('Amber','Campeona de vuelo','Pyro','Humana','Lepus',4,'Arco',18,NULL,50,793,'Mondstadt','Agitador del Relámpago',12,NULL,'Explosive Puppet','Fiery Rain',NULL),
('Baizhu','El Trasgresor de lo Mortal','Dendro','Humano','Lagenaria',5,'Catalizador',14,NULL,38,1039,'Liyue', 'Ágata del Peñasco Oscuro', 14, NULL, 'Universal Diagnosis','Holistic Revivification',NULL),
('Barbara','Ídolo Radiante','Hydro','Humana','Crater',4,'Catalizador',13,NULL,56,820,'Mondstadt','Anillo de Hakushin', 14, NULL, 'Let the Show Begin','Shining Miracle',NULL),
('Beidou','Reina del Océano sin Corona','Electro','Humana','Victor Mare',4,'Espada Pesada',18,NULL,54,1094,'Liyue','Argento Estelar de las Nieves', 2, NULL,'Tidecaller','Stormbreaker',NULL),
('Bennett','Líder de la Brigada de Benny','Pyro','Humano','Rota Calamitas',4,'Espada Ligera',16,NULL,64,1039,'Mondstadt','Cortador de Jade Primordial', 11, NULL,'Passion Overload','Fantastic Voyage',NULL),
('Candace','Custodia de la Aldea Aaru','Hydro','Humana','Sagitta Scutum',4,'Lanza',17,NULL,57,911,'Sumeru','Alabarda', 14, NULL, 'Sacred Rite: Herons Sanctum','Sacred Rite: Wagtails Tide',NULL),
('Charlotte','Reportera de El Pájaro de Vapor','Cryo','Humana','Hualina Veritas',4,'Catalizador',14,NULL,45,902,'Fontaine','Estrella Errabunda', 12, NULL, 'Framing: Freezing Point Composition','Still Photo: Comprehensive Confirmation',NULL),
('Chevreuse','Capitana de la Unidad Especial de Seguridad y Vigilancia','Pyro','Humana','Sclopetum Ensiferum',4,'Lanza',16,NULL,50,1002,'Fontaine','La Captura', 14, NULL,'Short-Range Rapid Interdiction Fire','Ring of Bursting Grenades',NULL),
('Chongyun','Desterrador del mal y los rumores sobre el mismo','Cryo','Humano','Nubis Caesor',4,'Espada Pesada',18,NULL,54,920,'Liyue','Espada del Tiempo', 12, NULL, 'Spirit Blade: Chonghuas Layered Frost','Spirit Blade: Cloud-Parting Star',NULL),
('Collei','Guardabosques en prácticas del Bosque Avidya','Dendro','Humana','Leptailurus Cervarius',4,'Arco',16,NULL,50,820,'Sumeru','Arco de Favonius', 12, NULL, 'Floral Brush','Trump-Card Kitty',NULL),
('Cyno','El Magistrado de lo Arcano','Electro','Humano','Lupus Aureus',5,'Lanza',24,NULL,66,972,'Sumeru','Lanza del Duelo', 10, NULL,'Secret Rite: Chasmic Soulfarer','Sacred Rite: Wolfs Swiftness',NULL),
('Dehya','La Leona Ardiente','Pyro','Humana','Mantichora',5,'Espada Pesada',20,NULL,48,1220,'Sumeru','Májaira Aguamarina', 14, NULL, 'Molten Inferno', 'Leonine Bite', NULL),
('Diluc','Dueño del Viñedo del Amanecer','Pyro','Humano','Noctua',5,'Espada Pesada',26,NULL,61,1010,'Mondstadt','Segadora de la Lluvia', 8, NULL,'Searing Onslaught','Dawn', NULL),
('Diona','La Cantinera Felina','Cryo','Sangre felinesa','Feles',4,'Arco',17,3,50,802,'Mondstadt','Arco del Peñasco Oscuro', 4, NULL, 'Icy Paws', 'Signature Mix', NULL),
('Dori','La Magnate Acaudalada','Electro','Humana','Magicae Lucerna',4,'Espada Pesada',18,4,60,1039,'Sumeru','Médula de la Serpiente Marina', 14, NULL,'Spirit-Warding Lamp: Troubleshooter Cannon','Alcazarzarays Exactitude',NULL),
('Eula','Caballera de la Marea','Cryo','Humana','Aphros Delos',5,'Espada Pesada',26,NULL,58,1029,'Mondstadt','Espada Real del Bosque', 10, NULL, 'Icetide Vortex','Glacial Illumination',NULL),
('Fischl','La Princesa del Juicio','Electro','Humana','Corvus',4,'Arco',20,3,49,770,'Mondstadt','Mensajero', 12, NULL, 'Nightrider', 'Midnight Phantasmagoria', NULL),
('Furina','La Bailarina Incansable','Hydro','Humana','Animula Choragi',5,'Espada Ligera',18,4,54,1191,'Fontaine','Luz Lunar de Xifos', 8, NULL, 'Salon Solitaire','Let the People Rejoice',NULL),
('Gaming','El Vigía Leonino','Pyro','Humano','Leo Expergiscens',4,'Espada Pesada',25,1,58,957,'Liyue','Espada de la Desidia', 12, NULL, 'Bestial Ascent','Suannis Gilded Dance', NULL),
('Ganyu','La Vigía del Plenilunio','Cryo','Humana','Sinae Unicornis',5,'Arco',26,5,49,762,'Liyue','Arco Real', 10, NULL, 'Trail of the Qilin','Celestial Shower', NULL),
('Gorou','El General Canino','Geo','Humano','Canis Bellatoris',4,'Arco',15,NULL,54,802,'Inazuma','Arco de Cuervo', 5, NULL, 'Inuzaka All-Round Defense', 'Juuga: Forward Unto Victory',NULL),
('Jean','Caballera de Dandelion','Anemo','Humana','Leo Menor',5,'Espada Ligera',18,5,59,1143,'Mondstadt','Rugido del León', 28, NULL, 'Gale Blade', 'Dandelion Breeze', NULL),
('Kaeya','Capitán de Caballería','Cryo','Humano','Pavo Ocellus',4,'Espada Ligera',18,2,66,975,'Mondstadt','Rompemontañas', 11, NULL, 'Frostgnaw', 'Glacial Waltz', NULL),
('Kaveh','El Espejo del Empíreo','Dendro','Humano','Paradisaea',4,'Espada Pesada',19,2,62,1002,'Sumeru','Emblema del Mar de Juncos', 9, NULL, 'Artistic Ingenuity', 'Painted Dome', NULL),
('Kirara','La Gata en los Aleros','Dendro','Humana','Arcella',4,'Espada Ligera',18,NULL,45,1021,'Inazuma','Espada del Alba', 14, NULL,'Meow-teor Kick','Secret Art: Surprise Dispatch',NULL),
('Klee','Caballero Chispeante','Pyro',NULL,'Trifolium',5,'Catalizador',24,2,47,800,'Mondstadt','Candado Terrenal', 1, NULL, 'Jumpy Dumpty', 'Sparks n Splash', NULL),
('Lisa','Bruja de las Rosas','Electro','Humana','Tempus Fugit',4,'Catalizador',19,3,48,802,'Mondstadt','Frío Eterno', 9, NULL, 'Violet Arc', 'Lightning Rose', NULL),
('Lynette','La Elegancia de las Sombras','Anemo',NULL,'Felis Alba',4,'Espada Ligera',19,4,59,1039,'Fontaine','Deseo Ponzoñoso', 7, NULL, 'Enigmatic Feint', 'Magic Trick: Astonishing Shift',NULL),
('Lyney', 'El Mago de la Fantasmagoría', 'Pyro', 'Humano', 'Felis Fuscus', 5, 'Arco', 24, NULL, 41, 857, 'Fontaine', 'Vasalla del Rey', 1, NULL, 'Bewildering Lights', 'Wondrous Trick: Miracle Parade',NULL),
('Arlecchino','La Sota','Pyro',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Scaramuccia','El Baladista',' Electro',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Inazuma',NULL,NULL,NULL,NULL,NULL,NULL),
('Dottore','El Doctor',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Guizhong','Diosa de la Arena',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Liyue',NULL,NULL,NULL,NULL,NULL,NULL),
('Colombina','La Damisela', NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Ahangar','Herrero',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sumeru',NULL,NULL,NULL,NULL,NULL,NULL),
('Fierro','Minero',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Liyue',NULL,NULL,NULL,NULL,NULL,NULL),
('Elzer','Director del Gremio de Productores de Vino',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mondstadt',NULL,NULL,NULL,NULL,NULL,NULL),
('Bruce','Caballero de Favonius',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mondstadt',NULL,NULL,NULL,NULL,NULL,NULL),
('Blanche','Dependienta de la Boutique de Mondstadt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mondstadt',NULL,NULL,NULL,NULL,NULL,NULL);

SELECT * FROM personaje;
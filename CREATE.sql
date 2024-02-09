-- Creando la tabla Arma
CREATE TABLE Arma (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    rareza INTEGER(5) NOT NULL,
    ataque_base INTEGER NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    logitud FLOAT,
    doble_filo BOOLEAN,
    peso FLOAT,
    tipo_punta VARCHAR(100),
    material_cuerda VARCHAR(100),
    tipo_magia VARCHAR(100),
    segundo_efecto VARCHAR(100) NOT NULL,
    maginitud_segundo_efecto FLOAT NOT NULL
);

-- Creando la tabla Elemento
CREATE TABLE Elemento (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL 
    CONSTRAINT CHECK_NOMBRE CHECK (nombre IN ('Anemo', 'Pyro', 'Cryo', 'Geo', 'Dendro', 'Electro', 'Hydro', 'N/A'))
);

-- Creando la tabla Region
CREATE TABLE Region (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    arconte VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    elemento_origen VARCHAR(20) NOT NULL,
    FOREIGN KEY (elemento_origen) REFERENCES Elemento(nombre)
);

-- Creando la tabla RegionInpiradas
CREATE TABLE RegionInpiradas (
    nombre_region VARCHAR(50) PRIMARY KEY NOT NULL,
    nombre_pais_real VARCHAR(50) PRIMARY KEY NOT NULL,
    FOREIGN KEY (nombre_region) REFERENCES Region(nombre)
);

-- Creando la tabla Efecto
CREATE TABLE Efecto (
    id INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT NOT NULL,
);

-- Creando la tabla Habilidad
-- INSERTS SON DE 4 CAMPOS
CREATE TABLE Habilidad (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    tipo  VARCHAR(50) NOT NULL,
    bono_atq INT NOT NULL
);

CREATE TABLE ConjuntoArtefactos (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    descripcion TEXT NOT NULL,
	efecto INT NOT NULL,
    magninitud_efecto INT NOT NULL,
    region_proveniencia VARCHAR(50) NOT NULL,
    FOREIGN KEY (efecto) REFERENCES Efecto(id),
    FOREIGN KEY (region_proveniencia) REFERENCES Region(nombre)
);

-- Creando la tabla AbismoAbisal
CREATE TABLE AbismoAbisal (
    id INT PRIMARY KEY NOT NULL,
    FechaFin DATE NOT NULL
);

-- Creando la tabla Piso
CREATE TABLE Piso (
	-- CORREGIR PRIMARY Y AGREGAR FOREIGNS
    id INT PRIMARY KEY NOT NULL,
    id_abismo_abisal INT PRIMARY KEY NOT NULL,
    tipo VARCHAR(100) NOT NULL,
	prom_estrellas FLOAT NOT NULL,
	efecto_dado INT NOT NULL,
	magnitud_efecto INT NOT NULL,
	--EFECTO PK ES ID NO NOMBRE
    FOREIGN KEY (efecto_dado) REFERENCES Efecto(id),
    FOREIGN KEY (id_abismo_abisal) REFERENCES AbismoAbisal(id)
);

-- Creando la tabla Sala
-- PDF NO TIENE NUMERO COMO PK
CREATE TABLE Sala (
    numero INTEGER(10) PRIMARY KEY NOT NULL,
    id_piso INT NOT NULL,
    id_abismo_abisal INT NOT NULL,
    FOREIGN KEY (id_piso) REFERENCES Piso(id),
    FOREIGN KEY (id_abismo_abisal) REFERENCES AbismoAbisal(id)
);

-- Creando la tabla Incluye
CREATE TABLE Incluye (
    nombre_enemigo VARCHAR(50) NOT NULL,
    numero_sala INT NOT NULL,
    id_piso INT NOT NULL,
    id_abismo_abisal INT NOT NULL,
	PRIMARY KEY (nombre_enemigo,numero_sala,id_piso,id_abismo_abisal),
    FOREIGN KEY (nombre_enemigo) REFERENCES Enemigo(nombre),
    FOREIGN KEY (numero_sala) REFERENCES Sala(numero),
    FOREIGN KEY (id_piso) REFERENCES Piso(id),
    FOREIGN KEY (id_abismo_abisal) REFERENCES AbismoAbisal(id)
);

-- Creando la tabla Concede
CREATE TABLE Concede (
    nombre_comida VARCHAR(50) NOT NULL,
    id_efecto INT PRIMARY KEY NOT NULL,
    FOREIGN KEY (nombre_comida) REFERENCES Comida(nombre),
    FOREIGN KEY (id_efecto) REFERENCES Efecto(id)
);

-- Creando la tabla Comida
CREATE TABLE Comida (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    rareza VARCHAR(70) NOT NULL,
    nombre_region VARCHAR(100) NOT NULL,
    FOREIGN KEY (nombre_region) REFERENCES Region(nombre)
);

CREATE TABLE Enemigo (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    tipo VARCHAR(70) NOT NULL,
    vida INT NOT NULL,
    tiempo_aparicion INT NOT NULL,
    elemento_imbuimiento VARCHAR(50) NOT NULL,
    FOREIGN KEY (elemento_imbuimiento) REFERENCES Elemento(nombre)
);

CREATE TABLE Aparece (
    nombre_enemigo VARCHAR(50) PRIMARY KEY NOT NULL,
    nombre_region VARCHAR(50) NOT NULL,
    FOREIGN KEY (nombre_enemigo) REFERENCES Enemigo(nombre),
    FOREIGN KEY (nombre_region) REFERENCES Region(nombre)
);


-- Creando la tabla Personaje
CREATE TABLE Personaje (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    cargo VARCHAR(70) NOT NULL,
    vision VARCHAR(70),
    tipo VARCHAR(70) ,
    constelacion VARCHAR(70),
    rareza INT,
    tipo_arma VARCHAR(70),
    ataque_base VARCHAR(70),
    vel_movimiento VARCHAR(70),
    defensa VARCHAR(70),
    vida INT,
	region_proveniencia VARCHAR(50) NOT NULL,
    nombre_arma VARCHAR(50),
    efecto_secundario VARCHAR(50),
    maginitud_segundo_efecto INT,
    habilidad_elemental VARCHAR(50),
    habilidad_definitiva VARCHAR(50),
    conjunto_artefactos VARCHAR(50),
    FOREIGN KEY (region_proveniencia) REFERENCES Region(nombre),
    FOREIGN KEY (habilidad_elemental) REFERENCES Arma(nombre),
    FOREIGN KEY (nombre_arma) REFERENCES Arma(nombre),
    FOREIGN KEY (habilidad_elemental) REFERENCES Habilidad(nombre),	
    FOREIGN KEY (habilidad_definitiva) REFERENCES Habilidad(nombre),	
    FOREIGN KEY (conjunto_artefactos) REFERENCES ConjuntoArtefactos(nombre)	
);


-- Creando la tabla Ingiere
CREATE TABLE Ingiere (
    nombre_personaje VARCHAR(50) NOT NULL,
    nombre_comida VARCHAR(50) NOT NULL,
);

-- Creando la tabla Conoce
CREATE TABLE Conoce (
    nombre_personaje1 VARCHAR(50) NOT NULL,
    nombre_personaje2 VARCHAR(50) NOT NULL,
    tipo_relacion VARCHAR(70) NOT NULL,
	PRIMARY KEY (nombre_personaje1,nombre_personaje2),
    FOREIGN KEY (nombre_personaje1,nombre_personaje2) REFERENCES Personaje(nombre,nombre)
);
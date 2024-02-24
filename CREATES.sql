/* Personaje(Nombre, Cargo, Vision, tipo, Constelación, Rareza, TipoArma, AtaqueBase,
VelMovimiento, Defensa, Vida, regionProveniencia, nombreArma, efectoSecundario,
magnitudEfectoSecundario, habilidadElemental, habilidadDefinitiva, conjuntoArtefactos)
regionProveniencia es FK de región(nombre)
nombreArma es FK de arma(nombre)
efectoSecundario es FK de Efecto (id)
habilidadElemental es FK de Habilidad(Nombre)
habilidadDefinitiva es FK de Habilidad(Nombre)
conjuntoArtefactos es FK de conjuntoArtefactos(Nombre)

Arma( Nombre, Rareza, AtaqueBase, tipo, Longitud, DobleFilo, Peso, tipoPunta,
materialCuerda, tipoMagia, segundoEfecto, magnitudSegundoEfecto)
segundoEfecto es FK de Efecto (id)

Comida( Nombre, Rareza, nombreRegión)
nombreRegión es FK de Region(Nombre)

Concede(NombreComida, idEfecto)
NombreComida es FK de Comida(Nombre)
idEfecto es FK de Efecto(id)

Ingiere(nombrePersonaje, nombreComida)
nombrePersonaje es FK de Personaje(Nombre)
nombreComida es FK de Comida(Nombre)

Efecto(Id, Nombre, Descripción)

Enemigo(Nombre, Vida, tipo, tiempoAparición, elementoImbuimiento)
elementoImbuimiento es FK de Elemento(Nombre)

Aparece( nombreEnemigo, nombreRegion)
nombreEnemigo es FK de Enemigo(Nombre)
nombreRegion es Region(Nombre)

Región( Nombre, Arconte, Descripción, elementoOrigen)
elementoOrigen es FK de Elemento(Nombre)

RegionesInspiradas( NombreRegion, NombrePaísReal)
NombreRegion es FK de Region(Nombre)

Habilidad( Nombre, Tipo, BonoATQ)

ConjuntoArtefactos( Nombre, Descripcion, efecto, magnitudEfecto, regionProveniencia)
Efecto es FK de Efecto(id)
regionProveniencia es FK de Region(Nombre)

Elemento (Nombre)

AbismoAbisal(Id, FechaFin)

Piso(Id,idAbismoAbisal, tipo, promEstrellas, efectoDado, magnitudEfecto)
efectoDado es FK de Efecto(id)
idAbismoAbisal es FK de AbismoAbisal(Id)

Sala(Numero, idPiso, idAbismoAbisal)
idPiso es FK de Piso(id)
idAbismoAbisal es FK de AbismoAbisal(Id)

Incluye(nombreEnemigo, numeroSala, idPiso, idAbismoAbisal)
nombreEnemigo es FK de Enemigo(Nombre)
numeroSala es FK de Sala(Numero)
idPiso es FK de Piso(id)
idAbismoAbisal es FK de AbismoAbisal(Id)

Conoce(nombrePersonaje1, nombrePersonaje2, tipoRelacion)
nombrePersonaje1 es FK de Personaje(Nombre)
nombrePersonaje2 es FK de Personaje(Nombre) */

-- Creando la tabla Efecto
CREATE TABLE Efecto (
    id INTEGER PRIMARY KEY NOT NULL CHECK (id >= 1),
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT NOT NULL
);

-- Creando la tabla Arma
CREATE TABLE Arma (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    rareza INTEGER NOT NULL ,
    ataque_base INTEGER NOT NULL CHECK (ataque_base >= 1),
    tipo VARCHAR(100) NOT NULL,
    longitud FLOAT CHECK (longitud >= 1 OR longitud = NULL),
    doble_filo BOOLEAN,
    peso FLOAT CHECK (peso >= 1 OR peso = NULL),
    tipo_punta VARCHAR(100),
    material_cuerda VARCHAR(100),
    tipo_magia VARCHAR(100),
    segundo_efecto INTEGER NOT NULL CHECK (segundo_efecto >= 1),
    maginitud_segundo_efecto FLOAT NOT NULL CHECK (maginitud_segundo_efecto != 0)
);

CREATE FUNCTION tr_arma_function() 
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tipo = 'Espada Ligera' THEN 
        IF NEW.peso IS NOT NULL OR NEW.tipo_punta IS NOT NULL OR NEW.material_cuerda IS NOT NULL OR NEW.tipo_magia IS NOT NULL THEN 
            RAISE EXCEPTION 'Atributo invalido en Arma de tipo Espada Ligera.'; 
        END IF;
    END IF;

    IF NEW.tipo = 'Espada Pesada' THEN 
        IF NEW.longitud IS NOT NULL OR NEW.doble_filo IS NOT NULL OR NEW.tipo_punta IS NOT NULL OR NEW.material_cuerda IS NOT NULL OR NEW.tipo_magia IS NOT NULL THEN 
            RAISE EXCEPTION 'Atributo invalido en Arma de tipo Espada Pesada.';
        END IF;
    END IF;

    IF NEW.tipo = 'Lanza' THEN 
        IF NEW.longitud IS NOT NULL OR NEW.doble_filo IS NOT NULL OR NEW.peso IS NOT NULL OR NEW.material_cuerda IS NOT NULL OR NEW.tipo_magia IS NOT NULL THEN
            RAISE EXCEPTION 'Atributo invalido en Arma de tipo Lanza.';
        END IF;
    END IF;

    IF NEW.tipo = 'Arco' THEN 
        IF NEW.longitud IS NOT NULL OR NEW.doble_filo IS NOT NULL OR NEW.peso IS NOT NULL OR NEW.tipo_magia IS NOT NULL OR NEW.tipo_punta IS NOT NULL THEN 
            RAISE EXCEPTION 'Atributo invalido en Arma de tipo Arco.';
        END IF;
    END IF;

    IF NEW.tipo = 'Catalizador' THEN 
        IF NEW.longitud IS NOT NULL OR NEW.doble_filo IS NOT NULL OR NEW.peso IS NOT NULL OR NEW.material_cuerda IS NOT NULL OR NEW.tipo_punta IS NOT NULL THEN
            RAISE EXCEPTION 'Atributo invalido en Arma de tipo Catalizador.';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_arma 
BEFORE INSERT OR UPDATE ON Arma
FOR EACH ROW
EXECUTE FUNCTION tr_arma_function();

CREATE FUNCTION verificar_magnitud_efecto_arma_function()
RETURNS TRIGGER AS $$
DECLARE
    efecto_nombre VARCHAR(50);
BEGIN
    SELECT nombre INTO efecto_nombre
        FROM efecto
        WHERE id = NEW.segundo_efecto;
    IF efecto_nombre = '%ATQ' THEN
        IF NEW.maginitud_segundo_efecto < 1 OR  NEW.maginitud_segundo_efecto > 50 THEN
                RAISE EXCEPTION 'ATQ tiene que estar entre 1 y 50';
        END IF;
    END IF;
    IF efecto_nombre = '%Maestria Elemental' THEN
        IF NEW.maginitud_segundo_efecto < 40 OR  NEW.maginitud_segundo_efecto > 600 THEN
                RAISE EXCEPTION 'Maestria Elemental debe ser un numero entre 40 y 600';
        END IF;
    END IF;
    IF efecto_nombre = '%Daño Elemental' THEN
        IF NEW.maginitud_segundo_efecto < 1 OR  NEW.maginitud_segundo_efecto > 50 THEN
                RAISE EXCEPTION 'Daño Elemental tiene que estar entre 1 y 50';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER verificar_magnitud_efecto_arma 
BEFORE INSERT OR UPDATE ON Arma
FOR EACH ROW
EXECUTE FUNCTION verificar_magnitud_efecto_arma_function();

-- DROP FUNCTION tr_arma_function;
-- DROP TRIGGER IF EXISTS tr_arma ON arma;

ALTER TABLE Arma 
ADD CONSTRAINT CHECK_ARMA CHECK (tipo IN ('Espada Ligera', 'Espada Pesada', 'Lanza', 'Arco', 'Catalizador') AND 
tipo_punta IN ('Alemana', 'Europea Funcional', 'Frámea Merovingia', 'Inglesa') AND
tipo_magia IN ('Ofensiva', 'Defensiva', 'Soporte'));

-- Creando la tabla Elemento
CREATE TABLE Elemento (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL 
);

ALTER TABLE Elemento 
ADD CONSTRAINT CHECK_NOMBRE CHECK (nombre IN ('Anemo', 'Pyro', 'Cryo', 'Geo', 'Dendro', 'Electro', 'Hydro', 'N/A'));


-- Creando la tabla Region
CREATE TABLE Region (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    arconte VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    elemento_origen VARCHAR(20) NOT NULL,
    FOREIGN KEY (elemento_origen) REFERENCES Elemento(nombre)
);

-- Creando la tabla RegionInpiradas
CREATE TABLE RegionesInspiradas (
    nombre_region VARCHAR(50)  NOT NULL,
    nombre_pais_real VARCHAR(50) NOT NULL,
    PRIMARY KEY(nombre_region,nombre_pais_real),
    FOREIGN KEY (nombre_region) REFERENCES Region(nombre)
);


-- Creando la tabla Habilidad
CREATE TABLE Habilidad (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    tipo  VARCHAR(50) NOT NULL,
    bono_atq FLOAT NOT NULL CHECK (bono_atq >= 25 AND bono_atq <= 1000)
);

ALTER TABLE Habilidad 
ADD CONSTRAINT CHECK_TIPO CHECK (tipo IN ('Definitiva', 'Elemental'));


CREATE TABLE ConjuntoArtefactos (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    descripcion TEXT NOT NULL,
	efecto INTEGER NOT NULL CHECK (efecto >= 1),
    magnitud_efecto FLOAT NOT NULL CHECK (magnitud_efecto != 0),
    region_proveniencia VARCHAR(50) NOT NULL,
    FOREIGN KEY (efecto) REFERENCES Efecto(id),
    FOREIGN KEY (region_proveniencia) REFERENCES Region(nombre)
);

-- Creando la tabla AbismoAbisal
CREATE TABLE AbismoAbisal (
    id INTEGER PRIMARY KEY NOT NULL CHECK (id >= 1),
    FechaFin DATE NOT NULL,
    CONSTRAINT unique_id UNIQUE(id)
);

-- Creando la tabla Piso
CREATE TABLE Piso (
	-- REVISAR UNIQUE
    id INTEGER NOT NULL CHECK (id >= 1),
    id_abismo_abisal INTEGER NOT NULL CHECK (id_abismo_abisal >= 1),
    tipo VARCHAR(100) NOT NULL,
	prom_estrellas VARCHAR(70),
	efecto_dado INTEGER NOT NULL CHECK (efecto_dado >= 1),
	magnitud_efecto INTEGER NOT NULL CHECK (magnitud_efecto != 0),
    UNIQUE(id, id_abismo_abisal),
    PRIMARY KEY (id,id_abismo_abisal),
    FOREIGN KEY (efecto_dado) REFERENCES Efecto(id),
    FOREIGN KEY (id_abismo_abisal) REFERENCES AbismoAbisal(id)
);

ALTER TABLE Piso
ADD CONSTRAINT CHECK_PISO_TIPO CHECK (tipo IN ('Regular', 'Cambiante'));

CREATE FUNCTION verificar_tipo_piso_function()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tipo = 'Regular' THEN
        IF NEW.prom_estrellas IS NOT NULL THEN
            RAISE EXCEPTION 'Los pisos regulares no tienen promedio de estrellas';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER verificar_tipo_piso 
BEFORE INSERT OR UPDATE ON Piso
FOR EACH ROW
EXECUTE FUNCTION verificar_tipo_piso_function();

-- Creando la tabla Sala
CREATE TABLE Sala (
    numero INTEGER NOT NULL CHECK (numero >= 1 AND numero <=3),
    id_piso INTEGER NOT NULL CHECK (id_piso >= 1 AND id_piso <=12),
    id_abismo_abisal INTEGER NOT NULL CHECK (id_abismo_abisal >= 1),
    UNIQUE (numero,id_piso, id_abismo_abisal),
    PRIMARY KEY(numero,id_piso,id_abismo_abisal),
    FOREIGN KEY (id_piso,id_abismo_abisal) REFERENCES Piso(id,id_abismo_abisal)
);

-- Creando la tabla Comida
CREATE TABLE Comida (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    rareza INTEGER NOT NULL,
    nombre_region VARCHAR(100) NOT NULL,
    FOREIGN KEY (nombre_region) REFERENCES Region(nombre)
);

SELECT * FROM comida;

-- Creando la tabla Concede
CREATE TABLE Concede (
    nombre_comida  VARCHAR(50) PRIMARY KEY NOT NULL,
    id_efecto INTEGER NOT NULL CHECK (id_efecto >= 1),
    FOREIGN KEY (nombre_comida) REFERENCES Comida(nombre),
    FOREIGN KEY (id_efecto) REFERENCES Efecto(id)
);

CREATE TABLE Enemigo (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    tipo VARCHAR(70) NOT NULL,
    vida INTEGER NOT NULL,
    tiempo_aparicion INTEGER NOT NULL,
    elemento_imbuimiento VARCHAR(50) NOT NULL,
    FOREIGN KEY (elemento_imbuimiento) REFERENCES Elemento(nombre)
);

CREATE TABLE Aparece (
    nombre_enemigo VARCHAR(50) PRIMARY KEY NOT NULL,
    nombre_region VARCHAR(50) NOT NULL,
    FOREIGN KEY (nombre_enemigo) REFERENCES Enemigo(nombre),
    FOREIGN KEY (nombre_region) REFERENCES Region(nombre)
);

-- Creando la tabla Incluye
CREATE TABLE Incluye (
    nombre_enemigo VARCHAR(50) NOT NULL,
    numero_sala INTEGER NOT NULL CHECK (numero_sala >= 1 AND numero_sala <=3),
    id_piso INTEGER NOT NULL CHECK (id_piso >= 1 AND id_piso <=12),
    id_abismo_abisal INTEGER NOT NULL CHECK (id_abismo_abisal >= 1),
    cantidad INTEGER NOT NULL CHECK (cantidad >= 1),
	PRIMARY KEY (nombre_enemigo,numero_sala,id_piso,id_abismo_abisal),
    FOREIGN KEY (nombre_enemigo) REFERENCES Enemigo(nombre),
    FOREIGN KEY (numero_sala,id_piso,id_abismo_abisal) REFERENCES Sala(numero,id_piso,id_abismo_abisal)
);


-- Creando la tabla Personaje con checks en las variables de rareza, vida, defensa, velocidad de movimiento y ataque base
-- que se refieren a que los valores numericos no pueden ser menores a 1, aparte que la rareza va de 4 o 5 estrellas y puede ser null
CREATE TABLE Personaje (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    cargo VARCHAR(70) NOT NULL,
    vision VARCHAR(70) NOT NULL,
    tipo VARCHAR(70) NOT NULL,
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

ALTER TABLE Personaje
ADD CONSTRAINT CHECK_PERSONAJE CHECK (vision IN ('Anemo', 'Pyro', 'Cryo', 'Geo', 'Dendro', 'Electro', 'Hydro', 'N/A'));

ALTER TABLE Personaje
ADD CONSTRAINT CHECK_PERSONAJE_TIPO CHECK (tipo IN ('Jugable', 'No Jugable'));

CREATE FUNCTION verificar_tipo_personaje_function()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tipo = 'No Jugable' THEN
        IF NEW.constelacion IS NOT NULL OR  NEW.rareza IS NOT NULL OR  NEW.tipo_arma IS NOT NULL
        OR  NEW.ataque_base IS NOT NULL OR  NEW.vel_movimiento IS NOT NULL OR  NEW.defensa IS NOT NULL 
        OR  NEW.vida IS NOT NULL OR  NEW.nombre_arma IS NOT NULL OR  NEW.efecto_secundario IS NOT NULL
        OR  NEW.maginitud_segundo_efecto IS NOT NULL OR  NEW.habilidad_elemental IS NOT NULL OR  NEW.habilidad_definitiva IS NOT NULL
        OR  NEW.conjunto_artefactos IS NOT NULL THEN
            RAISE EXCEPTION 'Los personajes No Jugables deben tener los valores NULL';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER verificar_tipo_personaje 
BEFORE INSERT OR UPDATE ON Arma
FOR EACH ROW
EXECUTE FUNCTION verificar_tipo_personaje_function();


CREATE FUNCTION verificar_magnitud_efecto_function()
RETURNS TRIGGER AS $$
DECLARE
    efecto_nombre VARCHAR(50);
BEGIN
  SELECT nombre INTO efecto_nombre
        FROM efecto
        WHERE id = NEW.efecto_secundario;
    IF efecto_nombre = '%ATQ' THEN
        IF NEW.maginitud_segundo_efecto < 1 OR  NEW.maginitud_segundo_efecto > 50 THEN
                RAISE EXCEPTION 'ATQ tiene que estar entre 1 y 50';
        END IF;
    END IF;
    IF efecto_nombre = '%Maestria Elemental' THEN
        IF NEW.maginitud_segundo_efecto < 40 OR  NEW.maginitud_segundo_efecto > 600 THEN
                RAISE EXCEPTION 'Maestria Elemental debe ser un numero entre 40 y 600';
        END IF;
    END IF;
    IF efecto_nombre = '%Daño Elemental' THEN
        IF NEW.maginitud_segundo_efecto < 1 OR  NEW.maginitud_segundo_efecto > 50 THEN
                RAISE EXCEPTION 'Daño Elemental tiene que estar entre 1 y 50';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER verificar_magnitud_efecto 
BEFORE INSERT OR UPDATE ON Personaje
FOR EACH ROW
EXECUTE FUNCTION verificar_magnitud_efecto_function();




CREATE FUNCTION verificar_tipo_arma()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.Tipo = 'Jugable' AND NEW.tipo_arma IS NOT NULL AND EXISTS (SELECT 1 
        FROM Arma
        WHERE nombre = NEW.nombre_arma AND tipo = NEW.tipo_arma) THEN
        RETURN NEW;
        ELSE 
            RAISE EXCEPTION 'El tipo de arma asignado no es compatible con el arma';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verificar_tipo_arma
BEFORE INSERT OR UPDATE ON Personaje
FOR EACH ROW
EXECUTE FUNCTION verificar_tipo_arma();
    

-- Creando la tabla Conoce
CREATE TABLE Conoce (
    nombre_personaje1 VARCHAR(50) NOT NULL,
    nombre_personaje2 VARCHAR(50) NOT NULL,
    tipo_relacion VARCHAR(70) NOT NULL,
	PRIMARY KEY (nombre_personaje1,nombre_personaje2),
    FOREIGN KEY (nombre_personaje1) REFERENCES Personaje(nombre),
    FOREIGN KEY (nombre_personaje2) REFERENCES Personaje(nombre)
);

-- Creando la tabla Ingiere

CREATE TABLE Ingiere (
    nombre_personaje VARCHAR(50) NOT NULL,
    nombre_comida VARCHAR(50) NOT NULL,
    FOREIGN KEY (nombre_personaje) REFERENCES Personaje(nombre),
    FOREIGN KEY (nombre_comida) REFERENCES Comida(nombre)
);


-- SELECT P.nombre, P.vision, P.region_proveniencia
-- FROM Personaje P, Region R
-- WHERE P.rareza = 4 AND P.vision NOT IN (SELECT R.elemento_origen 
-- FROM Region R
-- WHERE P.region_proveniencia = R.nombre)

-- ORDER BY R.nombre ASC, P.nombre ASC;

-- SELECT nombre, Tipo, rareza
-- FROM Arma
-- WHERE ataque_base > 600;

SELECT *
FROM RegionesInspiradas;

SELECT DISTINCT(P.nombre)
FROM personaje P
JOIN Conoce C1 ON C1.nombre_personaje1 = P.nombre
JOIN Conoce C2 ON C2.nombre_personaje2 = P.nombre
JOIN Ingiere I1 ON I1.nombre_personaje = C1.nombre_personaje1
JOIN Ingiere I2 ON I2.nombre_personaje = C2.nombre_personaje2
WHERE C1.tipo_relacion = 'Enemistad' AND I1.nombre_comida = I2.nombre_comida AND P.nombre <> C2.nombre_personaje1;


--PARA HACER DELETE DE LAS TABLAS PARA TESTEO:
-- DROP TABLE arma,elemento,region,regionesinspiradas, habilidad, efecto,piso, sala, abismoabisal, conjuntoartefactos, comida, concede, enemigo, aparece, incluye, personaje, conoce, ingiere;



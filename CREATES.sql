/* 
***MODELO RELACIONAL***

Personaje(Nombre, Cargo, Vision, tipo, Constelación, Rareza, TipoArma, AtaqueBase,
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
    AtaqueBase INTEGER NOT NULL CHECK (AtaqueBase >= 1),
    tipo VARCHAR(100) NOT NULL,
    longitud FLOAT CHECK (longitud >= 1 OR longitud = NULL),
    DobleFilo BOOLEAN,
    peso FLOAT CHECK (peso >= 1 OR peso = NULL),
    tipoPunta VARCHAR(100),
    materialCuerda VARCHAR(100),
    tipoMagia VARCHAR(100),
    segundoEfecto INTEGER NOT NULL CHECK (segundoEfecto >= 1),
    magnitudSegundoEfecto FLOAT NOT NULL CHECK (magnitudSegundoEfecto != 0),
    FOREIGN KEY (segundoEfecto) REFERENCES Efecto(id)
);

-- Restriccion Avanzada 3
-- La herencia de las armas y cada uno de sus 5 tipos

CREATE FUNCTION tr_arma_function() 
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tipo = 'Espada Ligera' THEN 
        IF NEW.peso IS NOT NULL OR NEW.tipoPunta IS NOT NULL OR NEW.materialCuerda IS NOT NULL OR NEW.tipoMagia IS NOT NULL THEN 
            RAISE EXCEPTION 'Atributo invalido en Arma de tipo Espada Ligera.'; 
        END IF;
    END IF;

    IF NEW.tipo = 'Espada Pesada' THEN 
        IF NEW.longitud IS NOT NULL OR NEW.DobleFilo IS NOT NULL OR NEW.tipoPunta IS NOT NULL OR NEW.materialCuerda IS NOT NULL OR NEW.tipoMagia IS NOT NULL THEN 
            RAISE EXCEPTION 'Atributo invalido en Arma de tipo Espada Pesada.';
        END IF;
    END IF;

    IF NEW.tipo = 'Lanza' THEN 
        IF NEW.longitud IS NOT NULL OR NEW.DobleFilo IS NOT NULL OR NEW.peso IS NOT NULL OR NEW.materialCuerda IS NOT NULL OR NEW.tipoMagia IS NOT NULL THEN
            RAISE EXCEPTION 'Atributo invalido en Arma de tipo Lanza.';
        END IF;
    END IF;

    IF NEW.tipo = 'Arco' THEN 
        IF NEW.longitud IS NOT NULL OR NEW.DobleFilo IS NOT NULL OR NEW.peso IS NOT NULL OR NEW.tipoMagia IS NOT NULL OR NEW.tipoPunta IS NOT NULL THEN 
            RAISE EXCEPTION 'Atributo invalido en Arma de tipo Arco.';
        END IF;
    END IF;

    IF NEW.tipo = 'Catalizador' THEN 
        IF NEW.longitud IS NOT NULL OR NEW.DobleFilo IS NOT NULL OR NEW.peso IS NOT NULL OR NEW.materialCuerda IS NOT NULL OR NEW.tipoPunta IS NOT NULL THEN
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

-- Restriccion Simple 5 en Arma

CREATE FUNCTION verificar_magnitudEfecto_arma_function()
RETURNS TRIGGER AS $$
DECLARE
    efecto_nombre VARCHAR(50);
BEGIN
    SELECT nombre INTO efecto_nombre
        FROM efecto
        WHERE id = NEW.segundoEfecto;
    IF efecto_nombre = '%ATQ' THEN
        IF NEW.magnitudSegundoEfecto < 1 OR  NEW.magnitudSegundoEfecto > 50 THEN
                RAISE EXCEPTION 'ATQ tiene que estar entre 1 y 50';
        END IF;
    END IF;
    IF efecto_nombre = '%Maestria Elemental' THEN
        IF NEW.magnitudSegundoEfecto < 40 OR  NEW.magnitudSegundoEfecto > 600 THEN
                RAISE EXCEPTION 'Maestria Elemental debe ser un numero entre 40 y 600';
        END IF;
    END IF;
    IF efecto_nombre = '%Daño Elemental' THEN
        IF NEW.magnitudSegundoEfecto < 1 OR  NEW.magnitudSegundoEfecto > 50 THEN
                RAISE EXCEPTION 'Daño Elemental tiene que estar entre 1 y 50';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER verificar_magnitudEfecto_arma 
BEFORE INSERT OR UPDATE ON Arma
FOR EACH ROW
EXECUTE FUNCTION verificar_magnitudEfecto_arma_function();

-- DROP FUNCTION tr_arma_function;
-- DROP TRIGGER IF EXISTS tr_arma ON arma;

-- Restriccion Simple 3
-- Cumplir las restricciones de las armas, especificadas entre paréntesis en la Fase I.

ALTER TABLE Arma 
ADD CONSTRAINT CHECK_ARMA CHECK (tipo IN ('Espada Ligera', 'Espada Pesada', 'Lanza', 'Arco', 'Catalizador') AND 
tipoPunta IN ('Alemana', 'Europea Funcional', 'Frámea Merovingia', 'Inglesa') AND
tipoMagia IN ('Ofensiva', 'Defensiva', 'Soporte'));

-- Creando la tabla Elemento

CREATE TABLE Elemento (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL 
);

-- Restriccion Simple 1
-- Los elementos admitidos son los típicos del juego ( ‘Anemo’, ‘Pyro’, ‘Cryo’, ‘Geo’, ‘Dendro’, ‘Electro’, ‘Hydro’), 
-- en caso del embuimiento de enemigos (que suelen no estarlo por defecto), se puede aceptar el “elemento” ‘N/A también.

ALTER TABLE Elemento 
ADD CONSTRAINT CHECK_NOMBRE CHECK (nombre IN ('Anemo', 'Pyro', 'Cryo', 'Geo', 'Dendro', 'Electro', 'Hydro', 'N/A'));


-- Creando la tabla Region

CREATE TABLE Region (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    arconte VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    elementoOrigen VARCHAR(20) NOT NULL,
    FOREIGN KEY (elementoOrigen) REFERENCES Elemento(nombre)
);

-- Creando la tabla Comida

CREATE TABLE Comida (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    rareza INTEGER NOT NULL,
    nombreRegion VARCHAR(100) NOT NULL,
    FOREIGN KEY (nombreRegion) REFERENCES Region(nombre)
);

-- Creando la tabla Concede

CREATE TABLE Concede (
    nombreComida  VARCHAR(50) PRIMARY KEY NOT NULL,
    idEfecto INTEGER NOT NULL CHECK (idEfecto >= 1),
    FOREIGN KEY (nombreComida) REFERENCES Comida(nombre),
    FOREIGN KEY (idEfecto) REFERENCES Efecto(id)
);

-- Creando la tabla ConjuntoArtefactos

CREATE TABLE ConjuntoArtefactos (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    descripcion TEXT NOT NULL,
	efecto INTEGER NOT NULL CHECK (efecto >= 1),
    magnitudEfecto FLOAT NOT NULL CHECK (magnitudEfecto != 0),
    regionProveniencia VARCHAR(50) NOT NULL,
    FOREIGN KEY (efecto) REFERENCES Efecto(id),
    FOREIGN KEY (regionProveniencia) REFERENCES Region(nombre)
);

-- Creando la tabla Enemigo

CREATE TABLE Enemigo (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    tipo VARCHAR(70) NOT NULL,
    vida INTEGER NOT NULL,
    tiempoAparicion INTEGER NOT NULL,
    elementoImbuimiento VARCHAR(50) NOT NULL,
    FOREIGN KEY (elementoImbuimiento) REFERENCES Elemento(nombre)
);

-- Creando la tabla Aparece

CREATE TABLE Aparece (
    nombreEnemigo VARCHAR(50) PRIMARY KEY NOT NULL,
    nombreRegion VARCHAR(50) NOT NULL,
    FOREIGN KEY (nombreEnemigo) REFERENCES Enemigo(nombre),
    FOREIGN KEY (nombreRegion) REFERENCES Region(nombre)
);

-- Creando la tabla RegionInpiradas

CREATE TABLE RegionesInspiradas (
    nombreRegion VARCHAR(50)  NOT NULL,
    nombrePaisReal VARCHAR(50) NOT NULL,
    PRIMARY KEY(nombreRegion,nombrePaisReal),
    FOREIGN KEY (nombreRegion) REFERENCES Region(nombre)
);

-- Creando la tabla Habilidad

CREATE TABLE Habilidad (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    tipo  VARCHAR(50) NOT NULL,
    bonoATQ FLOAT NOT NULL CHECK (bonoATQ >= 25 AND bonoATQ <= 1000)
);

-- Restriccion Simple 4
-- Cumplir las restricciones de las habilidades, especificadas entre paréntesis en la Fase I.

ALTER TABLE Habilidad 
ADD CONSTRAINT CHECK_TIPO CHECK (tipo IN ('Definitiva', 'Elemental'));

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
    idAbismoAbisal INTEGER NOT NULL CHECK (idAbismoAbisal >= 1),
    tipo VARCHAR(100) NOT NULL,
	promEstrellas VARCHAR(70),
	efectoDado INTEGER NOT NULL CHECK (efectoDado >= 1),
	magnitudEfecto INTEGER NOT NULL CHECK (magnitudEfecto != 0),
    UNIQUE(id, idAbismoAbisal),
    PRIMARY KEY (id,idAbismoAbisal),
    FOREIGN KEY (efectoDado) REFERENCES Efecto(id),
    FOREIGN KEY (idAbismoAbisal) REFERENCES AbismoAbisal(id)
);

ALTER TABLE Piso
ADD CONSTRAINT CHECK_PISO_TIPO CHECK (tipo IN ('Regular', 'Cambiante'));

CREATE FUNCTION verificar_tipo_piso_function()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tipo = 'Regular' THEN
        IF NEW.promEstrellas IS NOT NULL THEN
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
    idPiso INTEGER NOT NULL CHECK (idPiso >= 1 AND idPiso <=12),
    idAbismoAbisal INTEGER NOT NULL CHECK (idAbismoAbisal >= 1),
    UNIQUE (numero,idPiso, idAbismoAbisal),
    PRIMARY KEY(numero,idPiso,idAbismoAbisal),
    FOREIGN KEY (idPiso,idAbismoAbisal) REFERENCES Piso(id,idAbismoAbisal)
);


-- Creando la tabla Incluye

CREATE TABLE Incluye (
    nombreEnemigo VARCHAR(50) NOT NULL,
    numeroSala INTEGER NOT NULL CHECK (numeroSala >= 1 AND numeroSala <=3),
    idPiso INTEGER NOT NULL CHECK (idPiso >= 1 AND idPiso <=12),
    idAbismoAbisal INTEGER NOT NULL CHECK (idAbismoAbisal >= 1),
    cantidad INTEGER NOT NULL CHECK (cantidad >= 1),
	PRIMARY KEY (nombreEnemigo,numeroSala,idPiso,idAbismoAbisal),
    FOREIGN KEY (nombreEnemigo) REFERENCES Enemigo(nombre),
    FOREIGN KEY (numeroSala,idPiso,idAbismoAbisal) REFERENCES Sala(numero,idPiso,idAbismoAbisal)
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
    tipoArma VARCHAR(70),
    AtaqueBase FLOAT CHECK (AtaqueBase >= 1),
    velMovimiento FLOAT CHECK (velMovimiento >= 1),
    defensa FLOAT CHECK (defensa >= 1),
    vida INTEGER CHECK (vida >= 1),
	regionProveniencia VARCHAR(50),
    nombreArma VARCHAR(50),
    efectoSecundario INTEGER CHECK (efectoSecundario >= 1),
    magnitudSegundoEfecto FLOAT,
    habilidadElemental VARCHAR(50),
    habilidadDefinitiva VARCHAR(50),
    conjuntoArtefactos VARCHAR(50),
    FOREIGN KEY (regionProveniencia) REFERENCES Region(nombre),
    FOREIGN KEY (nombreArma) REFERENCES Arma(nombre),
    FOREIGN KEY (efectoSecundario) REFERENCES Efecto(id),
    FOREIGN KEY (habilidadElemental) REFERENCES Habilidad(nombre),	
    FOREIGN KEY (habilidadDefinitiva) REFERENCES Habilidad(nombre),	
    FOREIGN KEY (conjuntoArtefactos) REFERENCES ConjuntoArtefactos(nombre)	
);

-- Visiones admitidas en Personaje

ALTER TABLE Personaje
ADD CONSTRAINT CHECK_PERSONAJE CHECK (vision IN ('Anemo', 'Pyro', 'Cryo', 'Geo', 'Dendro', 'Electro', 'Hydro', 'N/A') AND tipo IN ('Jugable', 'No Jugable'));

-- Restriccion Avanzada 2
-- La herencia de personajes no jugables y jugables

CREATE FUNCTION verificar_tipo_personaje_function()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tipo = 'No Jugable' THEN
        IF NEW.constelacion IS NOT NULL OR  NEW.rareza IS NOT NULL OR  NEW.tipoArma IS NOT NULL
        OR  NEW.AtaqueBase IS NOT NULL OR  NEW.velMovimiento IS NOT NULL OR  NEW.defensa IS NOT NULL 
        OR  NEW.vida IS NOT NULL OR  NEW.nombreArma IS NOT NULL OR  NEW.efectoSecundario IS NOT NULL
        OR  NEW.magnitudSegundoEfecto IS NOT NULL OR  NEW.habilidadElemental IS NOT NULL OR  NEW.habilidadDefinitiva IS NOT NULL
        OR  NEW.conjuntoArtefactos IS NOT NULL THEN
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

-- Restriccion Simple 5 en Personaje

CREATE FUNCTION verificar_magnitudEfecto_function()
RETURNS TRIGGER AS $$
DECLARE
    efecto_nombre VARCHAR(50);
BEGIN
  SELECT nombre INTO efecto_nombre
        FROM efecto
        WHERE id = NEW.efectoSecundario;
    IF efecto_nombre = '%ATQ' THEN
        IF NEW.magnitudSegundoEfecto < 1 OR  NEW.magnitudSegundoEfecto > 50 THEN
                RAISE EXCEPTION 'ATQ tiene que estar entre 1 y 50';
        END IF;
    END IF;
    IF efecto_nombre = '%Maestria Elemental' THEN
        IF NEW.magnitudSegundoEfecto < 40 OR  NEW.magnitudSegundoEfecto > 600 THEN
                RAISE EXCEPTION 'Maestria Elemental debe ser un numero entre 40 y 600';
        END IF;
    END IF;
    IF efecto_nombre = '%Daño Elemental' THEN
        IF NEW.magnitudSegundoEfecto < 1 OR  NEW.magnitudSegundoEfecto > 50 THEN
                RAISE EXCEPTION 'Daño Elemental tiene que estar entre 1 y 50';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER verificar_magnitudEfecto 
BEFORE INSERT OR UPDATE ON Personaje
FOR EACH ROW
EXECUTE FUNCTION verificar_magnitudEfecto_function();


-- Restriccion Avanzada 1
-- Que antes de insertar o actualizar un personaje jugable, se verifique 
-- si el arma que tiene asignada posee un mismo tipo de arma que las que él puede usar. 

CREATE FUNCTION verificar_tipoArma()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tipo = 'Jugable' AND NEW.tipoArma IS NOT NULL AND NOT EXISTS (SELECT 1 
        FROM Arma
        WHERE nombre = NEW.nombreArma AND tipo = NEW.tipoArma) THEN
            RAISE EXCEPTION 'El tipo de arma asignado no es compatible con el arma';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verificar_tipoArma
BEFORE INSERT OR UPDATE ON Personaje
FOR EACH ROW
EXECUTE FUNCTION verificar_tipoArma();
    

-- Creando la tabla Conoce

CREATE TABLE Conoce (
    nombrePersonaje1 VARCHAR(50) NOT NULL,
    nombrePersonaje2 VARCHAR(50) NOT NULL,
    tipoRelacion VARCHAR(70) NOT NULL,
	PRIMARY KEY (nombrePersonaje1,nombrePersonaje2),
    FOREIGN KEY (nombrePersonaje1) REFERENCES Personaje(nombre),
    FOREIGN KEY (nombrePersonaje2) REFERENCES Personaje(nombre)
);

-- Creando la tabla Ingiere

CREATE TABLE Ingiere (
    nombrePersonaje VARCHAR(50) NOT NULL,
    nombreComida VARCHAR(50) NOT NULL,
    FOREIGN KEY (nombrePersonaje) REFERENCES Personaje(nombre),
    FOREIGN KEY (nombreComida) REFERENCES Comida(nombre)
);

--PARA HACER DELETE DE LAS TABLAS PARA TESTEO:
-- DROP TABLE arma,elemento,region,regionesinspiradas, habilidad, efecto,piso, sala, abismoabisal, conjuntoartefactos, comida, concede, enemigo, aparece, incluye, personaje, conoce, ingiere;



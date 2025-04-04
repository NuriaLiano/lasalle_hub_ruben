CREATE DATABASE IF NOT EXISTS lasallehub;
USE lasallehub;

-- Tabla Usuario
CREATE TABLE IF NOT EXISTS Usuario (
    DNI VARCHAR(9) PRIMARY KEY,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50),
    correo_electronico VARCHAR(100),
    contraseña VARCHAR(255),
    fecha_registro DATE,
    img TEXT
);

-- Tabla Alumno, Profesor, Administrador (Herencia)
CREATE TABLE IF NOT EXISTS Alumno (
    DNI VARCHAR(9) PRIMARY KEY,
    FOREIGN KEY (DNI) REFERENCES Usuario(DNI)
);

CREATE TABLE IF NOT EXISTS Profesor (
    DNI VARCHAR(9) PRIMARY KEY,
    FOREIGN KEY (DNI) REFERENCES Usuario(DNI)
);

CREATE TABLE IF NOT EXISTS Administrador (
    DNI VARCHAR(9) PRIMARY KEY,
    FOREIGN KEY (DNI) REFERENCES Usuario(DNI)
);

-- Tabla Grado
CREATE TABLE IF NOT EXISTS Grado (
    id_grado INT PRIMARY KEY,
    nombre_grado VARCHAR(100)
);

-- Tabla Asignatura
CREATE TABLE IF NOT EXISTS Asignatura (
    id_asignatura INT,
    id_grado INT,
    nombre_asignatura VARCHAR(100),
    PRIMARY KEY (id_asignatura, id_grado),
    FOREIGN KEY (id_grado) REFERENCES Grado(id_grado)
);

-- Tabla Recurso
CREATE TABLE IF NOT EXISTS Recurso (
    id_recurso INT PRIMARY KEY,
    nombre_recurso VARCHAR(100),
    descripcion TEXT,
    enlace TEXT,
    tipo VARCHAR(50)
);

-- Tabla Pertenece
CREATE TABLE IF NOT EXISTS Pertenece (
    id_recurso INT,
    id_resena INT,
    PRIMARY KEY (id_recurso, id_resena),
    FOREIGN KEY (id_recurso) REFERENCES Recurso(id_recurso)
);

-- Tabla Reseña
CREATE TABLE IF NOT EXISTS Resena (
    id_resena INT PRIMARY KEY,
    comentario TEXT,
    fecha DATE,
    puntuacion INT
);

-- Tabla Valora
CREATE TABLE IF NOT EXISTS Valora (
    id_resena INT,
    DNI VARCHAR(9),
    fecha_publicacion DATE,
    PRIMARY KEY (id_resena, DNI),
    FOREIGN KEY (id_resena) REFERENCES Resena(id_resena),
    FOREIGN KEY (DNI) REFERENCES Usuario(DNI)
);

-- Tabla Publica
CREATE TABLE IF NOT EXISTS Publica (
    DNI VARCHAR(9),
    id_recurso INT,
    fecha_publicacion DATE,
    id_asignatura INT,
    id_grado INT,
    PRIMARY KEY (DNI, id_recurso),
    FOREIGN KEY (DNI) REFERENCES Usuario(DNI),
    FOREIGN KEY (id_recurso) REFERENCES Recurso(id_recurso),
    FOREIGN KEY (id_asignatura, id_grado) REFERENCES Asignatura(id_asignatura, id_grado)
);

-- Tabla Relacionado
CREATE TABLE IF NOT EXISTS Relacionado (
    id_recurso INT,
    id_asignatura INT,
    id_grado INT,
    PRIMARY KEY (id_recurso, id_asignatura, id_grado),
    FOREIGN KEY (id_recurso) REFERENCES Recurso(id_recurso),
    FOREIGN KEY (id_asignatura, id_grado) REFERENCES Asignatura(id_asignatura, id_grado)
);

-- Tabla Modera
CREATE TABLE IF NOT EXISTS Modera (
    id_asignatura INT,
    id_grado INT,
    DNI VARCHAR(9),
    fecha_autorizacion DATE,
    PRIMARY KEY (id_asignatura, id_grado, DNI),
    FOREIGN KEY (id_asignatura, id_grado) REFERENCES Asignatura(id_asignatura, id_grado),
    FOREIGN KEY (DNI) REFERENCES Usuario(DNI)
);

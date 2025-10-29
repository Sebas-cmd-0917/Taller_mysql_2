CREATE DATABASE IF NOT EXISTS evento_deportivo;
USE evento_deportivo;

CREATE TABLE sede (
    id_sede INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255),
    ciudad VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(100),
    estado ENUM('activo','inactivo') DEFAULT 'activo'
);

CREATE TABLE cancha (
    id_cancha INT AUTO_INCREMENT PRIMARY KEY,
    id_sede INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50),
    capacidad INT,
    estado ENUM('activa','inactiva') DEFAULT 'activa',
    FOREIGN KEY (id_sede) REFERENCES sede(id_sede)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

CREATE TABLE jugador (
    id_jugador INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    nuip VARCHAR(20) UNIQUE,
    email VARCHAR(100),
    telefono VARCHAR(20),
    id_categoria INT DEFAULT NULL,
    fecha_entrada DATE,
    activo TINYINT(1) DEFAULT 1,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE programa_entrenamiento (
    id_programa INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    id_categoria INT NOT NULL,
    objetivo TEXT,
    fecha_inicio DATE,
    fecha_fin DATE,
    estado ENUM('activo','inactivo') DEFAULT 'activo',
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE sesion (
    id_sesion INT AUTO_INCREMENT PRIMARY KEY,
    id_programa INT NOT NULL,
    fecha DATE NOT NULL,
    hora_inicio TIME,
    hora_fin TIME,
    id_cancha INT DEFAULT NULL,
    objetivo_sesion VARCHAR(255),
    FOREIGN KEY (id_programa) REFERENCES programa_entrenamiento(id_programa)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_cancha) REFERENCES cancha(id_cancha)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE asistencia_sesion (
    id_asistencia INT AUTO_INCREMENT PRIMARY KEY,
    id_sesion INT NOT NULL,
    id_jugador INT NOT NULL,
    presente TINYINT(1) DEFAULT 0,
    minutos_presentes INT,
    observaciones TEXT,
    UNIQUE(id_sesion, id_jugador),
    FOREIGN KEY (id_sesion) REFERENCES sesion(id_sesion)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_jugador) REFERENCES jugador(id_jugador)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE metrica_jugador (
    id_metrica INT AUTO_INCREMENT PRIMARY KEY,
    id_jugador INT NOT NULL,
    id_sesion INT DEFAULT NULL,
    fecha_registro DATE NOT NULL,
    peso DECIMAL(10,2),
    velocidad DECIMAL(10,2),
    resistencia DECIMAL(10,2),
    nota TEXT,
    FOREIGN KEY (id_jugador) REFERENCES jugador(id_jugador)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_sesion) REFERENCES sesion(id_sesion)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE jugador_programa (
    id_jugador_programa INT AUTO_INCREMENT PRIMARY KEY,
    id_jugador INT NOT NULL,
    id_programa INT NOT NULL,
    fecha_inscripcion DATE,
    estado ENUM('activo','finalizado','cancelado') DEFAULT 'activo',
    UNIQUE(id_jugador, id_programa),
    FOREIGN KEY (id_jugador) REFERENCES jugador(id_jugador)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_programa) REFERENCES programa_entrenamiento(id_programa)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE equipo (
    id_equipo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    club VARCHAR(150),
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE jugador_equipo (
    id_jugador_equipo INT AUTO_INCREMENT PRIMARY KEY,
    id_jugador INT NOT NULL,
    id_equipo INT NOT NULL,
    fecha_ingreso DATE,
    estado ENUM('activo','retirado','transferido') DEFAULT 'activo',
    UNIQUE(id_jugador, id_equipo),
    FOREIGN KEY (id_jugador) REFERENCES jugador(id_jugador)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE persona (
    id_persona INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    rol VARCHAR(50),
    nuip VARCHAR(20) UNIQUE,
    telefono VARCHAR(20),
    email VARCHAR(100),
    activo TINYINT(1) DEFAULT 1
);

CREATE TABLE evento (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    tipo_evento VARCHAR(50),
    nombre VARCHAR(150),
    fecha_inicio DATETIME,
    fecha_fin DATETIME,
    id_sede INT DEFAULT NULL,
    estado ENUM('programado','en_progreso','finalizado','cancelado') DEFAULT 'programado',
    descripcion TEXT,
    FOREIGN KEY (id_sede) REFERENCES sede(id_sede)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE evento_equipo (
    id_evento_equipo INT AUTO_INCREMENT PRIMARY KEY,
    id_evento INT NOT NULL,
    id_equipo INT NOT NULL,
    local TINYINT(1) NOT NULL DEFAULT 0,
    UNIQUE(id_evento, id_equipo),
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE evento_personal (
    id_evento_personal INT AUTO_INCREMENT PRIMARY KEY,
    id_evento INT NOT NULL,
    id_persona INT NOT NULL,
    rol_evento VARCHAR(50),
    UNIQUE(id_evento, id_persona, rol_evento),
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_persona) REFERENCES persona(id_persona)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE patrocinador (
    id_patrocinador INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(100),
    tipo VARCHAR(50),
    email VARCHAR(100),
    telefono VARCHAR(20)
);

CREATE TABLE evento_patrocinador (
    id_evento_patrocinador INT AUTO_INCREMENT PRIMARY KEY,
    id_evento INT NOT NULL,
    id_patrocinador INT NOT NULL,
    monto DECIMAL(10,2),
    detalle TEXT,
    UNIQUE(id_evento, id_patrocinador),
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_patrocinador) REFERENCES patrocinador(id_patrocinador)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE recurso (
    id_recurso INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo VARCHAR(50),
    descripcion TEXT,
    cantidad INT,
    ubicacion VARCHAR(150)
);

CREATE TABLE evento_recurso (
    id_evento_recurso INT AUTO_INCREMENT PRIMARY KEY,
    id_evento INT NOT NULL,
    id_recurso INT NOT NULL,
    cantidad_asignada INT,
    UNIQUE(id_evento, id_recurso),
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_recurso) REFERENCES recurso(id_recurso)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE incidencia (
    id_incidencia INT AUTO_INCREMENT PRIMARY KEY,
    id_evento INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    descripcion TEXT,
    accion_tomada TEXT,
    reportado_por INT DEFAULT NULL,
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (reportado_por) REFERENCES persona(id_persona)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

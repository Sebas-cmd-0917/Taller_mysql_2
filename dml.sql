
-- SEDE
INSERT INTO sede (nombre, direccion, ciudad, telefono, email, estado)
VALUES
('Complejo Deportivo Central', 'Av. Los Álamos 450', 'Bogotá', '3105551234', 'central@clubfutbol.com', 'activo'),
('Polideportivo Norte', 'Calle 85 #12-45', 'Bogotá', '3205555678', 'norte@clubfutbol.com', 'activo');

-- CANCHA
INSERT INTO cancha (id_sede, nombre, tipo, capacidad, estado)
VALUES
(1, 'Cancha A', 'césped natural', 200, 'activa'),
(1, 'Cancha B', 'sintética', 150, 'activa'),
(2, 'Campo Norte', 'césped sintético', 250, 'activa');

-- CATEGORIA
INSERT INTO categoria (nombre, descripcion)
VALUES
('Sub-15', 'Jugadores menores de 15 años'),
('Sub-18', 'Jugadores entre 15 y 18 años'),
('Mayores', 'Jugadores adultos');

-- JUGADOR
INSERT INTO jugador (nombre, apellido, fecha_nacimiento, nuip, email, telefono, id_categoria, fecha_entrada, activo)
VALUES
('Carlos', 'Pérez', '2009-04-15', '12345678', 'carlos.perez@mail.com', '3101234567', 1, '2024-01-10', 1),
('Andrés', 'López', '2007-09-30', '87654321', 'andres.lopez@mail.com', '3119876543', 2, '2023-06-05', 1),
('Juan', 'García', '1998-02-12', '11223344', 'juan.garcia@mail.com', '3125558899', 3, '2022-03-20', 0);

-- PROGRAMA_ENTRENAMIENTO
INSERT INTO programa_entrenamiento (nombre, descripcion, id_categoria, objetivo, fecha_inicio, fecha_fin, estado)
VALUES
('Preparación Física Sub-15', 'Entrenamiento físico general para jóvenes', 1, 'Mejorar resistencia y fuerza', '2024-01-15', '2024-03-30', 'activo'),
('Tácticas Avanzadas Sub-18', 'Trabajo de estrategias de equipo', 2, 'Fortalecer coordinación táctica', '2024-02-10', '2024-04-20', 'activo');

-- SESION
INSERT INTO sesion (id_programa, fecha, hora_inicio, hora_fin, id_cancha, objetivo_sesion)
VALUES
(1, '2024-01-20', '08:00', '10:00', 1, 'Entrenamiento de resistencia'),
(1, '2024-01-25', '08:00', '10:00', 1, 'Fuerza y velocidad'),
(2, '2024-02-15', '09:00', '11:00', 3, 'Tácticas de presión alta');

-- JUGADOR_PROGRAMA
INSERT INTO jugador_programa (id_jugador, id_programa, fecha_inscripcion, estado)
VALUES
(1, 1, '2024-01-12', 'activo'),
(2, 2, '2024-02-01', 'activo');

-- ASISTENCIA_SESION
INSERT INTO asistencia_sesion (id_sesion, id_jugador, presente, minutos_presentes, observaciones)
VALUES
(1, 1, 1, 120, 'Excelente rendimiento'),
(2, 1, 1, 115, 'Buena actitud'),
(3, 2, 0, 0, 'Ausente por lesión');

-- METRICA_JUGADOR
INSERT INTO metrica_jugador (id_jugador, id_sesion, fecha_registro, peso, velocidad, resistencia, nota)
VALUES
(1, 1, '2024-01-20', 55.2, 8.5, 7.9, 'Buena resistencia'),
(1, 2, '2024-01-25', 55.4, 8.7, 8.1, 'Mejoró velocidad'),
(2, 3, '2024-02-15', 60.1, 8.2, 7.5, 'Promedio general');

-- EVENTO
INSERT INTO evento (tipo_evento, nombre, fecha_inicio, fecha_fin, id_sede, estado, descripcion)
VALUES
('amistoso', 'Partido Amistoso Sub-18', '2024-03-01 15:00:00', '2024-03-01 17:00:00', 2, 'programado', 'Partido de preparación contra equipo invitado'),
('torneo', 'Torneo Regional Mayores', '2024-05-10 09:00:00', '2024-05-20 18:00:00', 1, 'programado', 'Competencia regional entre clubes locales');

-- EQUIPO
INSERT INTO equipo (nombre, club, id_categoria)
VALUES
('Club Futbol A', 'Interno', 2),
('Deportivo Norte', 'Externo', 2),
('Veteranos FC', 'Externo', 3);

-- EVENTO_EQUIPO
INSERT INTO evento_equipo (id_evento, id_equipo, local)
VALUES
(1, 1, 1),
(1, 2, 0),
(2, 3, 0);

-- PERSONA
INSERT INTO persona (nombre, apellido, rol, nuip, telefono, email, activo)
VALUES
('Luis', 'Martínez', 'árbitro', '99001122', '3109988776', 'luis.martinez@mail.com', 1),
('Marta', 'Rojas', 'entrenador', '88001133', '3106677889', 'marta.rojas@mail.com', 1),
('Pedro', 'Cano', 'voluntario', '77002244', '3114455667', 'pedro.cano@mail.com', 1);

-- EVENTO_PERSONAL
INSERT INTO evento_personal (id_evento, id_persona, rol_evento)
VALUES
(1, 1, 'árbitro principal'),
(1, 2, 'entrenador local'),
(2, 3, 'asistente logístico');

-- PATROCINADOR
INSERT INTO patrocinador (nombre, contacto, tipo, email, telefono)
VALUES
('Deportes Rueda', 'Carlos Rueda', 'empresa', 'contacto@deportesrueda.com', '3207778899'),
('Gaseosas Andina', 'María Torres', 'empresa', 'maria@andina.com', '3205551122');

-- EVENTO_PATROCINADOR
INSERT INTO evento_patrocinador (id_evento, id_patrocinador, monto, detalle)
VALUES
(1, 1, 1000000.00, 'Apoyo logístico y uniformes'),
(2, 2, 2500000.00, 'Patrocinio oficial del torneo');

-- RECURSO
INSERT INTO recurso (nombre, tipo, descripcion, cantidad, ubicacion)
VALUES
('Balones', 'equipamiento', 'Balones oficiales FIFA', 20, 'Depósito Central'),
('Conos de entrenamiento', 'equipamiento', 'Conos plásticos de señalización', 50, 'Sede Central');

-- EVENTO_RECURSO
INSERT INTO evento_recurso (id_evento, id_recurso, cantidad_asignada)
VALUES
(1, 1, 5),
(1, 2, 10);

-- INCIDENCIA
INSERT INTO incidencia (id_evento, fecha_hora, descripcion, accion_tomada, reportado_por)
VALUES
(1, '2024-03-01 16:10:00', 'Lesión leve en jugador visitante', 'Atención médica inmediata', 1),
(2, '2024-05-12 10:45:00', 'Retraso por lluvia', 'Reprogramar horario', 3);





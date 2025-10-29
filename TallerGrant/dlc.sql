-- CREACIÓN DE USUARIOS
CREATE USER IF NOT EXISTS 'admin'@'%' IDENTIFIED BY 'contr4s3n4';
CREATE USER IF NOT EXISTS 'cajero'@'%' IDENTIFIED BY 'contr4s3n4';
CREATE USER IF NOT EXISTS 'analista'@'%' IDENTIFIED BY 'contr4s3n4';
CREATE USER IF NOT EXISTS 'desarrollador'@'%' IDENTIFIED BY 'contr4s3n4';

-- PERMISOS POR ROL

-- ADMIN: acceso total
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION;

-- CAJERO: acceso limitado a asistencias, sesiones y jugadores
GRANT SELECT, INSERT, UPDATE ON evento_deportivo.asistencia_sesion TO 'cajero'@'%';
GRANT SELECT ON evento_deportivo.sesion TO 'cajero'@'%';
GRANT SELECT ON evento_deportivo.jugador TO 'cajero'@'%';

-- ANALISTA: acceso de solo lectura
GRANT SELECT, SHOW VIEW, SHOW TABLES ON evento_deportivo.* TO 'analista'@'%';

-- DESARROLLADOR: acceso a tareas estructurales
GRANT CREATE TEMPORARY TABLES, LOCK TABLES, ALTER, DROP, INDEX ON evento_deportivo.* TO 'desarrollador'@'%';

-- 🔒 LÍMITES DE CONSULTAS POR HORA
ALTER USER 'admin'@'%' WITH MAX_QUERIES_PER_HOUR 50;
ALTER USER 'cajero'@'%' WITH MAX_QUERIES_PER_HOUR 50;
ALTER USER 'analista'@'%' WITH MAX_QUERIES_PER_HOUR 50;
ALTER USER 'desarrollador'@'%' WITH MAX_QUERIES_PER_HOUR 0;

-- PROCEDIMIENTO: Ver asistencias de un jugador
USE evento_deportivo;

DELIMITER //
CREATE PROCEDURE VerMisAsistencias(IN p_id_jugador INT)
BEGIN
  SELECT s.fecha, s.hora_inicio, a.presente, a.minutos_presentes, a.observaciones
  FROM asistencia_sesion a
  JOIN sesion s ON a.id_sesion = s.id_sesion
  WHERE a.id_jugador = p_id_jugador;
END //
DELIMITER ;

GRANT EXECUTE ON PROCEDURE evento_deportivo.VerMisAsistencias TO 'cajero'@'%', 'analista'@'%';

-- FUNCIÓN: Calcular total de minutos de asistencia en un mes
DELIMITER //
CREATE FUNCTION CalcularAsistenciaMensual(p_mes INT, p_anio INT)
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total_min INT;
  SELECT SUM(minutos_presentes) INTO total_min
  FROM asistencia_sesion a
  JOIN sesion s ON a.id_sesion = s.id_sesion
  WHERE MONTH(s.fecha) = p_mes AND YEAR(s.fecha) = p_anio AND a.presente = 1;
  RETURN IFNULL(total_min, 0);
END //
DELIMITER ;

GRANT EXECUTE ON FUNCTION evento_deportivo.CalcularAsistenciaMensual TO 'cajero'@'%', 'analista'@'%';

--  REFRESCAR PRIVILEGIOS
FLUSH PRIVILEGES;

# 🏟️ Sistema de Gestión de Eventos Deportivos

Este proyecto implementa un sistema relacional para la gestión de eventos deportivos, jugadores, entrenamientos, equipos, recursos, personal y patrocinadores. Está diseñado en MySQL y sigue principios de modelado normalizado con integridad referencial.

---

## 📚 Estructura de la Base de Datos

La base de datos se llama `evento_deportivo` y contiene las siguientes tablas:

### 🏢 Entidades principales

- `sede`: Ubicaciones donde se realizan los eventos.
- `cancha`: Espacios físicos para entrenamientos y partidos.
- `categoria`: Clasificación por edad o nivel de los jugadores.
- `jugador`: Participantes registrados.
- `programa_entrenamiento`: Planes de entrenamiento por categoría.
- `sesion`: Sesiones específicas dentro de los programas.
- `evento`: Competencias o partidos especiales.
- `equipo`: Clubes o agrupaciones deportivas.
- `persona`: Personal como árbitros, entrenadores y voluntarios.
- `patrocinador`: Entidades que aportan recursos.
- `recurso`: Equipos y materiales asignables a eventos.

### 📌 Tablas de relación

- `jugador_programa`: Asigna jugadores a programas de entrenamiento.
- `asistencia_sesion`: Registro de asistencia por sesión.
- `metrica_jugador`: Seguimiento de rendimiento físico.
- `jugador_equipo`: Relación entre jugadores y equipos.
- `evento_equipo`: Participación de equipos en eventos.
- `evento_personal`: Personal asignado a eventos.
- `evento_patrocinador`: Patrocinadores asignados a eventos.
- `evento_recurso`: Recursos utilizados en cada evento.
- `incidencia`: Reportes de incidentes ocurridos durante eventos.

---

## 🛠️ Requisitos

- MySQL 8.0+
- Cliente de MySQL (Workbench, DBeaver, CLI, etc.)

---

## 🚀 Instalación

1. Clona o descarga este repositorio.
2. Abre tu cliente de base de datos favorito.
3. Ejecuta el script de creación de tablas (`schema.sql`).
4. Ejecuta el script de inserción de datos (`data.sql`).

---

## 📁 Archivos incluidos

- `schema.sql`: Script para crear todas las tablas.
- `data.sql`: Script con datos de ejemplo para poblar la base.
- `README.md`: Este archivo con la documentación general.

---

## 📊 Ejemplos de uso

```sql
-- Obtener todos los jugadores activos de la categoría Sub-15
SELECT j.nombre, j.apellido
FROM jugador j
JOIN categoria c ON j.id_categoria = c.id_categoria
WHERE c.nombre = 'Sub-15' AND j.activo = 1;

-- Ver sesiones de un programa específico
SELECT s.fecha, s.hora_inicio, s.objetivo_sesion
FROM sesion s
JOIN programa_entrenamiento p ON s.id_programa = p.id_programa
WHERE p.nombre = 'Preparación Física Sub-15';

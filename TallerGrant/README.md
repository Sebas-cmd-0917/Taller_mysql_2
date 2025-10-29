# 🔐 Gestión de Usuarios y Permisos - Base de Datos `evento_deportivo`

Este documento describe la configuración de usuarios, roles, límites de uso, procedimientos y funciones en la base de datos `evento_deportivo`, diseñada para administrar entrenamientos, eventos deportivos y jugadores.

---

## 👥 Usuarios y Roles

### 1. `admin`
- **Permisos:** Total (ALL PRIVILEGES)
- **Uso:** Administración completa, gestión de usuarios, bases de datos y objetos.
- **Límites:** `MAX_QUERIES_PER_HOUR = 50`

### 2. `cajero`
- **Permisos:**
  - `SELECT, INSERT, UPDATE` sobre `asistencia_sesion`
  - `SELECT` sobre `jugador` y `sesion`
  - `EXECUTE` sobre procedimientos y funciones permitidas
- **Uso:** Registro y seguimiento de asistencias
- **Límites:** `MAX_QUERIES_PER_HOUR = 50`

### 3. `analista`
- **Permisos:**
  - `SELECT`, `SHOW TABLES`, `SHOW VIEW` sobre todas las tablas
  - `EXECUTE` sobre funciones y procedimientos definidos
- **Uso:** Consultas de análisis e informes
- **Límites:** `MAX_QUERIES_PER_HOUR = 50`

### 4. `desarrollador`
- **Permisos:**
  - `ALTER`, `DROP`, `INDEX`, `CREATE TEMPORARY TABLES`, `LOCK TABLES`
- **Uso:** Modificaciones estructurales y desarrollo
- **Límites:** Sin restricciones (`MAX_QUERIES_PER_HOUR = 0`)

---

## 🧩 Procedimientos y Funciones

### 🔍 Procedimiento: `VerMisAsistencias`

```sql
CALL VerMisAsistencias(p_id_jugador);

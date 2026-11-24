-- =====================================================================
--  Base de datos del CRUD de Usuarios (ASP.NET Web Forms + MySQL)
--  Ejecutar completo en MySQL Workbench / phpMyAdmin (pestaña SQL).
--  Es seguro ejecutarlo varias veces: no borra los datos existentes.
-- =====================================================================

CREATE DATABASE IF NOT EXISTS crudasp
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE crudasp;

-- ---------------------------------------------------------------------
-- 1. Tabla usuarios (con campos de auditoría y borrado lógico)
--    Anulado = 1  -> registro activo
--    Anulado = 0  -> registro eliminado (se guarda FechaEliminacion)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS usuarios (
    idUsuario         INT          NOT NULL AUTO_INCREMENT,
    Nombre            VARCHAR(150) NOT NULL,
    Edad              INT          NOT NULL,
    correo            VARCHAR(150) NOT NULL,
    FechaNacimiento   DATE         NOT NULL,
    FechaModificacion DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FechaDeInsercion  DATETIME     DEFAULT CURRENT_TIMESTAMP,
    Anulado           TINYINT(1)   NOT NULL DEFAULT 1,
    FechaEliminacion  DATETIME     NULL,
    PRIMARY KEY (idUsuario),
    UNIQUE KEY index_Correo (correo)
) ENGINE = InnoDB;

-- ---------------------------------------------------------------------
-- 2. Procedimientos almacenados
-- ---------------------------------------------------------------------
DELIMITER //

-- Listar todos los usuarios activos
DROP PROCEDURE IF EXISTS sp_load//
CREATE PROCEDURE sp_load()
BEGIN
    SELECT idUsuario AS IdUsuario, Nombre, Edad, correo AS Correo,
           FechaNacimiento, FechaDeInsercion, FechaModificacion
    FROM usuarios
    WHERE Anulado = 1
    ORDER BY idUsuario;
END//

-- Buscar usuarios activos por nombre o correo
DROP PROCEDURE IF EXISTS sp_search//
CREATE PROCEDURE sp_search(IN _texto VARCHAR(150))
BEGIN
    SELECT idUsuario AS IdUsuario, Nombre, Edad, correo AS Correo,
           FechaNacimiento, FechaDeInsercion, FechaModificacion
    FROM usuarios
    WHERE Anulado = 1
      AND (Nombre LIKE CONCAT('%', _texto, '%')
           OR correo LIKE CONCAT('%', _texto, '%'))
    ORDER BY idUsuario;
END//

-- Leer un usuario por id (Read / Update / Delete lo usan)
DROP PROCEDURE IF EXISTS sp_read//
CREATE PROCEDURE sp_read(IN _idUsuario INT)
BEGIN
    SELECT idUsuario AS IdUsuario, Nombre, Edad, correo AS Correo,
           FechaNacimiento, FechaDeInsercion, FechaModificacion
    FROM usuarios
    WHERE idUsuario = _idUsuario AND Anulado = 1;
END//

-- Crear usuario
DROP PROCEDURE IF EXISTS insert_user//
CREATE PROCEDURE insert_user(
    IN _nombre VARCHAR(150),
    IN _edad INT,
    IN _correo VARCHAR(150),
    IN _fechanacimiento DATE)
BEGIN
    INSERT INTO usuarios (Nombre, Edad, correo, FechaNacimiento)
    VALUES (_nombre, _edad, _correo, _fechanacimiento);
END//

-- Modificar usuario (FechaModificacion se actualiza sola)
DROP PROCEDURE IF EXISTS sp_update//
CREATE PROCEDURE sp_update(
    IN _id INT,
    IN _nombre VARCHAR(150),
    IN _edad INT,
    IN _correo VARCHAR(150),
    IN _fechanacimiento DATE)
BEGIN
    UPDATE usuarios
    SET Nombre = _nombre,
        Edad = _edad,
        correo = _correo,
        FechaNacimiento = _fechanacimiento
    WHERE idUsuario = _id AND Anulado = 1;
END//

-- Eliminar (borrado lógico): marca como anulado y guarda la fecha exacta
DROP PROCEDURE IF EXISTS sp_delete//
CREATE PROCEDURE sp_delete(IN _idUsuario INT)
BEGIN
    UPDATE usuarios
    SET Anulado = 0,
        FechaEliminacion = NOW()
    WHERE idUsuario = _idUsuario;
END//

DELIMITER ;

-- ---------------------------------------------------------------------
-- 3. Registros de prueba (las fechas son de tipo DATE)
-- ---------------------------------------------------------------------
INSERT IGNORE INTO usuarios (Nombre, Edad, correo, FechaNacimiento) VALUES
    ('Fulano Demetrio', 35, 'fulano@example.com',    '1990-02-04'),
    ('Perencebo',       36, 'perencebo@example.com', '1990-02-07'),
    ('Claudia',         26, 'claudia@example.com',   '2000-02-04');

-- Verificación
-- CALL sp_load();
-- SELECT * FROM usuarios;

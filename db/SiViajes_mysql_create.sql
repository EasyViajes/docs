CREATE DATABASE IF NOT EXISTS siviajes;
USE siviajes;

CREATE TABLE `Usuario` (
	`id` int NOT NULL AUTO_INCREMENT,
	`mail` varchar(100) NOT NULL UNIQUE,
	`password` varchar(255) NOT NULL,
	`nombre` varchar(55) NOT NULL,
	`fecha_creacion` DATETIME NOT NULL,
	`fk_estado` int NOT NULL,
	`fk_empresa` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Empresa` (
	`id` int NOT NULL AUTO_INCREMENT UNIQUE,
	`rut` varchar(15) NOT NULL UNIQUE,
	`nombre` varchar(30) NOT NULL,
	`direccion` varchar(50) NOT NULL,
	`fecha_creacion` DATETIME NOT NULL,
	`fk_plan` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Conductor` (
	`id` int NOT NULL AUTO_INCREMENT UNIQUE,
	`rut` varchar(15) NOT NULL UNIQUE,
	`nombre` varchar(55) NOT NULL,
	`direccion` varchar(100) NOT NULL,
	`fecha_ingreso` DATETIME NOT NULL,
	`fecha_salida` DATETIME NOT NULL,
	`fin_contrato` DATETIME NOT NULL,
	`fk_estado` int NOT NULL,
	`fk_empresa` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Vehiculo` (
	`id` int NOT NULL AUTO_INCREMENT UNIQUE,
	`patente` varchar(10) NOT NULL UNIQUE,
	`marca` varchar(30) NOT NULL,
	`asientos` int(2) NOT NULL,
	`num_serie` varchar(17) NOT NULL UNIQUE,
	`mensualidad` int NOT NULL,
	`fk_estado` int NOT NULL,
	`fk_empresa` int NOT NULL,
	`fk_conductor` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Ticket` (
	`id` int NOT NULL AUTO_INCREMENT UNIQUE,
	`motivo` varchar(50) NOT NULL,
	`creacion` DATETIME NOT NULL,
	`prioridad` int(1) NOT NULL,
	`fecha_creacion` DATETIME NOT NULL,
	`fk_estado` int NOT NULL,
	`fk_vehiculo` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Ruta` (
	`id` int NOT NULL AUTO_INCREMENT UNIQUE,
	`hr_salida` DATETIME NOT NULL,
	`origen` varchar(50) NOT NULL,
	`destino` varchar(50) NOT NULL,
	`fecha_creacion` DATETIME NOT NULL,
	`fk_estado` int NOT NULL,
	`fk_empresa` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Pasaje` (
	`id` int NOT NULL AUTO_INCREMENT UNIQUE,
	`precio` int NOT NULL,
	`fecha_compra` DATETIME NOT NULL,
	`fk_estado` int NOT NULL,
	`fk_ruta` int NOT NULL,
	`fk_cliente` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Cliente` (
	`id` int NOT NULL AUTO_INCREMENT UNIQUE,
	`mail` varchar(100) NOT NULL UNIQUE,
	`secreto` varchar(13) NOT NULL UNIQUE,
	`fecha_creacion` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Plan` (
	`id` int NOT NULL AUTO_INCREMENT,
	`nombre` varchar(15) NOT NULL UNIQUE,
	`descripcion` varchar(80) NOT NULL,
	`precio` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Permiso` (
	`id` int NOT NULL AUTO_INCREMENT,
	`nombre` varchar(15) NOT NULL UNIQUE,
	PRIMARY KEY (`id`)
);

CREATE TABLE `PermisoUsuario` (
	`id` int NOT NULL AUTO_INCREMENT,
	`id_usuario` int NOT NULL,
	`id_permiso` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Estado` (
	`id` int NOT NULL AUTO_INCREMENT,
	`nombre` varchar(10) NOT NULL,
	PRIMARY KEY (`id`)
);

ALTER TABLE `Usuario` ADD CONSTRAINT `Usuario_fk0` FOREIGN KEY (`fk_estado`) REFERENCES `Estado`(`id`);

ALTER TABLE `Usuario` ADD CONSTRAINT `Usuario_fk1` FOREIGN KEY (`fk_empresa`) REFERENCES `Empresa`(`id`);

ALTER TABLE `Empresa` ADD CONSTRAINT `Empresa_fk0` FOREIGN KEY (`fk_plan`) REFERENCES `Plan`(`id`);

ALTER TABLE `Conductor` ADD CONSTRAINT `Conductor_fk0` FOREIGN KEY (`fk_estado`) REFERENCES `Estado`(`id`);

ALTER TABLE `Conductor` ADD CONSTRAINT `Conductor_fk1` FOREIGN KEY (`fk_empresa`) REFERENCES `Empresa`(`id`);

ALTER TABLE `Vehiculo` ADD CONSTRAINT `Vehiculo_fk0` FOREIGN KEY (`fk_estado`) REFERENCES `Estado`(`id`);

ALTER TABLE `Vehiculo` ADD CONSTRAINT `Vehiculo_fk1` FOREIGN KEY (`fk_empresa`) REFERENCES `Empresa`(`id`);

ALTER TABLE `Vehiculo` ADD CONSTRAINT `Vehiculo_fk2` FOREIGN KEY (`fk_conductor`) REFERENCES `Conductor`(`id`);

ALTER TABLE `Ticket` ADD CONSTRAINT `Ticket_fk0` FOREIGN KEY (`fk_estado`) REFERENCES `Estado`(`id`);

ALTER TABLE `Ticket` ADD CONSTRAINT `Ticket_fk1` FOREIGN KEY (`fk_vehiculo`) REFERENCES `Vehiculo`(`id`);

ALTER TABLE `Ruta` ADD CONSTRAINT `Ruta_fk0` FOREIGN KEY (`fk_estado`) REFERENCES `Estado`(`id`);

ALTER TABLE `Ruta` ADD CONSTRAINT `Ruta_fk1` FOREIGN KEY (`fk_empresa`) REFERENCES `Empresa`(`id`);

ALTER TABLE `Pasaje` ADD CONSTRAINT `Pasaje_fk0` FOREIGN KEY (`fk_estado`) REFERENCES `Estado`(`id`);

ALTER TABLE `Pasaje` ADD CONSTRAINT `Pasaje_fk1` FOREIGN KEY (`fk_ruta`) REFERENCES `Ruta`(`id`);

ALTER TABLE `Pasaje` ADD CONSTRAINT `Pasaje_fk2` FOREIGN KEY (`fk_cliente`) REFERENCES `Cliente`(`id`);

ALTER TABLE `PermisoUsuario` ADD CONSTRAINT `PermisoUsuario_fk0` FOREIGN KEY (`id_usuario`) REFERENCES `Usuario`(`id`);

ALTER TABLE `PermisoUsuario` ADD CONSTRAINT `PermisoUsuario_fk1` FOREIGN KEY (`id_permiso`) REFERENCES `Permiso`(`id`);

-- Default Values
-- Estado
INSERT INTO Estado (nombre) VALUES ('Activo');
INSERT INTO Estado (nombre) VALUES ('Inactivo');
INSERT INTO Estado (nombre) VALUES ('Pendiente');
INSERT INTO Estado (nombre) VALUES ('Atrasado');
INSERT INTO Estado (nombre) VALUES ('Otro');

-- Plan
INSERT INTO Plan (nombre, descripcion, precio) VALUES ('test', 'test', 11111);
INSERT INTO Plan (nombre, descripcion, precio) VALUES ('default', 'default', 0);
INSERT INTO Plan (nombre, descripcion, precio) VALUES ('basico', 'basico', 10000);

-- Empresa 
INSERT INTO Empresa (rut, nombre, direccion, fecha_creacion, fk_plan) VALUES ('22.222.222-2', 'empresa_test', 'Direcc. 111 test', '2022-11-08 00:01:00', 1);

-- Usuario
-- pwd = testing
INSERT INTO Usuario (mail, password, nombre, fecha_creacion, fk_estado, fk_empresa) VALUES ('test.test@test.com', '$2y$10$OcM.dECTEpfsXa6jbN37j.8XzXfphIzHdQ/yEVWdmK8mq7wHTfsbG', 'test', '2022-11-08 00:01:00', 1, 1);

-- Cliente
INSERT INTO Cliente (mail, secreto, fecha_creacion) VALUES ('test.test@test.com', '123456789abcd', '2022-11-08 00:00:00');
INSERT INTO Cliente (mail, secreto, fecha_creacion) VALUES ('test2.test2@test2.com', 'abcd123456789', '2022-11-09 16:36:42');

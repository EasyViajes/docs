CREATE DATABASE IF NOT EXISTS EasyViajes;
USE EasyViajes;

CREATE TABLE `Usuario` (
	`id` int NOT NULL AUTO_INCREMENT,
	`nombre` varchar(55) NOT NULL,
	`mail` varchar(100) NOT NULL UNIQUE,
	`password` varchar(255) NOT NULL,
	`fecha_creacion` DATETIME NOT NULL,
	`fk_estado` int NOT NULL,
	`fk_empresa` int NOT NULL,
	`fk_permiso` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Empresa` (
	`id` int NOT NULL AUTO_INCREMENT UNIQUE,
	`rut` varchar(15) NOT NULL UNIQUE,
	`nombre` varchar(30) NOT NULL UNIQUE,
	`fecha_creacion` DATETIME NOT NULL,
	`fk_direccion` int NOT NULL,
	`fk_estado` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Conductor` (
	`id` int NOT NULL AUTO_INCREMENT UNIQUE,
	`rut` varchar(15) NOT NULL UNIQUE,
	`nombre` varchar(55) NOT NULL,
	`fecha_ingreso` DATE NOT NULL,
	`fin_contrato` DATE NOT NULL,
	`fk_estado` int NOT NULL,
	`fk_empresa` int NOT NULL,
	`fk_direccion` int NOT NULL,
	`fk_vehiculo` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Vehiculo` (
	`id` int NOT NULL AUTO_INCREMENT UNIQUE,
	`patente` varchar(10) NOT NULL UNIQUE,
	`marca` varchar(30) NOT NULL,
	`asientos` int(2) NOT NULL,
	`mensualidad` int NOT NULL,
	`fk_estado` int NOT NULL,
	`fk_empresa` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Ruta` (
	`id` int NOT NULL AUTO_INCREMENT UNIQUE,
	`hora_salida` TIME NOT NULL,
	`fecha_creacion` DATE NOT NULL,
	`fk_direccion_origen` int NOT NULL,
	`fk_direccion_destino` int NOT NULL,
	`fk_estado` int NOT NULL,
	`fk_empresa` int NOT NULL,
	`fk_vehiculo` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Pasaje` (
	`id` int NOT NULL AUTO_INCREMENT UNIQUE,
	`precio` int NOT NULL,
	`fk_estado` int NOT NULL,
	`fk_ruta` int NOT NULL,
	`fk_empresa` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Cliente` (
	`id` int NOT NULL AUTO_INCREMENT UNIQUE,
	`mail` varchar(100) NOT NULL UNIQUE,
	`secreto` varchar(13) NOT NULL UNIQUE,
	`fecha_creacion` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Permiso` (
	`id` int NOT NULL AUTO_INCREMENT,
	`nombre` varchar(30) NOT NULL UNIQUE,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Estado` (
	`id` int NOT NULL AUTO_INCREMENT,
	`nombre` varchar(25) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Venta` (
	`id` int NOT NULL AUTO_INCREMENT,
	`fecha_compra` DATETIME NOT NULL,
	`fk_estado` int NOT NULL,
	`fk_pasaje` int NOT NULL,
	`fk_empresa` int NOT NULL,
	`fk_cliente` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Comuna` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`nombre` varchar(20),
	`fk_provincia` int(3),
	PRIMARY KEY (`id`)
);

CREATE TABLE `Provincia` (
	`id` int(3) NOT NULL AUTO_INCREMENT,
	`nombre` varchar(23),
	`fk_region` int(2),
	PRIMARY KEY (`id`)
);

CREATE TABLE `Region` (
	`id` int(2) NOT NULL AUTO_INCREMENT,
	`nombre` varchar(50),
	`ISO_3166_2_CL` varchar(5),
	PRIMARY KEY (`id`)
);

CREATE TABLE `Direccion` (
	`id` int NOT NULL AUTO_INCREMENT,
	`nombre` varchar(50) NOT NULL,
	`fk_comuna` int(11) NOT NULL,
	PRIMARY KEY (`id`)
);

ALTER TABLE `Usuario` ADD CONSTRAINT `Usuario_fk0` FOREIGN KEY (`fk_estado`) REFERENCES `Estado`(`id`);

ALTER TABLE `Usuario` ADD CONSTRAINT `Usuario_fk1` FOREIGN KEY (`fk_empresa`) REFERENCES `Empresa`(`id`);

ALTER TABLE `Usuario` ADD CONSTRAINT `Usuario_fk2` FOREIGN KEY (`fk_permiso`) REFERENCES `Permiso`(`id`);

ALTER TABLE `Empresa` ADD CONSTRAINT `Empresa_fk0` FOREIGN KEY (`fk_direccion`) REFERENCES `Direccion`(`id`);

ALTER TABLE `Empresa` ADD CONSTRAINT `Empresa_fk1` FOREIGN KEY (`fk_estado`) REFERENCES `Estado`(`id`);

ALTER TABLE `Conductor` ADD CONSTRAINT `Conductor_fk0` FOREIGN KEY (`fk_estado`) REFERENCES `Estado`(`id`);

ALTER TABLE `Conductor` ADD CONSTRAINT `Conductor_fk1` FOREIGN KEY (`fk_empresa`) REFERENCES `Empresa`(`id`);

ALTER TABLE `Conductor` ADD CONSTRAINT `Conductor_fk2` FOREIGN KEY (`fk_direccion`) REFERENCES `Direccion`(`id`);

ALTER TABLE `Conductor` ADD CONSTRAINT `Conductor_fk3` FOREIGN KEY (`fk_vehiculo`) REFERENCES `Vehiculo`(`id`);

ALTER TABLE `Vehiculo` ADD CONSTRAINT `Vehiculo_fk0` FOREIGN KEY (`fk_estado`) REFERENCES `Estado`(`id`);

ALTER TABLE `Vehiculo` ADD CONSTRAINT `Vehiculo_fk1` FOREIGN KEY (`fk_empresa`) REFERENCES `Empresa`(`id`);

ALTER TABLE `Ruta` ADD CONSTRAINT `Ruta_fk0` FOREIGN KEY (`fk_direccion_origen`) REFERENCES `Direccion`(`id`);

ALTER TABLE `Ruta` ADD CONSTRAINT `Ruta_fk1` FOREIGN KEY (`fk_direccion_destino`) REFERENCES `Direccion`(`id`);

ALTER TABLE `Ruta` ADD CONSTRAINT `Ruta_fk2` FOREIGN KEY (`fk_estado`) REFERENCES `Estado`(`id`);

ALTER TABLE `Ruta` ADD CONSTRAINT `Ruta_fk3` FOREIGN KEY (`fk_empresa`) REFERENCES `Empresa`(`id`);

ALTER TABLE `Ruta` ADD CONSTRAINT `Ruta_fk4` FOREIGN KEY (`fk_vehiculo`) REFERENCES `Vehiculo`(`id`);

ALTER TABLE `Pasaje` ADD CONSTRAINT `Pasaje_fk0` FOREIGN KEY (`fk_estado`) REFERENCES `Estado`(`id`);

ALTER TABLE `Pasaje` ADD CONSTRAINT `Pasaje_fk1` FOREIGN KEY (`fk_ruta`) REFERENCES `Ruta`(`id`);

ALTER TABLE `Pasaje` ADD CONSTRAINT `Pasaje_fk2` FOREIGN KEY (`fk_empresa`) REFERENCES `Empresa`(`id`);

ALTER TABLE `Venta` ADD CONSTRAINT `Venta_fk0` FOREIGN KEY (`fk_estado`) REFERENCES `Estado`(`id`);

ALTER TABLE `Venta` ADD CONSTRAINT `Venta_fk1` FOREIGN KEY (`fk_pasaje`) REFERENCES `Pasaje`(`id`);

ALTER TABLE `Venta` ADD CONSTRAINT `Venta_fk2` FOREIGN KEY (`fk_empresa`) REFERENCES `Empresa`(`id`);

ALTER TABLE `Venta` ADD CONSTRAINT `Venta_fk3` FOREIGN KEY (`fk_cliente`) REFERENCES `Cliente`(`id`);

ALTER TABLE `Comuna` ADD CONSTRAINT `Comuna_fk0` FOREIGN KEY (`fk_provincia`) REFERENCES `Provincia`(`id`);

ALTER TABLE `Provincia` ADD CONSTRAINT `Provincia_fk0` FOREIGN KEY (`fk_region`) REFERENCES `Region`(`id`);

ALTER TABLE `Direccion` ADD CONSTRAINT `Direccion_fk0` FOREIGN KEY (`fk_comuna`) REFERENCES `Comuna`(`id`);



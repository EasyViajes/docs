CREATE DATABASE IF NOT EXISTS EasyViajes;
USE EasyViajes;

CREATE TABLE `Usuario` (
	`id` int NOT NULL AUTO_INCREMENT,
	`nombre` varchar(55) NOT NULL,
	`mail` varchar(100) NOT NULL UNIQUE,
	`password` varchar(255) NOT NULL,
	`fecha_creacion` DATETIME NOT NULL,
	`fk_permiso` int NOT NULL,
	`fk_estado` int NOT NULL,
	`fk_empresa` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Empresa` (
	`id` int NOT NULL AUTO_INCREMENT UNIQUE,
	`rut` varchar(15) NOT NULL UNIQUE,
	`nombre` varchar(30) NOT NULL UNIQUE,
	`fecha_creacion` DATETIME NOT NULL,
	`direccion` varchar(255) NOT NULL,
	`fk_estado` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Conductor` (
	`id` int NOT NULL AUTO_INCREMENT UNIQUE,
	`rut` varchar(15) NOT NULL UNIQUE,
	`nombre` varchar(55) NOT NULL,
	`direccion` varchar(255) NOT NULL,
	`fecha_ingreso` DATE NOT NULL,
	`fin_contrato` DATE NOT NULL,
	`fk_estado` int NOT NULL,
	`fk_empresa` int NOT NULL,
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
	`precio` int NOT NULL,
	`fecha_creacion` DATE NOT NULL,
	`direccion_origen` varchar(255) NOT NULL,
	`direccion_destino` varchar(255) NOT NULL,
	`fk_estado` int NOT NULL,
	`fk_empresa` int NOT NULL,
	`fk_vehiculo` int NOT NULL,
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
	`fk_ruta` int NOT NULL,
	`fk_empresa` int NOT NULL,
	`fk_cliente` int NOT NULL,
	PRIMARY KEY (`id`)
);

ALTER TABLE `Usuario` ADD CONSTRAINT `Usuario_fk0` FOREIGN KEY (`fk_permiso`) REFERENCES `Permiso`(`id`);

ALTER TABLE `Usuario` ADD CONSTRAINT `Usuario_fk1` FOREIGN KEY (`fk_estado`) REFERENCES `Estado`(`id`);

ALTER TABLE `Usuario` ADD CONSTRAINT `Usuario_fk2` FOREIGN KEY (`fk_empresa`) REFERENCES `Empresa`(`id`);

ALTER TABLE `Empresa` ADD CONSTRAINT `Empresa_fk0` FOREIGN KEY (`fk_estado`) REFERENCES `Estado`(`id`);

ALTER TABLE `Conductor` ADD CONSTRAINT `Conductor_fk0` FOREIGN KEY (`fk_estado`) REFERENCES `Estado`(`id`);

ALTER TABLE `Conductor` ADD CONSTRAINT `Conductor_fk1` FOREIGN KEY (`fk_empresa`) REFERENCES `Empresa`(`id`);

ALTER TABLE `Conductor` ADD CONSTRAINT `Conductor_fk2` FOREIGN KEY (`fk_vehiculo`) REFERENCES `Vehiculo`(`id`);

ALTER TABLE `Vehiculo` ADD CONSTRAINT `Vehiculo_fk0` FOREIGN KEY (`fk_estado`) REFERENCES `Estado`(`id`);

ALTER TABLE `Vehiculo` ADD CONSTRAINT `Vehiculo_fk1` FOREIGN KEY (`fk_empresa`) REFERENCES `Empresa`(`id`);

ALTER TABLE `Ruta` ADD CONSTRAINT `Ruta_fk0` FOREIGN KEY (`fk_estado`) REFERENCES `Estado`(`id`);

ALTER TABLE `Ruta` ADD CONSTRAINT `Ruta_fk1` FOREIGN KEY (`fk_empresa`) REFERENCES `Empresa`(`id`);

ALTER TABLE `Ruta` ADD CONSTRAINT `Ruta_fk2` FOREIGN KEY (`fk_vehiculo`) REFERENCES `Vehiculo`(`id`);

ALTER TABLE `Venta` ADD CONSTRAINT `Venta_fk0` FOREIGN KEY (`fk_estado`) REFERENCES `Estado`(`id`);

ALTER TABLE `Venta` ADD CONSTRAINT `Venta_fk1` FOREIGN KEY (`fk_ruta`) REFERENCES `Ruta`(`id`);

ALTER TABLE `Venta` ADD CONSTRAINT `Venta_fk2` FOREIGN KEY (`fk_empresa`) REFERENCES `Empresa`(`id`);

ALTER TABLE `Venta` ADD CONSTRAINT `Venta_fk3` FOREIGN KEY (`fk_cliente`) REFERENCES `Cliente`(`id`);


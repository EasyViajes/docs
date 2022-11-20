-- CREATE DATABASE IF NOT EXISTS siviajes;
-- USE siviajes;

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
	`fecha_ingreso` DATE NOT NULL,
	`fecha_salida` DATE NOT NULL,
	`fin_contrato` DATE NOT NULL,
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
	`hora_salida` TIME NOT NULL,
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
  `nombre` varchar(20) DEFAULT NULL,
  `idProvincia` int(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `COMUNA_PROVINCIA_ID` (`idProvincia`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=347 ;

CREATE TABLE `Provincia` (
  `id` int(3) NOT NULL DEFAULT '0',
  `nombre` varchar(23) DEFAULT NULL,
  `idRegion` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PROVINCIA_REGION_ID` (`idRegion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Region` (
  `id` int(2) NOT NULL DEFAULT '0',
  `nombre` varchar(50) DEFAULT NULL,
  `ISO_3166_2_CL` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `Comuna`
  ADD CONSTRAINT `Comuna_fk1` FOREIGN KEY (`idProvincia`) REFERENCES `Provincia` (`id`) ON UPDATE CASCADE;

ALTER TABLE `Provincia`
  ADD CONSTRAINT `Provincia_fk1` FOREIGN KEY (`idRegion`) REFERENCES `Region` (`id`) ON UPDATE CASCADE;
COMMIT;


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

ALTER TABLE `Pasaje` ADD CONSTRAINT `Pasaje_fk2` FOREIGN KEY (`fk_empresa`) REFERENCES `Empresa`(`id`);

ALTER TABLE `PermisoUsuario` ADD CONSTRAINT `PermisoUsuario_fk0` FOREIGN KEY (`id_usuario`) REFERENCES `Usuario`(`id`);

ALTER TABLE `PermisoUsuario` ADD CONSTRAINT `PermisoUsuario_fk1` FOREIGN KEY (`id_permiso`) REFERENCES `Permiso`(`id`);

ALTER TABLE `Venta` ADD CONSTRAINT `Venta_fk0` FOREIGN KEY (`fk_estado`) REFERENCES `Estado`(`id`);

ALTER TABLE `Venta` ADD CONSTRAINT `Venta_fk1` FOREIGN KEY (`fk_pasaje`) REFERENCES `Pasaje`(`id`);

ALTER TABLE `Venta` ADD CONSTRAINT `Venta_fk2` FOREIGN KEY (`fk_empresa`) REFERENCES `Empresa`(`id`);

ALTER TABLE `Venta` ADD CONSTRAINT `Venta_fk3` FOREIGN KEY (`fk_cliente`) REFERENCES `Cliente`(`id`);

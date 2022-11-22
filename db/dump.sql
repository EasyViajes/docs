-- ESTADO
INSERT INTO Estado (nombre) VALUES
('Activo'),
('Inactivo'),
('Pendiente'),
('Pwd_pend'),
('Exitoso'),
('Atrasado'),
('Otro');

INSERT INTO Permiso (nombre) VALUES
('Administrador_EasyViajes'),
('Administrador_empresa'),
('Conductor'),
('Otro');

--- EMPRESA 
INSERT INTO Empresa (id, rut, nombre, direccion, fecha_creacion, fk_estado) VALUES
(1, '3.333.333-3', 'EasyViajes', 'Direccion EasyViajes', '2022-11-08 00:00:00', 1);

-- USUARIO
-- pwd = testing
-- pwd = administrator
INSERT INTO Usuario (id, mail, password, nombre, fecha_creacion, fk_estado, fk_empresa, fk_permiso) VALUES
(1, 'adm@adm.com', '$2y$10$urw9CmEtJwDi5SY/vbaOeeD7RC106CxTCfvZ2wqgblugamP6Wq..W', 'ADM_EasyViajes', '2022-11-08 00:00:00', 1, 1, 1);

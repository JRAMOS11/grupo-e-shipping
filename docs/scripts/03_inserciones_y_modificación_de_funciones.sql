ALTER TABLE funciones_roles DROP FOREIGN KEY fk_funcionesroles_funciones;
ALTER TABLE funciones 
MODIFY COLUMN fncod VARCHAR(100) NOT NULL;
ALTER TABLE funciones_roles 
MODIFY COLUMN fncod VARCHAR(100) NOT NULL;
ALTER TABLE funciones_roles
ADD CONSTRAINT fk_funcionesroles_funciones
FOREIGN KEY (fncod) REFERENCES funciones(fncod);


INSERT INTO `categorias` (`categoryId`, `categoryName`, `categoryDescription`, `categoryStatus`) VALUES
(1, 'Alimentos', 'Productos alimenticios', 'ACT');

INSERT INTO `funciones` (`fncod`, `fndsc`, `fnest`, `fntyp`) VALUES
('Controllers\\RutasEntrega\\RutaEntrega', 'Controllers\\RutasEntrega\\RutaEntrega', 'ACT', 'CTR'),
('Controllers\\RutasEntrega\\RutasEntrega', 'Controllers\\RutasEntrega\\RutasEntrega', 'ACT', 'CTR'),
('Controllers\\Sec\\Logo', 'Controllers\\Sec\\Logout', 'ACT', 'CTR'),
('Ctr_Checkout', 'Controlador de checkout', 'ACT', 'CTR'),
('Ctr_Products', 'Controlador de productos', 'ACT', 'CTR'),
('Ctr_Roles', 'Controlador de roles', 'ACT', 'CTR'),
('Ctr_RutasEntrega', 'Controlador de rutas de entrega', 'ACT', 'CTR'),
('Ctr_Users', 'Controlador de usuarios', 'ACT', 'CTR'),
('Menu_Admin', 'Menu administrador', 'ACT', 'MNU');

INSERT INTO `roles` (`rolescod`, `rolesdsc`, `rolesest`) VALUES
('ADMIN', 'Administrador', 'ACT'),
('CLIENT', 'Cliente', 'ACT');

INSERT INTO `funciones_roles` (`rolescod`, `fncod`, `fnrolest`, `fnexp`) VALUES
('ADMIN', 'Ctr_Products', 'ACT', '2030-12-31 23:59:59'),
('ADMIN', 'Ctr_Roles', 'ACT', '2030-12-31 23:59:59'),
('ADMIN', 'Ctr_RutasEntrega', 'ACT', '2030-12-31 23:59:59'),
('ADMIN', 'Ctr_Users', 'ACT', '2030-12-31 23:59:59'),
('ADMIN', 'Menu_Admin', 'ACT', '2030-12-31 23:59:59'),
('ADMIN', 'Menu_Home', 'ACT', '2030-12-31 23:59:59'),
('ADMIN', 'Controllers\\RutasEntrega\\RutaEntrega', 'ACT', '2030-12-31 23:59:59'),
('ADMIN', 'Controllers\\RutasEntrega\\RutasEntrega', 'ACT', '2030-12-31 23:59:59'),
('ADMIN', 'Menu_PaymentCheckout', 'ACT', '2030-12-31 23:59:59'),
('ADMIN', 'Menu_Products', 'ACT', '2030-12-31 23:59:59'),
('CLIENT', 'Ctr_Checkout', 'ACT', '2030-12-31 23:59:59'),
('CLIENT', 'Ctr_Products', 'ACT', '2030-12-31 23:59:59'),
('CLIENT', 'Menu_Home', 'INA', '2030-12-31 23:59:59'),
('CLIENT', 'Menu_PaymentCheckout', 'ACT', '2030-12-31 23:59:59'),
('CLIENT', 'Menu_Products', 'ACT', '2030-12-31 23:59:59');

INSERT INTO `usuario` (`usercod`, `useremail`, `username`, `userpswd`, `userfching`, `userpswdest`, `userpswdexp`, `userest`, `useractcod`, `userpswdchg`, `usertipo`) VALUES
(1, 'davidjasiel11@gmail.com', 'John Doe', '$2y$10$wDVCeoMAaYUg6wK1mqRxFO7/uwRYfvGmSY/2e7e2EH6.F97/eSx86', '2026-03-26 13:10:29', 'ACT', '2026-06-24 00:00:00', 'ACT', '4d00688669c6e98cba9dc68a3c2454a72590b2fbdfc99814bcdd11d8ab780731', '2', 'PBL'),
(2, 'cliente1@gmail.com', 'John Doe', '$2y$10$pehcl12Tiw5zj4Uf7jsAdeOhzJwTbg6wiPS34LMvVUgn0oTVxoV12', '2026-03-26 13:50:25', 'ACT', '2026-06-24 00:00:00', 'ACT', 'b7b2c2163bccf5f977bf0257751d45510f383a6d85f0594ead328beb00e3b335', '2', 'PBL');


INSERT INTO `roles_usuarios` (`usercod`, `rolescod`, `roleuserest`, `roleuserexp`, `roleuserfch`) VALUES
(1, 'ADMIN', 'ACT', NULL, '2026-03-26 13:44:46'),
(2, 'CLIENT', 'INA', NULL, '2026-04-06 16:09:27');
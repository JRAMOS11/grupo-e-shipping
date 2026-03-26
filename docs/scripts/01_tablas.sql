CREATE TABLE usuario (
    usercod BIGINT AUTO_INCREMENT PRIMARY KEY,
    useremail VARCHAR(100) NOT NULL UNIQUE,
    username VARCHAR(100) NOT NULL,
    userpswd VARCHAR(255) NOT NULL,
    userfching DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    userpswdest CHAR(3) NOT NULL DEFAULT 'ACT',
    userpswdexp DATETIME NULL,
    userest CHAR(3) NOT NULL DEFAULT 'ACT',
    useractcod VARCHAR(200) NULL,
    userpswdchg VARCHAR(1) NOT NULL DEFAULT '0',
    usertipo CHAR(3) NOT NULL DEFAULT 'CLI'
) ENGINE=InnoDB;

CREATE TABLE roles (
    rolescod VARCHAR(15) PRIMARY KEY,
    rolesdsc VARCHAR(100) NOT NULL,
    rolesest CHAR(3) NOT NULL DEFAULT 'ACT'
) ENGINE=InnoDB;

CREATE TABLE funciones (
    fncod VARCHAR(20) PRIMARY KEY,
    fndsc VARCHAR(100) NOT NULL,
    fnest CHAR(3) NOT NULL DEFAULT 'ACT',
    fntyp CHAR(3) NOT NULL DEFAULT 'MNU'
) ENGINE=InnoDB;

CREATE TABLE roles_usuarios (
    usercod BIGINT NOT NULL,
    rolescod VARCHAR(15) NOT NULL,
    roleuserest CHAR(3) NOT NULL DEFAULT 'ACT',
    roleuserexp DATETIME NULL,
    roleuserfch DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (usercod, rolescod),
    CONSTRAINT fk_rolesusuarios_usuario
        FOREIGN KEY (usercod) REFERENCES usuario(usercod),
    CONSTRAINT fk_rolesusuarios_roles
        FOREIGN KEY (rolescod) REFERENCES roles(rolescod)
) ENGINE=InnoDB;

CREATE TABLE funciones_roles (
    rolescod VARCHAR(15) NOT NULL,
    fncod VARCHAR(20) NOT NULL,
    fnrolest CHAR(3) NOT NULL DEFAULT 'ACT',
    fnexp DATETIME NULL,
    PRIMARY KEY (rolescod, fncod),
    CONSTRAINT fk_funcionesroles_roles
        FOREIGN KEY (rolescod) REFERENCES roles(rolescod),
    CONSTRAINT fk_funcionesroles_funciones
        FOREIGN KEY (fncod) REFERENCES funciones(fncod)
) ENGINE=InnoDB;

CREATE TABLE categorias (
    categoryId INT AUTO_INCREMENT PRIMARY KEY,
    categoryName VARCHAR(100) NOT NULL,
    categoryDescription VARCHAR(255) NULL,
    categoryStatus CHAR(3) NOT NULL DEFAULT 'ACT'
) ENGINE=InnoDB;

CREATE TABLE products (
    productId INT AUTO_INCREMENT PRIMARY KEY,
    categoryId INT NULL,
    productName VARCHAR(120) NOT NULL,
    productDescription TEXT NOT NULL,
    productImgUrl VARCHAR(255) NULL,
    productPrice DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    productStock INT NOT NULL DEFAULT 0,
    productStatus CHAR(3) NOT NULL DEFAULT 'ACT',
    CONSTRAINT fk_products_category
        FOREIGN KEY (categoryId) REFERENCES categorias(categoryId)
) ENGINE=InnoDB;

CREATE TABLE rutasentrega (
    id_ruta INT AUTO_INCREMENT PRIMARY KEY,
    origen VARCHAR(100) NOT NULL,
    destino VARCHAR(100) NOT NULL,
    distancia_km DECIMAL(8,2) NULL,
    duracion_min INT NULL,
    rutaest CHAR(3) NOT NULL DEFAULT 'ACT'
) ENGINE=InnoDB;

CREATE TABLE carretilla (
    usercod BIGINT NOT NULL,
    productId INT NOT NULL,
    crrctd INT NOT NULL DEFAULT 1,
    crrfching DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    crrprc DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (usercod, productId),
    CONSTRAINT fk_carretilla_usuario
        FOREIGN KEY (usercod) REFERENCES usuario(usercod),
    CONSTRAINT fk_carretilla_product
        FOREIGN KEY (productId) REFERENCES products(productId)
) ENGINE=InnoDB;

CREATE TABLE carretillaanon (
    anoncod VARCHAR(128) NOT NULL,
    productId INT NOT NULL,
    crrctd INT NOT NULL DEFAULT 1,
    crrfching DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    crrprc DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (anoncod, productId),
    CONSTRAINT fk_carretillaanon_product
        FOREIGN KEY (productId) REFERENCES products(productId)
) ENGINE=InnoDB;

CREATE TABLE ordenes (
    ordencod INT AUTO_INCREMENT PRIMARY KEY,
    usercod BIGINT NULL,
    anoncod VARCHAR(128) NULL,
    id_ruta INT NULL,
    ordenfching DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ordensubtotal DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    ordenimpuesto DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    ordentotal DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    ordenest CHAR(3) NOT NULL DEFAULT 'PEN',
    CONSTRAINT fk_ordenes_usuario
        FOREIGN KEY (usercod) REFERENCES usuario(usercod),
    CONSTRAINT fk_ordenes_ruta
        FOREIGN KEY (id_ruta) REFERENCES rutasentrega(id_ruta)
) ENGINE=InnoDB;

CREATE TABLE orden_detalle (
    ordendetcod INT AUTO_INCREMENT PRIMARY KEY,
    ordencod INT NOT NULL,
    productId INT NOT NULL,
    ordetcantidad INT NOT NULL DEFAULT 1,
    ordetprecio DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    ordettotal DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT fk_ordendetalle_orden
        FOREIGN KEY (ordencod) REFERENCES ordenes(ordencod),
    CONSTRAINT fk_ordendetalle_product
        FOREIGN KEY (productId) REFERENCES products(productId)
) ENGINE=InnoDB;

CREATE TABLE transacciones (
    transcod INT AUTO_INCREMENT PRIMARY KEY,
    ordencod INT NOT NULL,
    usercod BIGINT NULL,
    transfching DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    transamount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    transmethod VARCHAR(30) NOT NULL DEFAULT 'LOCAL',
    transreference VARCHAR(100) NULL,
    transstatus CHAR(3) NOT NULL DEFAULT 'PEN',
    CONSTRAINT fk_transacciones_orden
        FOREIGN KEY (ordencod) REFERENCES ordenes(ordencod),
    CONSTRAINT fk_transacciones_usuario
        FOREIGN KEY (usercod) REFERENCES usuario(usercod)
) ENGINE=InnoDB;

CREATE TABLE bitacora (
    bitcod INT AUTO_INCREMENT PRIMARY KEY,
    usercod BIGINT NULL,
    bitdesc VARCHAR(255) NOT NULL,
    bitfching DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_bitacora_usuario
        FOREIGN KEY (usercod) REFERENCES usuario(usercod)
) ENGINE=InnoDB;
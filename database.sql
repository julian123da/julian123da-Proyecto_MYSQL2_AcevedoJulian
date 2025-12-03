-- Creacion de la database y tablas principales

CREATE DATABASE IF NOT EXISTS pizzeria;
USE pizzeria;

-- --------------
--Tabla cliente
-- --------------

CREATE TABLE cliente(
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(100),
    PRIMARY KEY (id)
);

-- -------------
--Tabla empelado
-- -------------

CREATE TABLE empelado(
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL,
    cargo ENUM('cocinero','domiciliario','cajero') NOT NULL,
    PRIMARY KEY (id)
);

-- ---------------
--Tabla pizza
-- ---------------

CREATE TABLE pizza(
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id)
);

-- ----------------
--Tabla ingrediente
-- ----------------

CREATE TABLE ingrediente(
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL
    PRIMARY KEY (id)
);

-- -----------------
--Tabla pedido
-- -----------------

CREATE TABLE pedido(
    id INT NOT NULL AUTO_INCREMENT,
    fecha DATETIME NOT NULL,
    cliente_id INT NOT NULL,
    empelado_id INT NOT NULL,
    total DECIMAL(10,2),
    PRIMARY KEY (id),
    FOREING KEY (cliente_id) REFERENCES cliente(id),
    FOREING KEY (empelado_id) REFERENCES empelado(id)
);

-- ------------------------
--Tabla detalle del pedido
-- ------------------------

CREATE TABLE detalle_pedido(
    id INT NOT NULL AUTO_INCREMENT,
    pedido_id INT NOT NULL,
    pizza_id INT NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id),
    FOREING KEY (pedido_id) REFERENCES pedido(id),
    FOREING KEY (pizza_id) REFERENCES pizza(id)
);

-- ------------------------
--Tabla repartidor
-- ------------------------

CREATE TABLE repartidor (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL,
    zona ENUM('norte','sur','este','oeste') NOT NULL,
    estado ENUM('disponible','no disponible') DEFAULT 'disponible',
    PRIMARY KEY (id)
);


-- ------------------------
--Tabla domicilio
-- ------------------------

CREATE TABLE domicilio (
    id INT NOT NULL AUTO_INCREMENT,
    pedido_id INT NOT NULL,
    repartidor_id INT NOT NULL,
    hora_salida DATETIME,
    hora_entrega DATETIME,
    distancia_km DECIMAL(5,2),
    costo_envio DECIMAL(10,2),
    PRIMARY KEY (id),
    FOREIGN KEY (pedido_id) REFERENCES pedido(id),
    FOREIGN KEY (repartidor_id) REFERENCES repartidor(id)
);

-- ------------------------
--Tabla: historial_precios
-- ------------------------

CREATE TABLE historial_precios (
    id INT NOT NULL AUTO_INCREMENT,
    pizza_id INT NOT NULL,
    precio_antiguo DECIMAL(10,2),
    precio_nuevo DECIMAL(10,2),
    fecha_cambio DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (pizza_id) REFERENCES pizza(id)
);

-- ------------------------
--Tabla: stock_ingredientes
-- ------------------------

CREATE TABLE stock_ingredientes (
    ingrediente_id INT NOT NULL,
    cantidad_actual INT NOT NULL,
    cantidad_minima INT NOT NULL,
    PRIMARY KEY (ingrediente_id),
    FOREIGN KEY (ingrediente_id) REFERENCES ingrediente(id)
);

-- ============================================
-- Creación de la base de datos y tablas principales
-- ============================================
DROP DATABASE pizzeria;
CREATE DATABASE pizzeria;
USE pizzeria;

-- =====================
-- Tabla: cliente
-- =====================

CREATE TABLE cliente(
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(100),
    PRIMARY KEY (id)
);

-- Datos: cliente
INSERT INTO cliente (nombre, telefono, direccion) VALUES
('Carlos Pérez', '3001234567', 'Calle 10 #20-30'),
('María Gómez', '3009876543', 'Av 5 #14-22'),
('Luis Herrera', '3014567890', 'Cra 15 #45-10'),
('Ana Salazar', '3029988776', 'Calle 8 #12-50');

-- =====================
-- Tabla: empleado
-- =====================

CREATE TABLE empleado(
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL,
    cargo ENUM('cocinero','domiciliario','cajero') NOT NULL,
    PRIMARY KEY (id)
);

-- Datos: empleado
INSERT INTO empleado (nombre, cargo) VALUES
('Ana Torres', 'cocinero'),
('Luis Martínez', 'domiciliario'),
('Pedro Ríos', 'cajero'),
('Valentina Gómez', 'cocinero'),
('Santiago Londoño', 'domiciliario');

-- =====================
-- Tabla: pizza
-- =====================

CREATE TABLE pizza(
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id)
);

-- Datos: pizza
INSERT INTO pizza (nombre, precio) VALUES
('Hawaiana', 28000),
('Mexicana', 32000),
('Pollo Champiñones', 30000),
('Pepperoni', 31000);

-- =====================
-- Tabla: ingrediente
-- =====================

CREATE TABLE ingrediente(
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL,
    PRIMARY KEY (id)
);

-- Datos: ingrediente
INSERT INTO ingrediente (nombre) VALUES
('Queso Mozzarella'),
('Pepperoni'),
('Jamón'),
('Champiñones'),
('Salsa de Tomate'),
('Cebolla'),
('Pimiento Verde'),
('Aceitunas Negras'),
('Tocineta'),
('Pollo');

-- =====================
-- Tabla: pedido
-- =====================

CREATE TABLE pedido(
    id INT NOT NULL AUTO_INCREMENT,
    fecha DATETIME NOT NULL,
    cliente_id INT NOT NULL,
    empleado_id INT NOT NULL,
    total DECIMAL(10,2),
    PRIMARY KEY (id),
    FOREIGN KEY (cliente_id) REFERENCES cliente(id),
    FOREIGN KEY (empleado_id) REFERENCES empleado(id)
);

-- Datos: pedido
INSERT INTO pedido (fecha, cliente_id, empleado_id, total) VALUES
(NOW(), 1, 3, 55000),
(NOW(), 3, 1, 32000),
(NOW(), 4, 2, 42000);

-- =============================
-- Tabla: detalle_pedido
-- =============================

CREATE TABLE detalle_pedido(
    id INT NOT NULL AUTO_INCREMENT,
    pedido_id INT NOT NULL,
    pizza_id INT NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (pedido_id) REFERENCES pedido(id),
    FOREIGN KEY (pizza_id) REFERENCES pizza(id)
);

-- Datos: detalle_pedido
INSERT INTO detalle_pedido (pedido_id, pizza_id, cantidad) VALUES
(1, 1, 1), 
(1, 3, 1),  
(2, 2, 1),  
(3, 4, 2);

-- =====================
-- Tabla: repartidor
-- =====================

CREATE TABLE repartidor (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL,
    zona ENUM('norte','sur','este','oeste') NOT NULL,
    estado ENUM('disponible','no disponible') DEFAULT 'disponible',
    PRIMARY KEY (id)
);

-- Datos: repartidor
INSERT INTO repartidor (nombre, zona, estado) VALUES
('Juan Castro', 'norte', 'disponible'),
('Milena Ruiz', 'sur', 'no disponible'),
('Oscar Medina', 'este', 'disponible');

-- =====================
-- Tabla: domicilio
-- =====================

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

-- Datos: domicilio
INSERT INTO domicilio (pedido_id, repartidor_id, hora_salida, hora_entrega, distancia_km, costo_envio) VALUES
(1, 1, NOW(), NOW(), 3.5, 5000),
(2, 3, NOW(), NOW(), 5.2, 6000);

-- =============================
-- Tabla: historial_precios
-- =============================

CREATE TABLE historial_precios (
    id INT NOT NULL AUTO_INCREMENT,
    pizza_id INT NOT NULL,
    precio_antiguo DECIMAL(10,2),
    precio_nuevo DECIMAL(10,2),
    fecha_cambio DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (pizza_id) REFERENCES pizza(id)
);

-- =============================
-- Tabla: stock_ingredientes
-- =============================

CREATE TABLE stock_ingredientes (
    ingrediente_id INT NOT NULL,
    cantidad_actual INT NOT NULL,
    cantidad_minima INT NOT NULL,
    PRIMARY KEY (ingrediente_id),
    FOREIGN KEY (ingrediente_id) REFERENCES ingrediente(id)
);

-- Datos: stock_ingredientes
INSERT INTO stock_ingredientes (ingrediente_id, cantidad_actual, cantidad_minima) VALUES
(1, 50, 10),
(2, 40, 10),
(3, 35, 10),
(4, 30, 10),
(5, 60, 15),
(6, 25, 5),
(7, 20, 5),
(8, 15, 5),
(9, 18, 5),
(10,22, 5);

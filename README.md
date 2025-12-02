## Proyecto MYSQL2 Pizzeria don Piccolo

# Pizzería Don Piccolo - Sistema de Gestión de Pedidos

Este proyecto consiste en el diseño y construcción de una base de datos en MySQL para gestionar los pedidos, clientes, empleados, pizzas e ingredientes de la Pizzería Don Piccolo.

El objetivo principal es mejorar el control interno del negocio y automatizar procesos como el cálculo de totales, el registro del detalle de los pedidos y la actualización de la información relacionada.

---

## Contenido del Proyecto

/pizzeria-don-piccolo/
├── database.sql # Creación de tablas y llaves foráneas
├── funciones.sql # Funciones (total de pedido)
├── triggers.sql # Triggers automáticos
├── vistas.sql # Vistas de consulta
├── consultas.sql # Consultas SQL útiles
└── README.md # Documentación del proyecto

---

## Descripción de las Tablas

### cliente
Guarda la información de los clientes que realizan pedidos.

### empleado
Registra los empleados, su nombre y cargo (cocinero, domiciliario, cajero).

### pizza
Contiene los tipos de pizza y su precio.

### ingrediente
Lista los ingredientes utilizados.

### pizza_ingrediente
Relaciona las pizzas con sus ingredientes.

### pedido
Registra los pedidos con fecha, cliente, empleado asignado y total.

### detalle_pedido
Línea a línea del pedido: pizzas, cantidades y subtotal.

---

## Automatizaciones

### Trigger de subtotal
Calcula el subtotal de cada línea del pedido antes de insertarla.

### Trigger de total del pedido
Actualiza automáticamente el total del pedido después de agregar un detalle.

### Función total_pedido
Permite calcular manualmente el total de un pedido.

---

## Vistas Incluidas

- **vista_pedidos**: muestra los pedidos con nombre del cliente y empleado.
- **vista_detalle_pedidos**: detalle de pizzas, cantidades y subtotales.

---
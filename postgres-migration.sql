-- PostgreSQL migration script for gestion-gastos
-- Adapted from MySQL dump


-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Table structure for table cuenta_presupuesto
DROP TABLE IF EXISTS cuenta_presupuesto;
CREATE TABLE cuenta_presupuesto (
    id_cuenta INTEGER,
    mes INTEGER,
    anio INTEGER,
    asignado INTEGER,
    consumido_ind INTEGER
);

-- Table structure for table cuentas
DROP TABLE IF EXISTS cuentas;
CREATE TABLE cuentas (
    id SERIAL PRIMARY KEY,
    id_categoria INTEGER NOT NULL,
    mes INTEGER,
    anio INTEGER,
    nombre VARCHAR(60),
    asignado INTEGER,
    ck_consumo_compartido INTEGER,
    consumido_ind INTEGER,
    forma_pago VARCHAR(30),
    grupo VARCHAR(30),
    tipo_gasto VARCHAR(30)
);

-- Table structure for table cuentas_n
DROP TABLE IF EXISTS cuentas_n;
CREATE TABLE cuentas_n (
    id_cuenta SERIAL PRIMARY KEY,
    id_categoria INTEGER NOT NULL,
    nombre VARCHAR(60),
    forma_pago VARCHAR(30),
    grupo VARCHAR(30),
    tipo_gasto VARCHAR(30),
    ck_consumo_compartido INTEGER
);

-- Table structure for table gastos
DROP TABLE IF EXISTS gastos;
CREATE TABLE gastos (
    id SERIAL PRIMARY KEY,
    valor FLOAT,
    fecha VARCHAR(255),
    pagador INTEGER,
    titulo VARCHAR(255),
    categoria INTEGER,
    repartirentre INTEGER,
    updated_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP NOT NULL
);

-- Table structure for table gastosviews
DROP TABLE IF EXISTS gastosviews;
CREATE TABLE gastosviews (
    id SERIAL PRIMARY KEY,
    month INTEGER,
    year INTEGER,
    pagador INTEGER,
    total FLOAT,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

-- Vista para total por persona
DROP VIEW IF EXISTS total_by_people;
CREATE VIEW total_by_people AS
SELECT 
    EXTRACT(MONTH FROM fecha::date) AS month,
    EXTRACT(YEAR FROM fecha::date) AS year,
    pagador,
    repartirentre,
    SUM(valor) AS total
FROM gastos
GROUP BY 
    EXTRACT(MONTH FROM fecha::date),
    EXTRACT(YEAR FROM fecha::date),
    pagador,
    repartirentre;

-- Create view total_by_account
DROP VIEW IF EXISTS total_by_account;
CREATE VIEW total_by_account AS
SELECT 
    EXTRACT(MONTH FROM a.fecha::date) AS month,
    EXTRACT(YEAR FROM a.fecha::date) AS year,
    SUM(a.valor) AS total
FROM gastos a
JOIN cuentas b ON a.categoria = b.id_categoria
WHERE b.forma_pago = 'Mensual'
GROUP BY a.fecha;

-- Create view total_by_person
DROP VIEW IF EXISTS total_by_person;
CREATE VIEW total_by_person AS
SELECT 
    EXTRACT(MONTH FROM fecha::date) AS month,
    EXTRACT(YEAR FROM fecha::date) AS year,
    pagador,
    repartirentre,
    SUM(valor) AS total
FROM gastos
GROUP BY fecha, pagador, repartirentre;

-- Insert data into cuenta_presupuesto
INSERT INTO cuenta_presupuesto (id_cuenta, mes, anio, asignado, consumido_ind) VALUES
(1,5,2024,10000,0),(2,5,2024,10000,0),(3,5,2024,10000,0),(4,5,2024,10000,0),
(5,5,2024,10000,0),(6,5,2024,10000,0),(7,5,2024,10000,0),(9,5,2024,10000,0),
(10,5,2024,10000,0),(11,5,2024,10000,0),(12,5,2024,10000,0),(13,5,2024,10000,0),
(14,5,2024,10000,0),(15,5,2024,10000,0),(16,5,2024,10000,0),(17,5,2024,10000,0),
(18,5,2024,10000,0),(19,5,2024,10000,0),(20,5,2024,10000,0),(21,5,2024,10000,0);

-- Insert data into cuentas
INSERT INTO cuentas (id_categoria, nombre, asignado, forma_pago, grupo, tipo_gasto) VALUES
(1,'Carnicería y Pollo',10000,'Manual','','Variable'),
(2,'Panadería',10000,'Manual','','Variable'),
(3,'Quesería',10000,'Manual','','Variable'),
(4,'Supermercado',10000,'Manual','','Variable'),
(5,'Verdulería',10000,'Manual','','Variable'),
(6,'Leña y carbon',10000,'Manual','','Variable'),
(7,'Almacén',10000,'Manual','','Variable'),
(9,'Roberto',10000,'Manual','','Variable'),
(10,'Delivery´s',10000,'Manual','','Variable'),
(11,'Salidas',10000,'Manual','','Variable'),
(12,'Hogar & Mantenimiento',10000,'Manual','','Variable'),
(13,'Jardinería',10000,'Manual','','Variable'),
(14,'Remises & Transportes',10000,'Manual','','Variable'),
(15,'Prestamos Soquetudenses',10000,'Manual','','Variable'),
(16,'Regalos',10000,'Manual','','Mensual'),
(17,'Combustible',10000,'','','Variable'),
(18,'Mantenimiento y taller',10000,'Manual','','Mensual'),
(19,'Vacaciones',10000,'Manual','','Variable'),
(20,'Seguro Auto',10000,'Deb-Auto','','Mensual'),
(21,'Alquiler',425000,'Manual','','Mensual');

-- Insert data into cuentas_n
INSERT INTO cuentas_n (id_categoria, nombre, forma_pago, grupo, tipo_gasto) VALUES
(1,'Carnicería y Pollo','Manual','','Variable'),
(2,'Panadería','Manual','','Variable'),
(3,'Quesería','Manual','','Variable'),
(4,'Supermercado','Manual','','Variable'),
(5,'Verdulería','Manual','','Variable'),
(6,'Leña y carbon','Manual','','Variable'),
(7,'Almacén','Manual','','Variable'),
(9,'Roberto','Manual','','Variable'),
(10,'Delivery´s','Manual','','Variable'),
(11,'Salidas','Manual','','Variable'),
(12,'Hogar & Mantenimiento','Manual','','Variable'),
(13,'Jardinería','Manual','','Variable'),
(14,'Remises & Transportes','Manual','','Variable'),
(15,'Prestamos Soquetudenses','Manual','','Variable'),
(16,'Regalos','Manual','','Mensual'),
(17,'Combustible','','','Variable'),
(18,'Mantenimiento y taller','Manual','','Mensual'),
(19,'Vacaciones','Manual','','Variable'),
(20,'Seguro Auto','Deb-Auto','','Mensual'),
(21,'Alquiler','Manual','','Mensual');

-- Insert data into gastos
INSERT INTO gastos (valor, fecha, pagador, titulo, categoria, repartirentre, updated_at, created_at) VALUES
(2001,'2024-03-03',1,'monarch',5,0,'2024-03-03 00:00:00','2024-02-26 00:00:00'),
(100,'2024-02-26',2,'algo',1,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),
(5001,'2024-03-03',2,'pollo',7,0,'2024-03-03 00:00:00','2024-02-26 00:00:00'),
(200,'2024-02-27',1,'kiosco',3,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'),
(200,'2024-02-27',1,'otra cosa',1,0,'2024-02-26 00:00:00','2024-02-26 00:00:00'); 
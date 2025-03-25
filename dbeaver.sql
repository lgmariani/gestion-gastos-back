CREATE DATABASE `gestion-gastos`
    DEFAULT CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

drop table Gastos;  

CREATE TABLE Gastos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    valor FLOAT NOT NULL,
    fecha VARCHAR(255) NOT NULL,
    pagador INT NOT NULL,
    titulo VARCHAR(255),
    categoria INT NOT NULL,
    repartirentre INT NOT null,
    updatedAt date null,
    createdAt date not null
);


drop table Cuentas;

insert into Cuentas_n 
select id,  id_categoria, nombre, forma_pago, grupo, tipo_gasto
from cuentas


create table Cuentas_n (
	id_cuenta INT AUTO_INCREMENT PRIMARY KEY,
	id_categoria int not null,
	nombre varchar(60),
	forma_pago varchar(30),
	grupo varchar(30),
	tipo_gasto varchar(30)
);

alter table cuentas_n add ck_consumo_compartido int

create table cuenta_presupuesto (
	id_cuenta int,
	mes int,
	anio int,
	asignado int,
	consumido_ind int
)

insert into cuenta_presupuesto 
select id, 5, 2024, 10000, 0
from cuentas


select * from cuenta_presupuesto 


create or replace view total_by_account as 
select 
month(fecha) as month, year(fecha) as year, sum(valor) as total
from gastos a, Cuentas b
where a.categoria = b.id_categoria and b.forma_pago = 'Mensual' 
group by fecha;



select * from total_by_account

create or replace view total_by_person as 
select 
month(fecha) as month, year(fecha) as year, pagador, repartirentre, sum(valor) as total
from gastos
group by fecha, pagador, repartirentre;


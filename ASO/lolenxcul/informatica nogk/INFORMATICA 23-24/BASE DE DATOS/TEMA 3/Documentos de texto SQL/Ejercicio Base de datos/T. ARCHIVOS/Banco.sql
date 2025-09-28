create table entidades (
	id_entidad char(4) primary key,
	nombre varchar(25)
) ;


create table oficina (
	cod_oficina char(4),
	id_entidad char(4),
	direccion varchar(30),
	primary key (cod_oficina, id_entidad),
	foreign key (id_entidad)
		references entidades (id_entidad)
) ;

create table cuentas (
	num_cuentas char(10),
	id_entidad char(4),
	cod_oficina char(4),
	saldo decimal(10),
	primary key (num_cuentas, id_entidad, cod_oficina),
	foreign key (id_entidad)
		references entidades (id_entidad),
	foreign key (cod_oficina)
		references oficina (cod_oficina)
) ;


create table movimientos (
	num_correlativo int primary key,
	importe decimal(10),
	fecha_de_realizacion date
) ;

create table titulares (
	nif char(9) primary key,
	nombre varchar(30),
	num_correlativo int,
	foreign key (num_correlativo)
		references movimientos (num_correlativo)
) ;


create table titular_cuenta (
	num_cuentas char(10),
	id_entidad char(4),
	cod_oficina char(4),
	nif char(9),
	primary key (num_cuentas, id_entidad, cod_oficina, nif),
	foreign key (num_cuentas)
		references cuentas (num_cuentas),
	foreign key (id_entidad)
		references entidades (id_entidad),
	foreign key (cod_oficina)
		references oficina (cod_oficina),
	foreign key (nif)
		references titulares (nif)
) ;


insert into entidades (id_entidad, nombre)
	values(2100,'la caixa');

insert into entidades (id_entidad, nombre) 
values (0049,'santander'),(0073,'openbank'),(2095,'kutxabank'); 











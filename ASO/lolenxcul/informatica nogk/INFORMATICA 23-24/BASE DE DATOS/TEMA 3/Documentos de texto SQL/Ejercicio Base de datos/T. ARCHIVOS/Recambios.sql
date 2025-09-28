create table marca (
	id_marca INT primary key,
	marca varchar(45) not null,
	conocido char(1) not null
) ;

create table combustible (
	id_combustible INT primary key,
	combustible varchar(45)
) ;

create table modelo (
	id_modelo INT primary key,
	id_marca INT,
	modelo varchar(45) not null,
	foreign key (id_marca)
		references marca (id_marca)
) ;

create table version (
	id_version INT primary key,
	id_modelo INT,
	version varchar(45) not null,
	foreign key (id_modelo)
		references modelo (id_modelo)
)  ;

create table motor (
	id_motor INT primary key,
	id_version INT,
	id_combustible INT,
	motor varchar(45),
	foreign key (id_version)
		references version (id_version),
	foreign key (id_combustible)
		references combustible (id_combustible)
) ;

create table fabricante_recambio (
	id_fabricante_recambio INT primary key,
	fabricante_recambio varchar(45)
) ;

create table categoria (
	id_categoria INT primary key,
	categoria varchar(45),
	id_categoria_padre INT,
	foreign key (id_categoria)
		references categoria (id_categoria)
) ;

create table recambio (
	id_recambio INT primary key,
	id_fabricante_recambio INT,
	recambio varchar(45),
	precio decimal(10,2),
	foreign key (id_fabricante_recambio)
		references fabricante_recambio (id_fabricante_recambio)
) ;

create table recambio_motor (
	id_motor INT,
	id_recambio INT,
	primary key (id_motor, id_recambio),
	foreign key (id_motor)
		references motor (id_motor),
	foreign key (id_recambio)
		references recambio (id_recambio)
) ;

create table categoria_recambio ( 
	id_recambio INT,
	id_categoria INT,
	foreign key (id_recambio)
		references recambio (id_recambio)
	foreign key (id_categoria)
		references categoria (id_categoria)
) ;

	
	

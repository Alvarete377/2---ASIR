
create table categoria (
    id_categoria int primary key,
    categoria varchar(45) not null,
    id_categoria_padre int,
    foreign key (id_categoria_padre) references categoria (id_categoria)
) ;

create table categoria_recambio (
    id_recambio int,
    id_categoria int,
    primary key (id_recambio, id_categoria),
    foreign key (id_recambio) references recambio (id_recambio),
    foreign key (id_categoria) references categoria (id_categoria)
) ;

insert into categoria (id_categoria, categoria) values (1,"Neumáticos"),(2,"Frenos"),(3,"Suspensión"),(4,"Motor"),(5,"Sistema eléctrico") ;

insert into categoria (id_categoria, id_categoria_padre, categoria) 
    values (6,1,"Neumáticos de verano"),(7,1,"Neumáticos de invierno"),(8,1,"Neumáticos all season"),
            (9,2,"Pastillas de freno"),(10,2,"Discos de freno"),(11,2,"Sensor de desgaste de pastillas"),(12,2,"Servofreno"),
            (13,3,"Tornillos de rueda y tuercas"),(14,3,"Silentblock de brazo"),(15,3,"Bieletas de suspensión"),
        (16,4,"Intercooler"),(17,4,"Turbocompresor"),(18,4,"Inyector"),
        (19,5,"Fusible"),(20,5,"Batería"),(21,5,"Alternador"),(22,5,"Catalizador") ;

insert into fabricante_recambio values (1, "Bosch"),(2,"Hella"),(3,"Vemo"),(4,"Behr") ;

insert into recambio (id_recambio, id_fabricante_recambio, recambio, precio)
    values (1,1,"Bosch 0 986 Disco freno",33.5), (2,1,"Bosch juego pastillas freno",28.96),
        (3,1,"Bosch juego pastillas freno low-mettalic",41.13),
        (4,2,"Hella piloto posterior",53.37),(5,2,"Hella Piloto trasero",55.17) ;
    
insert into categoria (id_categoria, categoria) values (6,"Carrocería") ;
insert into categoria (id_categoria, id_categoria_padre, categoria) 
    values (23,6,"Faro trasero") ;
insert into categoria_recambio (id_categoria, id_recambio) 
    values (10,1),(9,2),(9,3),(23,4),(23,5) ;

insert into recambio_motor (id_motor, id_recambio) 
values (1392,1), (1392,3), (1392,5), (1394,1);

insert into recambio_motor (id_motor, id_recambio) 
values (1414,2), (1414,4), (1414,1), (1410,5), (1410,1);

insert into recambio_motor (id_motor, id_recambio) 
values (1414,2), (1414,4), (1414,1), (1410,5), (1410,1);

update marca set marca=trim(marca) ;
update modelo set modelo=trim(modelo) ;
update version set version=trim(version) ;
update motor set motor=trim(motor) ;
        

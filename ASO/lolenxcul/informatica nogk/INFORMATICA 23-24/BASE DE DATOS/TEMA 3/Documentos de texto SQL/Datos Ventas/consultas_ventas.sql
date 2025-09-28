---------Devuelve un listado con todos los pedidos que se han realizado. Los pedidos deben estar ordenados por la fecha de realización, mostrando en primer lugar los pedidos más recientes.--------


select 	*
from 	pedido
order by fecha desc;


------2. Devuelve todos los datos de los dos pedidos de mayor valor.


select 	*
from 	pedido
order by pedido.total
limit 	2;


-------3. Devuelve un listado con los identificadores de los clientes que han realizado algún pedido. Tenga en cuenta que no debe mostrar identificadores que estén repetidos.


select distinct pedido.id_cliente
from pedido;


--------4. Devuelve un listado de todos los pedidos que se realizaron durante el año 2017, cuya cantidad total sea superior a 500€.


select 	pedido.fecha, pedido.total
from 	pedido
where 	pedido.total > 500 and YEAR(fecha)=2017 ;


--------5. Devuelve un listado con el nombre y los apellidos de los comerciales que tienen una comisión entre 0.05 y 0.11.


select 	*
from 	comercial
where 	comercial.comisión between 0.05 and 0.11 ; 


-------6. Devuelve el valor de la comisión de mayor valor que existe en la tabla comercial.


select 	comisión
from 	comercial
order by comisión desc limit 1;

---------OTRA FORMA DE HACERLO

select max(comisión)
from comercial ;


-------7. Devuelve el identificador, nombre y primer apellido de aquellos clientes cuyo segundo apellido no es NULL. El listado deberá estar ordenado alfabéticamente por apellidos y nombre.


select id, nombre, apellido1, apellido2
from cliente 
where apellido2 is not null
order by apellido1, nombre ;


--------8. Devuelve un listado de los nombres de los clientes que empiezan por A y terminan por n y también los nombres que empiezan por P. El listado deberá estar ordenado alfabéticamente.


select nombre 
from cliente
where nombre like 'A%n' or nombre like 'P%'
order by nombre;


---------9. Devuelve un listado de los nombres de los clientes que no empiezan por A. El listado deberá estar ordenado alfabéticamente.


select nombre 
from cliente
where nombre not like 'A%'
order by nombre;


-----------10. Devuelve un listado con los nombres de los comerciales que terminan por el o o. Tenga en cuenta que se deberán eliminar los nombres repetidos.


select distinct nombre 
from comercial
where nombre like '%el' or nombre like '%o' ;


--------1. Devuelve un listado con el identificador, nombre y los apellidos de todos los clientes que han realizado algún pedido. El listado debe estar ordenado alfabéticamente y se deben eliminar los elementos repetidos.

----SINTAXIS SQL1-----

select distinct cliente.id, cliente.nombre, cliente.apellido1, cliente.apellido2
from pedido, cliente
order by cliente.apellido1, cliente.apellido2, cliente.nombre ;

----SINTAXIS SQL2-----

select distinct cliente.id, cliente.nombre, cliente.apellido1, cliente.apellido2
from pedido join cliente on (id_cliente = cliente.id)
where pedido.id_cliente = cliente.id
order by cliente.apellido1, cliente.apellido2, cliente.nombre ;


------2. Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. El resultado debe mostrar todos los datos de los pedidos y del cliente. El listado debe mostrar los datos de los clientes ordena dos alfabéticamente.


select *
from pedido join cliente on (pedido.id_cliente = cliente.id)
order by cliente.apellido1, cliente.apellido2, cliente.nombre ;


--------3. Devuelve un listado que muestre todos los pedidos en los que ha participado un comercial. El resultado debe mostrar todos los datos de los pedidos y de los comerciales. El listado debe mostrar los datos de los comerciales ordenados alfabéticamente.


select *
from pedido join comercial on (pedido.id_comercial = comercial.id)
order by comercial.apellido1, comercial.apellido2, comercial.nombre ;


--------4. Devuelve un listado que muestre todos los clientes, con todos los pedidos que han realizado y con los datos de los comerciales asociados a cada pedido.


select *
from pedido join cliente on (pedido.id_cliente = cliente.id)
	join cliente on (pedido.id_cliente = cliente.id) ;


--------5. Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2017, cuya cantidad esté entre 300 € y 1000 €.


select distinct cliente.*
from cliente join pedido on (pedido.id_cliente = cliente.id)
where pedido.total between 300 and 1000 and year(pedido.fecha) = 2017 ;


--------6. Devuelve el nombre y los apellidos de todos los comerciales que ha participado en algún pedido realizado por María Santana Moreno.


select distinct comercial.*
from pedido join comercial on (pedido.id_comercial = comercial.id)
	join cliente on (pedido.id_cliente = cliente.id)
order by cliente.nombre='María'
	and cliente.apellido1='Santana'
	and cliente.apellido2='Moreno' ;


--------7. Devuelve el nombre de todos los clientes que han realizado algún pedido con el comercial Daniel Sáez Vega.


select distinct cliente.*
from pedido join comercial on (pedido.id_comercial = comercial.id)
	join cliente on (pedido.id_cliente = cliente.id)
order by comercial.nombre='Daniel' and comercial.apellido1='Sáez' and comercial.apellido2='Vega' ;


---------1. Devuelve un listado con todos los clientes junto con los datos de los pedidos que han realizado. Este listado también debe incluir los clientes que no han realizado ningún pedido. El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los clientes.


select cliente.*, pedido.*
from pedido right join cliente on (pedido.id_cliente = cliente.id)
order by cliente.apellido1, cliente.apellido2, cliente.nombre ;


------2. Devuelve un listado con todos los comerciales junto con los datos de los pedidos que han realizado. Este listado también debe incluir los comerciales que no han realizado ningún pedido. El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los comerciales.


select comercial.*, pedido.*
from pedido right join comercial on (pedido.id_comercial = comercial.id)
order by comercial.apellido1, comercial.apellido2, comercial.nombre ;


------3. Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido.


select distinct cliente.*
from pedido right join cliente on (pedido.id_cliente = cliente.id)
where pedido.id is null
order by cliente.apellido1, cliente.apellido2, cliente.nombre ;


-----OTRA FORMA DE HACERLO

select cliente.* 
from cliente
where id not in (select id_cliente from pedido) ;


------4. Devuelve un listado que solamente muestre los comerciales que no han realizado ningún pedido.



------5. Devuelve un listado con los clientes que no han realizado ningún pedido y de los comerciales que no han participado en ningún pedido. Ordene el listado alfabéticamente por los apellidos y el nombre. Enlistado deberá diferenciar de algún modo los clientes y los comerciales.


select 'Cliente' as relacion, cliente.apellido1, cliente.apellido2, cliente.nombre
from pedido right join cliente on (pedido.id_cliente = cliente.id)
where pedido.id is null
union
select 'Comercial' as relacion, comercial.apellido1, comercial.apellido2, comercial.nombre
from pedido right join comercial on (pedido.id_comercial = comercial.id)
where pedido.id is null
order by apellido1, apellido2, nombre ;


------14. Devuelve cuál ha sido el pedido de máximo valor que se ha realizado cada año.

select year(fecha), max(total)



-----15. Devuelve el número total de pedidos que se han realizado cada año.







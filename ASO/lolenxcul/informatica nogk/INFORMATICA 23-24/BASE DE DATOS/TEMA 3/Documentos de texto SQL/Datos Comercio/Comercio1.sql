------1. Número de productos e importe de cada venta------

SELECT venta.id_venta,
    cliente.cliente,
    
    sum(detalle.cantidad),
    sum(detalle.cantidad * producto.precio)
    
    FROM venta, detalle, producto, cliente
    
    WHERE venta.id_venta = detalle.id_venta AND
    detalle.id_producto = producto.id_producto AND
    venta.id_venta = cliente.id_cliente
    
    GROUP BY venta.id_venta,
    cliente.cliente
    
    limit 4;


-----EJEMPLO DE RESUMEN:-------

SELECT	venta.id_venta,
	venta.fecha,
	sum(detalle.cantidad) num_productos,
	sum(detalle.cantidad * producto.precio) importe

FROM	venta join detalle using (id_venta)
		join producto using (id_producto)
	
GROUP BY venta.id_venta, 
	venta.fecha 
	;


        
---------2. Número de productos que hay de cada categoría 😜️----------

SELECT  categoria, 
	count(id_producto) productos
	
FROM 	categoria join producto using (id_categoria) 
       
GROUP BY categoria ;
    
    
-------COMPROBACION:--------

SELECT	id_categoria, categoria,
	count(producto)

FROM	categoria join producto using (id_categoria)

WHERE 	id_categoria=3

GROUP BY categoria    ;

    
------COMPROBACION 2:----
select categoria, count(id_producto) from categoria left join producto using (id_categoria) group by categoria ;    
    
    
--------CREAR TABLA DE PRUEBA---------
    
CREATE TABLE prueba as
SELECT	categoria,
	count(*) num_productos
	
FROM	categoria join producto using (id_categoria)

GROUP BY categoria  ;    
    
     
     
--------3. Número de productos de cada fabricante----------  
     
SELECT  fabricante, 
	count(producto) productos
	
FROM 	producto, fabricante
       
WHERE	producto.id_fabricante = fabricante.id_fabricante
       
GROUP BY producto.id_fabricante ;


--------CORECCION---------

SELECT  fabricante.fabricante, 
	count(id_producto) productos
	
FROM	fabricante join producto using (id_fabricante)
       
GROUP BY fabricante.fabricante ;



-------4. Número de ventas e importe total de las ventas realizadas por cada empleado------

SELECT empleado.id_empleado, empleado, 
	count(distinct venta.id_venta), sum(cantidad)
    
    FROM empleado, venta, detalle
    
    WHERE empleado.id_empleado = venta.id_empleado AND
    	  venta.id_venta = detalle.id_venta AND
    	  empleado.id_empleado = 32 ;
    
    
    
 SELECT empleado.id_empleado, empleado, 
	count(distinct venta.id_venta), sum(cantidad)
    
    FROM empleado, venta left join detalle on venta.id_venta = detalle.id_venta
    
    WHERE empleado.id_empleado = venta.id_empleado AND
    	  empleado.id_empleado = 32 ;
       
 
 
SELECT empleado.id_empleado, empleado, 
	count(distinct venta.id_venta) num_ventas, 
	sum(cantidad) num_unidades,
	sum(cantidad * precio) importe
    
    FROM empleado, venta left join detalle using (id_venta), producto
    
    WHERE empleado.id_empleado = venta.id_empleado AND
    	  detalle.id_producto = producto.id_producto AND
    	  empleado.id_empleado = 32 ;
   
   
   
----Conuslta que obtenga el if_venta y el numero de detalles de dicha venta (incluso cuando no tengan detalle) para el id_empleado=32  ---- 
   
select venta.id_venta, count(id_detalle) num_detalles from venta left join detalle using (id_venta) where id_empleado = 32 group by venta.id_venta order by num_detalles ;



select sum(cantidad), sum(cantidad*precio) from detalle, producto where detalle.id_producto and id_venta = 12043 ;


SELECT	empleado.id_empleado,
	empleado.empleado,
	count(distinct venta.id_venta) num_ventas,
	sum(detalle.cantidad) sum_productos,
	sum(detalle.cantidad * producto.precio) importe
	
FROM	( empleado left join venta using (id_empleado) )
		left join
	( detalle join producto using (id_producto) ) using (id_venta)

GROUP BY empleado.id_empleado,
	empleado.empleado
	;
	


----5. Número de ventas e importe total de las ventas realizadas a cada cliente----

SELECT cliente.cliente,
    
    sum(detalle.cantidad),
    sum(detalle.cantidad * producto.precio)
    
    FROM venta, detalle, producto, cliente
    
    WHERE venta.id_venta = detalle.id_venta AND
    detalle.id_producto = producto.id_producto AND
    venta.id_cliente = cliente.id_cliente
    
    GROUP BY cliente.cliente ;
    
    
----------OTRA FORMA DE HACERLO----------
    
select cliente.id_cliente, cliente.cliente,
	count(distinct venta.id_venta) num_ventas,
    	sum(detalle.cantidad * producto.precio) importe_ventas
    	
from (cliente left join venta using (id_cliente) )
			left join
     (producto join detalle using (id_producto) ) using (id_venta)
     
   group by cliente.id_cliente, cliente.cliente
   having num_ventas = 3 and importe_ventas between 30000 and 45000 ;             


-----6. Número de ventas asignadas a cada transportista-------

SELECT count(*),
       transportista.transportista    

    FROM venta, transportista
    
    WHERE venta.id_transportista = transportista.id_transportista 
    
    GROUP BY transportista.transportista ;
    
    
----------OTRA FORMA DE HACERLO----------

select transportista.id_transportista, transportista.transportista,
	count(*) num_ventas,
    	
	from transportista join venta using (id_transportista) 
     
   	group by transportista.id_transportista, transportista.transportista ;


----------OTRA FORMA DE HACERLO----------

select t.id_transportista, t.transportista,
	count(*) num_ventas
    	
	from transportista t join venta using (id_transportista) 
     
   	group by t.id_transportista, t.transportista ;


------7. Número de clientes en cada municipio---------
    	         	     
SELECT m.municipio,
	count(c.id_cliente) num_cliente

    FROM municipio as m right join cliente as c using (id_municipio)
    
    GROUP BY m.municipio, c.id_cliente ;

----------OTRA FORMA DE HACERLO----------

SELECT m.municipio,
	count(c.id_cliente) num_cliente

    FROM municipio as m left join cliente as c using (id_municipio)
    
    GROUP BY m.municipio, c.id_cliente ;


-------8. Importe vendido en cada municipio--------

SELECT m.municipio,
	sum(d.cantidad * p.precio) importe
    
	FROM municipio m join cliente using (id_municipio)
			 join venta using (id_cliente)
			 join detalle d using (id_venta)
			 join producto p using (id_producto)
			 
	group by m.municipio ;
   
 
---------9. Precio del producto más caro de cada fabricante--------

SELECT	f.fabricante,
	max(p.precio) precio_mas_caro
	
	FROM fabricante as f join producto as p using (id_fabricante)
 
	GROUP BY f.fabricante ;


-------COSULTA POSIBLE PARA VER EL PRODUCTO MAS CARO -------

select f1.fabricante, p.producto, p.precio
	from producto p join fabricante f1 using (id_fabricante)
		join
		( select f2.id_fabricante, 
		  max(p.precio) precio_mas_caro
	       	  from fabricante f2 join producto p using (id_fabricante)
		  group by f2.id_fabricante ) fp
		  on f1.id_fabricante=fp.id_fabricante and 
		  p.precio = fp.precio_mas_caro ;


--------10.Número e importe de los productos vendidos de cada categoría-------







--------11. Número e importe de los productos vendidos de cada fabricante-------






-------12. Categoría e importe de productos vendidos-----------














  

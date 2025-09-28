select cliente.id_cliente, cliente.cliente,
	count(distinct venta.id_venta) num_ventas,
    	sum(detalle.cantidad * producto.precio) importe_ventas
	from (cliente join venta using (id_cliente) )
			left join
    	     (producto join detalle using (id_producto) ) using (id_venta)
   	group by cliente.id_cliente, cliente.cliente
   	having num_ventas = 3 and importe_ventas between 30000 and 45000 ;
   	
   ----> HAVING se usa para buscar el valor exacto que deseemos




select t.id_transportista, t.transportista,
	count(*) num_ventas
    	
	from transportista t join venta using (id_transportista) 
     
   	group by t.id_transportista, t.transportista ;
    ----->t lo usamos como reduccion de la palabra transportista, lo podemos usar con cualquier palabra
    
    
    
    
SELECT sum(detalle.cantidad * producto.precio) importe
    
	FROM detalle join producto using (id_producto) ;
   ------> IMPORTE TOTAL
   
  
select f1.fabricante, p.producto, p.precio
	from producto p join fabricante f1 using (id_fabricante)
		join
		( select f2.id_fabricante, 
		  max(p.precio) precio_mas_caro
	       	  from fabricante f2 join producto p using (id_fabricante)
		  group by f2.id_fabricante ) fp
		  on f1.id_fabricante=fp.id_fabricante and 
		  p.precio = fp.precio_mas_caro ;

   


--------1. ¿Cuál es la venta de mayor importe? De dicha venta, obtén el empleado, transportista, cliente y municipio-------


select venta.id_venta, venta.fecha, 
	empleado, transportista,
	cliente, municipio, chulo.importe
	from (select venta.id_venta,
		sum(cantidad * precio) importe
		from venta join detalle using (id_venta)
			join producto using (id_producto)
		group by venta.id_venta
		order by importe desc	
		limit 1 ) chulo join venta using (id_venta)
			join empleado using (id_empleado)
			join transportista using (id_transportista)
			join cliente using (id_cliente)
			join municipio using (id_municipio) ;
			
	
	
---------------OTRA FORMA DE HACERLO------------------

select venta.id_venta, venta.fecha, 
	transportista, empleado,
	cliente, municipio,
	sum(cantidad * precio) importe
	from venta join detalle using (id_venta)
		join producto using (id_producto)
		join empleado using (id_empleado)
		join transportista using (id_transportista)
		join cliente using (id_cliente)
		join municipio using (id_municipio) 	
	group by venta.id_venta, venta.fecha, 
	transportista, empleado,
	cliente, municipio 
		having importe = (select max(importe)
			from (select venta.id_venta,
			sum(cantidad * precio) importe
			from venta join detalle using (id_venta)
				join producto using (id_producto)
			group by venta.id_venta) as bean) ;




-------2. Importe promedio de las ventas.-----

SELECT avg(cantidad * precio) importe_medio
	FROM detalle join producto using (id_producto) ;
	

-------3. Listado con id_venta, fecha, empleado, transportista, cliente y municipio de las ventas con importe superior al promedio de ventas---------


select venta.id_venta, venta.fecha,
	transportista, empleado,
	cliente, municipio,
	sum(cantidad * precio) importe
	from venta join detalle using (id_venta)
		join producto using (id_producto)
		join transportista using (id_transportista)
		join empleado using (id_empleado)
		join cliente using (id_cliente)
		join municipio using (id_municipio) 	
	group by venta.id_venta, venta.fecha, 
	transportista, empleado,
	cliente, municipio 
   	having importe > (select avg(importe)
   			from (SELECT avg(cantidad * precio) importe_medio
			FROM detalle join producto using (id_producto)
			group by venta.id_venta) bean) ; 




select venta.id_venta, venta.fecha,
	transportista, empleado,
	cliente, municipio,
	sum(cantidad * precio) importe
	from venta join detalle using (id_venta)
		join producto using (id_producto)
		join transportista using (id_transportista)
		join empleado using (id_empleado)
		join cliente using (id_cliente)
		join municipio using (id_municipio) 	
	group by venta.id_venta, venta.fecha, 
	transportista, empleado,
	cliente, municipio 
   	having importe > (select max(cantidad * precio)
   			from (SELECT avg(cantidad * precio) importe_medio
			FROM detalle join producto using (id_producto)
			group by venta.id_venta) bean) ; 
























